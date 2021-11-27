
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	88813103          	ld	sp,-1912(sp) # 8000b888 <_GLOBAL_OFFSET_TABLE_+0x8>
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
    800001d4:	7ff78793          	addi	a5,a5,2047 # ffffffffffffe7ff <end+0xffffffff7ffd57ff>
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
    800001fe:	5fc78793          	addi	a5,a5,1532 # 800017f6 <main>
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
    800002e8:	d5c70713          	addi	a4,a4,-676 # 80014040 <timer_scratch>
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
    8000032c:	88878793          	addi	a5,a5,-1912 # 80008bb0 <timervec>
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
    80000398:	aac080e7          	jalr	-1364(ra) # 80000e40 <uartputc_sync>
    8000039c:	02000513          	li	a0,32
    800003a0:	00001097          	auipc	ra,0x1
    800003a4:	aa0080e7          	jalr	-1376(ra) # 80000e40 <uartputc_sync>
    800003a8:	4521                	li	a0,8
    800003aa:	00001097          	auipc	ra,0x1
    800003ae:	a96080e7          	jalr	-1386(ra) # 80000e40 <uartputc_sync>
  } else {
    uartputc_sync(c);
  }
}
    800003b2:	a801                	j	800003c2 <consputc+0x4e>
    uartputc_sync(c);
    800003b4:	fec42783          	lw	a5,-20(s0)
    800003b8:	853e                	mv	a0,a5
    800003ba:	00001097          	auipc	ra,0x1
    800003be:	a86080e7          	jalr	-1402(ra) # 80000e40 <uartputc_sync>
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
    8000040a:	38e080e7          	jalr	910(ra) # 80003794 <either_copyin>
    8000040e:	87aa                	mv	a5,a0
    80000410:	873e                	mv	a4,a5
    80000412:	57fd                	li	a5,-1
    80000414:	02f70863          	beq	a4,a5,80000444 <consolewrite+0x78>
      break;
    uartputc(c);
    80000418:	feb44783          	lbu	a5,-21(s0)
    8000041c:	2781                	sext.w	a5,a5
    8000041e:	853e                	mv	a0,a5
    80000420:	00001097          	auipc	ra,0x1
    80000424:	960080e7          	jalr	-1696(ra) # 80000d80 <uartputc>
  for(i = 0; i < n; i++){
    80000428:	fec42783          	lw	a5,-20(s0)
    8000042c:	2785                	addiw	a5,a5,1
    8000042e:	fef42623          	sw	a5,-20(s0)
    80000432:	fec42703          	lw	a4,-20(s0)
    80000436:	fd842783          	lw	a5,-40(s0)
    8000043a:	2701                	sext.w	a4,a4
    8000043c:	2781                	sext.w	a5,a5
    8000043e:	faf747e3          	blt	a4,a5,800003ec <consolewrite+0x20>
    80000442:	a011                	j	80000446 <consolewrite+0x7a>
      break;
    80000444:	0001                	nop
  }

  return i;
    80000446:	fec42783          	lw	a5,-20(s0)
}
    8000044a:	853e                	mv	a0,a5
    8000044c:	70a2                	ld	ra,40(sp)
    8000044e:	7402                	ld	s0,32(sp)
    80000450:	6145                	addi	sp,sp,48
    80000452:	8082                	ret

0000000080000454 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000454:	7179                	addi	sp,sp,-48
    80000456:	f406                	sd	ra,40(sp)
    80000458:	f022                	sd	s0,32(sp)
    8000045a:	1800                	addi	s0,sp,48
    8000045c:	87aa                	mv	a5,a0
    8000045e:	fcb43823          	sd	a1,-48(s0)
    80000462:	8732                	mv	a4,a2
    80000464:	fcf42e23          	sw	a5,-36(s0)
    80000468:	87ba                	mv	a5,a4
    8000046a:	fcf42c23          	sw	a5,-40(s0)
  uint target;
  int c;
  char cbuf;

  target = n;
    8000046e:	fd842783          	lw	a5,-40(s0)
    80000472:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    80000476:	00014517          	auipc	a0,0x14
    8000047a:	d0a50513          	addi	a0,a0,-758 # 80014180 <cons>
    8000047e:	00001097          	auipc	ra,0x1
    80000482:	df0080e7          	jalr	-528(ra) # 8000126e <acquire>
  while(n > 0){
    80000486:	a215                	j	800005aa <consoleread+0x156>
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
      if(myproc()->killed){
    80000488:	00002097          	auipc	ra,0x2
    8000048c:	38c080e7          	jalr	908(ra) # 80002814 <myproc>
    80000490:	87aa                	mv	a5,a0
    80000492:	579c                	lw	a5,40(a5)
    80000494:	cb99                	beqz	a5,800004aa <consoleread+0x56>
        release(&cons.lock);
    80000496:	00014517          	auipc	a0,0x14
    8000049a:	cea50513          	addi	a0,a0,-790 # 80014180 <cons>
    8000049e:	00001097          	auipc	ra,0x1
    800004a2:	e34080e7          	jalr	-460(ra) # 800012d2 <release>
        return -1;
    800004a6:	57fd                	li	a5,-1
    800004a8:	aa25                	j	800005e0 <consoleread+0x18c>
      }
      sleep(&cons.r, &cons.lock);
    800004aa:	00014597          	auipc	a1,0x14
    800004ae:	cd658593          	addi	a1,a1,-810 # 80014180 <cons>
    800004b2:	00014517          	auipc	a0,0x14
    800004b6:	d6650513          	addi	a0,a0,-666 # 80014218 <cons+0x98>
    800004ba:	00003097          	auipc	ra,0x3
    800004be:	026080e7          	jalr	38(ra) # 800034e0 <sleep>
    while(cons.r == cons.w){
    800004c2:	00014797          	auipc	a5,0x14
    800004c6:	cbe78793          	addi	a5,a5,-834 # 80014180 <cons>
    800004ca:	0987a703          	lw	a4,152(a5)
    800004ce:	00014797          	auipc	a5,0x14
    800004d2:	cb278793          	addi	a5,a5,-846 # 80014180 <cons>
    800004d6:	09c7a783          	lw	a5,156(a5)
    800004da:	faf707e3          	beq	a4,a5,80000488 <consoleread+0x34>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    800004de:	00014797          	auipc	a5,0x14
    800004e2:	ca278793          	addi	a5,a5,-862 # 80014180 <cons>
    800004e6:	0987a783          	lw	a5,152(a5)
    800004ea:	2781                	sext.w	a5,a5
    800004ec:	0017871b          	addiw	a4,a5,1
    800004f0:	0007069b          	sext.w	a3,a4
    800004f4:	00014717          	auipc	a4,0x14
    800004f8:	c8c70713          	addi	a4,a4,-884 # 80014180 <cons>
    800004fc:	08d72c23          	sw	a3,152(a4)
    80000500:	07f7f793          	andi	a5,a5,127
    80000504:	2781                	sext.w	a5,a5
    80000506:	00014717          	auipc	a4,0x14
    8000050a:	c7a70713          	addi	a4,a4,-902 # 80014180 <cons>
    8000050e:	1782                	slli	a5,a5,0x20
    80000510:	9381                	srli	a5,a5,0x20
    80000512:	97ba                	add	a5,a5,a4
    80000514:	0187c783          	lbu	a5,24(a5)
    80000518:	fef42423          	sw	a5,-24(s0)

    if(c == C('D')){  // end-of-file
    8000051c:	fe842783          	lw	a5,-24(s0)
    80000520:	0007871b          	sext.w	a4,a5
    80000524:	4791                	li	a5,4
    80000526:	02f71963          	bne	a4,a5,80000558 <consoleread+0x104>
      if(n < target){
    8000052a:	fd842703          	lw	a4,-40(s0)
    8000052e:	fec42783          	lw	a5,-20(s0)
    80000532:	2781                	sext.w	a5,a5
    80000534:	08f77163          	bgeu	a4,a5,800005b6 <consoleread+0x162>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        cons.r--;
    80000538:	00014797          	auipc	a5,0x14
    8000053c:	c4878793          	addi	a5,a5,-952 # 80014180 <cons>
    80000540:	0987a783          	lw	a5,152(a5)
    80000544:	37fd                	addiw	a5,a5,-1
    80000546:	0007871b          	sext.w	a4,a5
    8000054a:	00014797          	auipc	a5,0x14
    8000054e:	c3678793          	addi	a5,a5,-970 # 80014180 <cons>
    80000552:	08e7ac23          	sw	a4,152(a5)
      }
      break;
    80000556:	a085                	j	800005b6 <consoleread+0x162>
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80000558:	fe842783          	lw	a5,-24(s0)
    8000055c:	0ff7f793          	andi	a5,a5,255
    80000560:	fef403a3          	sb	a5,-25(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000564:	fe740713          	addi	a4,s0,-25
    80000568:	fdc42783          	lw	a5,-36(s0)
    8000056c:	4685                	li	a3,1
    8000056e:	863a                	mv	a2,a4
    80000570:	fd043583          	ld	a1,-48(s0)
    80000574:	853e                	mv	a0,a5
    80000576:	00003097          	auipc	ra,0x3
    8000057a:	1aa080e7          	jalr	426(ra) # 80003720 <either_copyout>
    8000057e:	87aa                	mv	a5,a0
    80000580:	873e                	mv	a4,a5
    80000582:	57fd                	li	a5,-1
    80000584:	02f70b63          	beq	a4,a5,800005ba <consoleread+0x166>
      break;

    dst++;
    80000588:	fd043783          	ld	a5,-48(s0)
    8000058c:	0785                	addi	a5,a5,1
    8000058e:	fcf43823          	sd	a5,-48(s0)
    --n;
    80000592:	fd842783          	lw	a5,-40(s0)
    80000596:	37fd                	addiw	a5,a5,-1
    80000598:	fcf42c23          	sw	a5,-40(s0)

    if(c == '\n'){
    8000059c:	fe842783          	lw	a5,-24(s0)
    800005a0:	0007871b          	sext.w	a4,a5
    800005a4:	47a9                	li	a5,10
    800005a6:	00f70c63          	beq	a4,a5,800005be <consoleread+0x16a>
  while(n > 0){
    800005aa:	fd842783          	lw	a5,-40(s0)
    800005ae:	2781                	sext.w	a5,a5
    800005b0:	f0f049e3          	bgtz	a5,800004c2 <consoleread+0x6e>
    800005b4:	a031                	j	800005c0 <consoleread+0x16c>
      break;
    800005b6:	0001                	nop
    800005b8:	a021                	j	800005c0 <consoleread+0x16c>
      break;
    800005ba:	0001                	nop
    800005bc:	a011                	j	800005c0 <consoleread+0x16c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    800005be:	0001                	nop
    }
  }
  release(&cons.lock);
    800005c0:	00014517          	auipc	a0,0x14
    800005c4:	bc050513          	addi	a0,a0,-1088 # 80014180 <cons>
    800005c8:	00001097          	auipc	ra,0x1
    800005cc:	d0a080e7          	jalr	-758(ra) # 800012d2 <release>

  return target - n;
    800005d0:	fd842783          	lw	a5,-40(s0)
    800005d4:	fec42703          	lw	a4,-20(s0)
    800005d8:	40f707bb          	subw	a5,a4,a5
    800005dc:	2781                	sext.w	a5,a5
    800005de:	2781                	sext.w	a5,a5
}
    800005e0:	853e                	mv	a0,a5
    800005e2:	70a2                	ld	ra,40(sp)
    800005e4:	7402                	ld	s0,32(sp)
    800005e6:	6145                	addi	sp,sp,48
    800005e8:	8082                	ret

00000000800005ea <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800005ea:	1101                	addi	sp,sp,-32
    800005ec:	ec06                	sd	ra,24(sp)
    800005ee:	e822                	sd	s0,16(sp)
    800005f0:	1000                	addi	s0,sp,32
    800005f2:	87aa                	mv	a5,a0
    800005f4:	fef42623          	sw	a5,-20(s0)
  acquire(&cons.lock);
    800005f8:	00014517          	auipc	a0,0x14
    800005fc:	b8850513          	addi	a0,a0,-1144 # 80014180 <cons>
    80000600:	00001097          	auipc	ra,0x1
    80000604:	c6e080e7          	jalr	-914(ra) # 8000126e <acquire>

  switch(c){
    80000608:	fec42783          	lw	a5,-20(s0)
    8000060c:	0007871b          	sext.w	a4,a5
    80000610:	07f00793          	li	a5,127
    80000614:	0cf70763          	beq	a4,a5,800006e2 <consoleintr+0xf8>
    80000618:	fec42783          	lw	a5,-20(s0)
    8000061c:	0007871b          	sext.w	a4,a5
    80000620:	07f00793          	li	a5,127
    80000624:	10e7c363          	blt	a5,a4,8000072a <consoleintr+0x140>
    80000628:	fec42783          	lw	a5,-20(s0)
    8000062c:	0007871b          	sext.w	a4,a5
    80000630:	47d5                	li	a5,21
    80000632:	06f70163          	beq	a4,a5,80000694 <consoleintr+0xaa>
    80000636:	fec42783          	lw	a5,-20(s0)
    8000063a:	0007871b          	sext.w	a4,a5
    8000063e:	47d5                	li	a5,21
    80000640:	0ee7c563          	blt	a5,a4,8000072a <consoleintr+0x140>
    80000644:	fec42783          	lw	a5,-20(s0)
    80000648:	0007871b          	sext.w	a4,a5
    8000064c:	47a1                	li	a5,8
    8000064e:	08f70a63          	beq	a4,a5,800006e2 <consoleintr+0xf8>
    80000652:	fec42783          	lw	a5,-20(s0)
    80000656:	0007871b          	sext.w	a4,a5
    8000065a:	47c1                	li	a5,16
    8000065c:	0cf71763          	bne	a4,a5,8000072a <consoleintr+0x140>
  case C('P'):  // Print process list.
    procdump();
    80000660:	00003097          	auipc	ra,0x3
    80000664:	1a8080e7          	jalr	424(ra) # 80003808 <procdump>
    break;
    80000668:	aac1                	j	80000838 <consoleintr+0x24e>
  case C('U'):  // Kill line.
    while(cons.e != cons.w &&
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
      cons.e--;
    8000066a:	00014797          	auipc	a5,0x14
    8000066e:	b1678793          	addi	a5,a5,-1258 # 80014180 <cons>
    80000672:	0a07a783          	lw	a5,160(a5)
    80000676:	37fd                	addiw	a5,a5,-1
    80000678:	0007871b          	sext.w	a4,a5
    8000067c:	00014797          	auipc	a5,0x14
    80000680:	b0478793          	addi	a5,a5,-1276 # 80014180 <cons>
    80000684:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    80000688:	10000513          	li	a0,256
    8000068c:	00000097          	auipc	ra,0x0
    80000690:	ce8080e7          	jalr	-792(ra) # 80000374 <consputc>
    while(cons.e != cons.w &&
    80000694:	00014797          	auipc	a5,0x14
    80000698:	aec78793          	addi	a5,a5,-1300 # 80014180 <cons>
    8000069c:	0a07a703          	lw	a4,160(a5)
    800006a0:	00014797          	auipc	a5,0x14
    800006a4:	ae078793          	addi	a5,a5,-1312 # 80014180 <cons>
    800006a8:	09c7a783          	lw	a5,156(a5)
    800006ac:	18f70163          	beq	a4,a5,8000082e <consoleintr+0x244>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800006b0:	00014797          	auipc	a5,0x14
    800006b4:	ad078793          	addi	a5,a5,-1328 # 80014180 <cons>
    800006b8:	0a07a783          	lw	a5,160(a5)
    800006bc:	37fd                	addiw	a5,a5,-1
    800006be:	2781                	sext.w	a5,a5
    800006c0:	07f7f793          	andi	a5,a5,127
    800006c4:	2781                	sext.w	a5,a5
    800006c6:	00014717          	auipc	a4,0x14
    800006ca:	aba70713          	addi	a4,a4,-1350 # 80014180 <cons>
    800006ce:	1782                	slli	a5,a5,0x20
    800006d0:	9381                	srli	a5,a5,0x20
    800006d2:	97ba                	add	a5,a5,a4
    800006d4:	0187c783          	lbu	a5,24(a5)
    while(cons.e != cons.w &&
    800006d8:	873e                	mv	a4,a5
    800006da:	47a9                	li	a5,10
    800006dc:	f8f717e3          	bne	a4,a5,8000066a <consoleintr+0x80>
    }
    break;
    800006e0:	a2b9                	j	8000082e <consoleintr+0x244>
  case C('H'): // Backspace
  case '\x7f':
    if(cons.e != cons.w){
    800006e2:	00014797          	auipc	a5,0x14
    800006e6:	a9e78793          	addi	a5,a5,-1378 # 80014180 <cons>
    800006ea:	0a07a703          	lw	a4,160(a5)
    800006ee:	00014797          	auipc	a5,0x14
    800006f2:	a9278793          	addi	a5,a5,-1390 # 80014180 <cons>
    800006f6:	09c7a783          	lw	a5,156(a5)
    800006fa:	12f70c63          	beq	a4,a5,80000832 <consoleintr+0x248>
      cons.e--;
    800006fe:	00014797          	auipc	a5,0x14
    80000702:	a8278793          	addi	a5,a5,-1406 # 80014180 <cons>
    80000706:	0a07a783          	lw	a5,160(a5)
    8000070a:	37fd                	addiw	a5,a5,-1
    8000070c:	0007871b          	sext.w	a4,a5
    80000710:	00014797          	auipc	a5,0x14
    80000714:	a7078793          	addi	a5,a5,-1424 # 80014180 <cons>
    80000718:	0ae7a023          	sw	a4,160(a5)
      consputc(BACKSPACE);
    8000071c:	10000513          	li	a0,256
    80000720:	00000097          	auipc	ra,0x0
    80000724:	c54080e7          	jalr	-940(ra) # 80000374 <consputc>
    }
    break;
    80000728:	a229                	j	80000832 <consoleintr+0x248>
  default:
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    8000072a:	fec42783          	lw	a5,-20(s0)
    8000072e:	2781                	sext.w	a5,a5
    80000730:	10078363          	beqz	a5,80000836 <consoleintr+0x24c>
    80000734:	00014797          	auipc	a5,0x14
    80000738:	a4c78793          	addi	a5,a5,-1460 # 80014180 <cons>
    8000073c:	0a07a703          	lw	a4,160(a5)
    80000740:	00014797          	auipc	a5,0x14
    80000744:	a4078793          	addi	a5,a5,-1472 # 80014180 <cons>
    80000748:	0987a783          	lw	a5,152(a5)
    8000074c:	40f707bb          	subw	a5,a4,a5
    80000750:	2781                	sext.w	a5,a5
    80000752:	873e                	mv	a4,a5
    80000754:	07f00793          	li	a5,127
    80000758:	0ce7ef63          	bltu	a5,a4,80000836 <consoleintr+0x24c>
      c = (c == '\r') ? '\n' : c;
    8000075c:	fec42783          	lw	a5,-20(s0)
    80000760:	0007871b          	sext.w	a4,a5
    80000764:	47b5                	li	a5,13
    80000766:	00f70563          	beq	a4,a5,80000770 <consoleintr+0x186>
    8000076a:	fec42783          	lw	a5,-20(s0)
    8000076e:	a011                	j	80000772 <consoleintr+0x188>
    80000770:	47a9                	li	a5,10
    80000772:	fef42623          	sw	a5,-20(s0)

      // echo back to the user.
      consputc(c);
    80000776:	fec42783          	lw	a5,-20(s0)
    8000077a:	853e                	mv	a0,a5
    8000077c:	00000097          	auipc	ra,0x0
    80000780:	bf8080e7          	jalr	-1032(ra) # 80000374 <consputc>

      // store for consumption by consoleread().
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000784:	00014797          	auipc	a5,0x14
    80000788:	9fc78793          	addi	a5,a5,-1540 # 80014180 <cons>
    8000078c:	0a07a783          	lw	a5,160(a5)
    80000790:	2781                	sext.w	a5,a5
    80000792:	0017871b          	addiw	a4,a5,1
    80000796:	0007069b          	sext.w	a3,a4
    8000079a:	00014717          	auipc	a4,0x14
    8000079e:	9e670713          	addi	a4,a4,-1562 # 80014180 <cons>
    800007a2:	0ad72023          	sw	a3,160(a4)
    800007a6:	07f7f793          	andi	a5,a5,127
    800007aa:	2781                	sext.w	a5,a5
    800007ac:	fec42703          	lw	a4,-20(s0)
    800007b0:	0ff77713          	andi	a4,a4,255
    800007b4:	00014697          	auipc	a3,0x14
    800007b8:	9cc68693          	addi	a3,a3,-1588 # 80014180 <cons>
    800007bc:	1782                	slli	a5,a5,0x20
    800007be:	9381                	srli	a5,a5,0x20
    800007c0:	97b6                	add	a5,a5,a3
    800007c2:	00e78c23          	sb	a4,24(a5)

      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    800007c6:	fec42783          	lw	a5,-20(s0)
    800007ca:	0007871b          	sext.w	a4,a5
    800007ce:	47a9                	li	a5,10
    800007d0:	02f70a63          	beq	a4,a5,80000804 <consoleintr+0x21a>
    800007d4:	fec42783          	lw	a5,-20(s0)
    800007d8:	0007871b          	sext.w	a4,a5
    800007dc:	4791                	li	a5,4
    800007de:	02f70363          	beq	a4,a5,80000804 <consoleintr+0x21a>
    800007e2:	00014797          	auipc	a5,0x14
    800007e6:	99e78793          	addi	a5,a5,-1634 # 80014180 <cons>
    800007ea:	0a07a703          	lw	a4,160(a5)
    800007ee:	00014797          	auipc	a5,0x14
    800007f2:	99278793          	addi	a5,a5,-1646 # 80014180 <cons>
    800007f6:	0987a783          	lw	a5,152(a5)
    800007fa:	0807879b          	addiw	a5,a5,128
    800007fe:	2781                	sext.w	a5,a5
    80000800:	02f71b63          	bne	a4,a5,80000836 <consoleintr+0x24c>
        // wake up consoleread() if a whole line (or end-of-file)
        // has arrived.
        cons.w = cons.e;
    80000804:	00014797          	auipc	a5,0x14
    80000808:	97c78793          	addi	a5,a5,-1668 # 80014180 <cons>
    8000080c:	0a07a703          	lw	a4,160(a5)
    80000810:	00014797          	auipc	a5,0x14
    80000814:	97078793          	addi	a5,a5,-1680 # 80014180 <cons>
    80000818:	08e7ae23          	sw	a4,156(a5)
        wakeup(&cons.r);
    8000081c:	00014517          	auipc	a0,0x14
    80000820:	9fc50513          	addi	a0,a0,-1540 # 80014218 <cons+0x98>
    80000824:	00003097          	auipc	ra,0x3
    80000828:	d80080e7          	jalr	-640(ra) # 800035a4 <wakeup>
      }
    }
    break;
    8000082c:	a029                	j	80000836 <consoleintr+0x24c>
    break;
    8000082e:	0001                	nop
    80000830:	a021                	j	80000838 <consoleintr+0x24e>
    break;
    80000832:	0001                	nop
    80000834:	a011                	j	80000838 <consoleintr+0x24e>
    break;
    80000836:	0001                	nop
  }
  
  release(&cons.lock);
    80000838:	00014517          	auipc	a0,0x14
    8000083c:	94850513          	addi	a0,a0,-1720 # 80014180 <cons>
    80000840:	00001097          	auipc	ra,0x1
    80000844:	a92080e7          	jalr	-1390(ra) # 800012d2 <release>
}
    80000848:	0001                	nop
    8000084a:	60e2                	ld	ra,24(sp)
    8000084c:	6442                	ld	s0,16(sp)
    8000084e:	6105                	addi	sp,sp,32
    80000850:	8082                	ret

0000000080000852 <consoleinit>:

void
consoleinit(void)
{
    80000852:	1141                	addi	sp,sp,-16
    80000854:	e406                	sd	ra,8(sp)
    80000856:	e022                	sd	s0,0(sp)
    80000858:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    8000085a:	0000a597          	auipc	a1,0xa
    8000085e:	7a658593          	addi	a1,a1,1958 # 8000b000 <etext>
    80000862:	00014517          	auipc	a0,0x14
    80000866:	91e50513          	addi	a0,a0,-1762 # 80014180 <cons>
    8000086a:	00001097          	auipc	ra,0x1
    8000086e:	9d4080e7          	jalr	-1580(ra) # 8000123e <initlock>

  uartinit();
    80000872:	00000097          	auipc	ra,0x0
    80000876:	494080e7          	jalr	1172(ra) # 80000d06 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    8000087a:	00024797          	auipc	a5,0x24
    8000087e:	cbe78793          	addi	a5,a5,-834 # 80024538 <devsw>
    80000882:	00000717          	auipc	a4,0x0
    80000886:	bd270713          	addi	a4,a4,-1070 # 80000454 <consoleread>
    8000088a:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    8000088c:	00024797          	auipc	a5,0x24
    80000890:	cac78793          	addi	a5,a5,-852 # 80024538 <devsw>
    80000894:	00000717          	auipc	a4,0x0
    80000898:	b3870713          	addi	a4,a4,-1224 # 800003cc <consolewrite>
    8000089c:	ef98                	sd	a4,24(a5)
}
    8000089e:	0001                	nop
    800008a0:	60a2                	ld	ra,8(sp)
    800008a2:	6402                	ld	s0,0(sp)
    800008a4:	0141                	addi	sp,sp,16
    800008a6:	8082                	ret

00000000800008a8 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    800008a8:	7139                	addi	sp,sp,-64
    800008aa:	fc06                	sd	ra,56(sp)
    800008ac:	f822                	sd	s0,48(sp)
    800008ae:	0080                	addi	s0,sp,64
    800008b0:	87aa                	mv	a5,a0
    800008b2:	86ae                	mv	a3,a1
    800008b4:	8732                	mv	a4,a2
    800008b6:	fcf42623          	sw	a5,-52(s0)
    800008ba:	87b6                	mv	a5,a3
    800008bc:	fcf42423          	sw	a5,-56(s0)
    800008c0:	87ba                	mv	a5,a4
    800008c2:	fcf42223          	sw	a5,-60(s0)
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800008c6:	fc442783          	lw	a5,-60(s0)
    800008ca:	2781                	sext.w	a5,a5
    800008cc:	c78d                	beqz	a5,800008f6 <printint+0x4e>
    800008ce:	fcc42783          	lw	a5,-52(s0)
    800008d2:	01f7d79b          	srliw	a5,a5,0x1f
    800008d6:	0ff7f793          	andi	a5,a5,255
    800008da:	fcf42223          	sw	a5,-60(s0)
    800008de:	fc442783          	lw	a5,-60(s0)
    800008e2:	2781                	sext.w	a5,a5
    800008e4:	cb89                	beqz	a5,800008f6 <printint+0x4e>
    x = -xx;
    800008e6:	fcc42783          	lw	a5,-52(s0)
    800008ea:	40f007bb          	negw	a5,a5
    800008ee:	2781                	sext.w	a5,a5
    800008f0:	fef42423          	sw	a5,-24(s0)
    800008f4:	a029                	j	800008fe <printint+0x56>
  else
    x = xx;
    800008f6:	fcc42783          	lw	a5,-52(s0)
    800008fa:	fef42423          	sw	a5,-24(s0)

  i = 0;
    800008fe:	fe042623          	sw	zero,-20(s0)
  do {
    buf[i++] = digits[x % base];
    80000902:	fc842783          	lw	a5,-56(s0)
    80000906:	fe842703          	lw	a4,-24(s0)
    8000090a:	02f777bb          	remuw	a5,a4,a5
    8000090e:	0007861b          	sext.w	a2,a5
    80000912:	fec42783          	lw	a5,-20(s0)
    80000916:	0017871b          	addiw	a4,a5,1
    8000091a:	fee42623          	sw	a4,-20(s0)
    8000091e:	0000b697          	auipc	a3,0xb
    80000922:	e2268693          	addi	a3,a3,-478 # 8000b740 <digits>
    80000926:	02061713          	slli	a4,a2,0x20
    8000092a:	9301                	srli	a4,a4,0x20
    8000092c:	9736                	add	a4,a4,a3
    8000092e:	00074703          	lbu	a4,0(a4)
    80000932:	ff040693          	addi	a3,s0,-16
    80000936:	97b6                	add	a5,a5,a3
    80000938:	fee78423          	sb	a4,-24(a5)
  } while((x /= base) != 0);
    8000093c:	fc842783          	lw	a5,-56(s0)
    80000940:	fe842703          	lw	a4,-24(s0)
    80000944:	02f757bb          	divuw	a5,a4,a5
    80000948:	fef42423          	sw	a5,-24(s0)
    8000094c:	fe842783          	lw	a5,-24(s0)
    80000950:	2781                	sext.w	a5,a5
    80000952:	fbc5                	bnez	a5,80000902 <printint+0x5a>

  if(sign)
    80000954:	fc442783          	lw	a5,-60(s0)
    80000958:	2781                	sext.w	a5,a5
    8000095a:	cf85                	beqz	a5,80000992 <printint+0xea>
    buf[i++] = '-';
    8000095c:	fec42783          	lw	a5,-20(s0)
    80000960:	0017871b          	addiw	a4,a5,1
    80000964:	fee42623          	sw	a4,-20(s0)
    80000968:	ff040713          	addi	a4,s0,-16
    8000096c:	97ba                	add	a5,a5,a4
    8000096e:	02d00713          	li	a4,45
    80000972:	fee78423          	sb	a4,-24(a5)

  while(--i >= 0)
    80000976:	a831                	j	80000992 <printint+0xea>
    consputc(buf[i]);
    80000978:	fec42783          	lw	a5,-20(s0)
    8000097c:	ff040713          	addi	a4,s0,-16
    80000980:	97ba                	add	a5,a5,a4
    80000982:	fe87c783          	lbu	a5,-24(a5)
    80000986:	2781                	sext.w	a5,a5
    80000988:	853e                	mv	a0,a5
    8000098a:	00000097          	auipc	ra,0x0
    8000098e:	9ea080e7          	jalr	-1558(ra) # 80000374 <consputc>
  while(--i >= 0)
    80000992:	fec42783          	lw	a5,-20(s0)
    80000996:	37fd                	addiw	a5,a5,-1
    80000998:	fef42623          	sw	a5,-20(s0)
    8000099c:	fec42783          	lw	a5,-20(s0)
    800009a0:	2781                	sext.w	a5,a5
    800009a2:	fc07dbe3          	bgez	a5,80000978 <printint+0xd0>
}
    800009a6:	0001                	nop
    800009a8:	0001                	nop
    800009aa:	70e2                	ld	ra,56(sp)
    800009ac:	7442                	ld	s0,48(sp)
    800009ae:	6121                	addi	sp,sp,64
    800009b0:	8082                	ret

00000000800009b2 <printptr>:

static void
printptr(uint64 x)
{
    800009b2:	7179                	addi	sp,sp,-48
    800009b4:	f406                	sd	ra,40(sp)
    800009b6:	f022                	sd	s0,32(sp)
    800009b8:	1800                	addi	s0,sp,48
    800009ba:	fca43c23          	sd	a0,-40(s0)
  int i;
  consputc('0');
    800009be:	03000513          	li	a0,48
    800009c2:	00000097          	auipc	ra,0x0
    800009c6:	9b2080e7          	jalr	-1614(ra) # 80000374 <consputc>
  consputc('x');
    800009ca:	07800513          	li	a0,120
    800009ce:	00000097          	auipc	ra,0x0
    800009d2:	9a6080e7          	jalr	-1626(ra) # 80000374 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009d6:	fe042623          	sw	zero,-20(s0)
    800009da:	a81d                	j	80000a10 <printptr+0x5e>
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800009dc:	fd843783          	ld	a5,-40(s0)
    800009e0:	93f1                	srli	a5,a5,0x3c
    800009e2:	0000b717          	auipc	a4,0xb
    800009e6:	d5e70713          	addi	a4,a4,-674 # 8000b740 <digits>
    800009ea:	97ba                	add	a5,a5,a4
    800009ec:	0007c783          	lbu	a5,0(a5)
    800009f0:	2781                	sext.w	a5,a5
    800009f2:	853e                	mv	a0,a5
    800009f4:	00000097          	auipc	ra,0x0
    800009f8:	980080e7          	jalr	-1664(ra) # 80000374 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800009fc:	fec42783          	lw	a5,-20(s0)
    80000a00:	2785                	addiw	a5,a5,1
    80000a02:	fef42623          	sw	a5,-20(s0)
    80000a06:	fd843783          	ld	a5,-40(s0)
    80000a0a:	0792                	slli	a5,a5,0x4
    80000a0c:	fcf43c23          	sd	a5,-40(s0)
    80000a10:	fec42783          	lw	a5,-20(s0)
    80000a14:	873e                	mv	a4,a5
    80000a16:	47bd                	li	a5,15
    80000a18:	fce7f2e3          	bgeu	a5,a4,800009dc <printptr+0x2a>
}
    80000a1c:	0001                	nop
    80000a1e:	0001                	nop
    80000a20:	70a2                	ld	ra,40(sp)
    80000a22:	7402                	ld	s0,32(sp)
    80000a24:	6145                	addi	sp,sp,48
    80000a26:	8082                	ret

0000000080000a28 <printf>:

// Print to the console. only understands %d, %x, %p, %s.
void
printf(char *fmt, ...)
{
    80000a28:	7119                	addi	sp,sp,-128
    80000a2a:	fc06                	sd	ra,56(sp)
    80000a2c:	f822                	sd	s0,48(sp)
    80000a2e:	0080                	addi	s0,sp,64
    80000a30:	fca43423          	sd	a0,-56(s0)
    80000a34:	e40c                	sd	a1,8(s0)
    80000a36:	e810                	sd	a2,16(s0)
    80000a38:	ec14                	sd	a3,24(s0)
    80000a3a:	f018                	sd	a4,32(s0)
    80000a3c:	f41c                	sd	a5,40(s0)
    80000a3e:	03043823          	sd	a6,48(s0)
    80000a42:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, c, locking;
  char *s;

  locking = pr.locking;
    80000a46:	00013797          	auipc	a5,0x13
    80000a4a:	7e278793          	addi	a5,a5,2018 # 80014228 <pr>
    80000a4e:	4f9c                	lw	a5,24(a5)
    80000a50:	fcf42e23          	sw	a5,-36(s0)
  if(locking)
    80000a54:	fdc42783          	lw	a5,-36(s0)
    80000a58:	2781                	sext.w	a5,a5
    80000a5a:	cb89                	beqz	a5,80000a6c <printf+0x44>
    acquire(&pr.lock);
    80000a5c:	00013517          	auipc	a0,0x13
    80000a60:	7cc50513          	addi	a0,a0,1996 # 80014228 <pr>
    80000a64:	00001097          	auipc	ra,0x1
    80000a68:	80a080e7          	jalr	-2038(ra) # 8000126e <acquire>

  if (fmt == 0)
    80000a6c:	fc843783          	ld	a5,-56(s0)
    80000a70:	eb89                	bnez	a5,80000a82 <printf+0x5a>
    panic("null fmt");
    80000a72:	0000a517          	auipc	a0,0xa
    80000a76:	59650513          	addi	a0,a0,1430 # 8000b008 <etext+0x8>
    80000a7a:	00000097          	auipc	ra,0x0
    80000a7e:	204080e7          	jalr	516(ra) # 80000c7e <panic>

  va_start(ap, fmt);
    80000a82:	04040793          	addi	a5,s0,64
    80000a86:	fcf43023          	sd	a5,-64(s0)
    80000a8a:	fc043783          	ld	a5,-64(s0)
    80000a8e:	fc878793          	addi	a5,a5,-56
    80000a92:	fcf43823          	sd	a5,-48(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000a96:	fe042623          	sw	zero,-20(s0)
    80000a9a:	a24d                	j	80000c3c <printf+0x214>
    if(c != '%'){
    80000a9c:	fd842783          	lw	a5,-40(s0)
    80000aa0:	0007871b          	sext.w	a4,a5
    80000aa4:	02500793          	li	a5,37
    80000aa8:	00f70a63          	beq	a4,a5,80000abc <printf+0x94>
      consputc(c);
    80000aac:	fd842783          	lw	a5,-40(s0)
    80000ab0:	853e                	mv	a0,a5
    80000ab2:	00000097          	auipc	ra,0x0
    80000ab6:	8c2080e7          	jalr	-1854(ra) # 80000374 <consputc>
      continue;
    80000aba:	aaa5                	j	80000c32 <printf+0x20a>
    }
    c = fmt[++i] & 0xff;
    80000abc:	fec42783          	lw	a5,-20(s0)
    80000ac0:	2785                	addiw	a5,a5,1
    80000ac2:	fef42623          	sw	a5,-20(s0)
    80000ac6:	fec42783          	lw	a5,-20(s0)
    80000aca:	fc843703          	ld	a4,-56(s0)
    80000ace:	97ba                	add	a5,a5,a4
    80000ad0:	0007c783          	lbu	a5,0(a5)
    80000ad4:	fcf42c23          	sw	a5,-40(s0)
    if(c == 0)
    80000ad8:	fd842783          	lw	a5,-40(s0)
    80000adc:	2781                	sext.w	a5,a5
    80000ade:	16078e63          	beqz	a5,80000c5a <printf+0x232>
      break;
    switch(c){
    80000ae2:	fd842783          	lw	a5,-40(s0)
    80000ae6:	0007871b          	sext.w	a4,a5
    80000aea:	07800793          	li	a5,120
    80000aee:	08f70963          	beq	a4,a5,80000b80 <printf+0x158>
    80000af2:	fd842783          	lw	a5,-40(s0)
    80000af6:	0007871b          	sext.w	a4,a5
    80000afa:	07800793          	li	a5,120
    80000afe:	10e7cc63          	blt	a5,a4,80000c16 <printf+0x1ee>
    80000b02:	fd842783          	lw	a5,-40(s0)
    80000b06:	0007871b          	sext.w	a4,a5
    80000b0a:	07300793          	li	a5,115
    80000b0e:	0af70563          	beq	a4,a5,80000bb8 <printf+0x190>
    80000b12:	fd842783          	lw	a5,-40(s0)
    80000b16:	0007871b          	sext.w	a4,a5
    80000b1a:	07300793          	li	a5,115
    80000b1e:	0ee7cc63          	blt	a5,a4,80000c16 <printf+0x1ee>
    80000b22:	fd842783          	lw	a5,-40(s0)
    80000b26:	0007871b          	sext.w	a4,a5
    80000b2a:	07000793          	li	a5,112
    80000b2e:	06f70863          	beq	a4,a5,80000b9e <printf+0x176>
    80000b32:	fd842783          	lw	a5,-40(s0)
    80000b36:	0007871b          	sext.w	a4,a5
    80000b3a:	07000793          	li	a5,112
    80000b3e:	0ce7cc63          	blt	a5,a4,80000c16 <printf+0x1ee>
    80000b42:	fd842783          	lw	a5,-40(s0)
    80000b46:	0007871b          	sext.w	a4,a5
    80000b4a:	02500793          	li	a5,37
    80000b4e:	0af70d63          	beq	a4,a5,80000c08 <printf+0x1e0>
    80000b52:	fd842783          	lw	a5,-40(s0)
    80000b56:	0007871b          	sext.w	a4,a5
    80000b5a:	06400793          	li	a5,100
    80000b5e:	0af71c63          	bne	a4,a5,80000c16 <printf+0x1ee>
    case 'd':
      printint(va_arg(ap, int), 10, 1);
    80000b62:	fd043783          	ld	a5,-48(s0)
    80000b66:	00878713          	addi	a4,a5,8
    80000b6a:	fce43823          	sd	a4,-48(s0)
    80000b6e:	439c                	lw	a5,0(a5)
    80000b70:	4605                	li	a2,1
    80000b72:	45a9                	li	a1,10
    80000b74:	853e                	mv	a0,a5
    80000b76:	00000097          	auipc	ra,0x0
    80000b7a:	d32080e7          	jalr	-718(ra) # 800008a8 <printint>
      break;
    80000b7e:	a855                	j	80000c32 <printf+0x20a>
    case 'x':
      printint(va_arg(ap, int), 16, 1);
    80000b80:	fd043783          	ld	a5,-48(s0)
    80000b84:	00878713          	addi	a4,a5,8
    80000b88:	fce43823          	sd	a4,-48(s0)
    80000b8c:	439c                	lw	a5,0(a5)
    80000b8e:	4605                	li	a2,1
    80000b90:	45c1                	li	a1,16
    80000b92:	853e                	mv	a0,a5
    80000b94:	00000097          	auipc	ra,0x0
    80000b98:	d14080e7          	jalr	-748(ra) # 800008a8 <printint>
      break;
    80000b9c:	a859                	j	80000c32 <printf+0x20a>
    case 'p':
      printptr(va_arg(ap, uint64));
    80000b9e:	fd043783          	ld	a5,-48(s0)
    80000ba2:	00878713          	addi	a4,a5,8
    80000ba6:	fce43823          	sd	a4,-48(s0)
    80000baa:	639c                	ld	a5,0(a5)
    80000bac:	853e                	mv	a0,a5
    80000bae:	00000097          	auipc	ra,0x0
    80000bb2:	e04080e7          	jalr	-508(ra) # 800009b2 <printptr>
      break;
    80000bb6:	a8b5                	j	80000c32 <printf+0x20a>
    case 's':
      if((s = va_arg(ap, char*)) == 0)
    80000bb8:	fd043783          	ld	a5,-48(s0)
    80000bbc:	00878713          	addi	a4,a5,8
    80000bc0:	fce43823          	sd	a4,-48(s0)
    80000bc4:	639c                	ld	a5,0(a5)
    80000bc6:	fef43023          	sd	a5,-32(s0)
    80000bca:	fe043783          	ld	a5,-32(s0)
    80000bce:	e79d                	bnez	a5,80000bfc <printf+0x1d4>
        s = "(null)";
    80000bd0:	0000a797          	auipc	a5,0xa
    80000bd4:	44878793          	addi	a5,a5,1096 # 8000b018 <etext+0x18>
    80000bd8:	fef43023          	sd	a5,-32(s0)
      for(; *s; s++)
    80000bdc:	a005                	j	80000bfc <printf+0x1d4>
        consputc(*s);
    80000bde:	fe043783          	ld	a5,-32(s0)
    80000be2:	0007c783          	lbu	a5,0(a5)
    80000be6:	2781                	sext.w	a5,a5
    80000be8:	853e                	mv	a0,a5
    80000bea:	fffff097          	auipc	ra,0xfffff
    80000bee:	78a080e7          	jalr	1930(ra) # 80000374 <consputc>
      for(; *s; s++)
    80000bf2:	fe043783          	ld	a5,-32(s0)
    80000bf6:	0785                	addi	a5,a5,1
    80000bf8:	fef43023          	sd	a5,-32(s0)
    80000bfc:	fe043783          	ld	a5,-32(s0)
    80000c00:	0007c783          	lbu	a5,0(a5)
    80000c04:	ffe9                	bnez	a5,80000bde <printf+0x1b6>
      break;
    80000c06:	a035                	j	80000c32 <printf+0x20a>
    case '%':
      consputc('%');
    80000c08:	02500513          	li	a0,37
    80000c0c:	fffff097          	auipc	ra,0xfffff
    80000c10:	768080e7          	jalr	1896(ra) # 80000374 <consputc>
      break;
    80000c14:	a839                	j	80000c32 <printf+0x20a>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
    80000c16:	02500513          	li	a0,37
    80000c1a:	fffff097          	auipc	ra,0xfffff
    80000c1e:	75a080e7          	jalr	1882(ra) # 80000374 <consputc>
      consputc(c);
    80000c22:	fd842783          	lw	a5,-40(s0)
    80000c26:	853e                	mv	a0,a5
    80000c28:	fffff097          	auipc	ra,0xfffff
    80000c2c:	74c080e7          	jalr	1868(ra) # 80000374 <consputc>
      break;
    80000c30:	0001                	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80000c32:	fec42783          	lw	a5,-20(s0)
    80000c36:	2785                	addiw	a5,a5,1
    80000c38:	fef42623          	sw	a5,-20(s0)
    80000c3c:	fec42783          	lw	a5,-20(s0)
    80000c40:	fc843703          	ld	a4,-56(s0)
    80000c44:	97ba                	add	a5,a5,a4
    80000c46:	0007c783          	lbu	a5,0(a5)
    80000c4a:	fcf42c23          	sw	a5,-40(s0)
    80000c4e:	fd842783          	lw	a5,-40(s0)
    80000c52:	2781                	sext.w	a5,a5
    80000c54:	e40794e3          	bnez	a5,80000a9c <printf+0x74>
    80000c58:	a011                	j	80000c5c <printf+0x234>
      break;
    80000c5a:	0001                	nop
    }
  }

  if(locking)
    80000c5c:	fdc42783          	lw	a5,-36(s0)
    80000c60:	2781                	sext.w	a5,a5
    80000c62:	cb89                	beqz	a5,80000c74 <printf+0x24c>
    release(&pr.lock);
    80000c64:	00013517          	auipc	a0,0x13
    80000c68:	5c450513          	addi	a0,a0,1476 # 80014228 <pr>
    80000c6c:	00000097          	auipc	ra,0x0
    80000c70:	666080e7          	jalr	1638(ra) # 800012d2 <release>
}
    80000c74:	0001                	nop
    80000c76:	70e2                	ld	ra,56(sp)
    80000c78:	7442                	ld	s0,48(sp)
    80000c7a:	6109                	addi	sp,sp,128
    80000c7c:	8082                	ret

0000000080000c7e <panic>:

void
panic(char *s)
{
    80000c7e:	1101                	addi	sp,sp,-32
    80000c80:	ec06                	sd	ra,24(sp)
    80000c82:	e822                	sd	s0,16(sp)
    80000c84:	1000                	addi	s0,sp,32
    80000c86:	fea43423          	sd	a0,-24(s0)
  pr.locking = 0;
    80000c8a:	00013797          	auipc	a5,0x13
    80000c8e:	59e78793          	addi	a5,a5,1438 # 80014228 <pr>
    80000c92:	0007ac23          	sw	zero,24(a5)
  printf("panic: ");
    80000c96:	0000a517          	auipc	a0,0xa
    80000c9a:	38a50513          	addi	a0,a0,906 # 8000b020 <etext+0x20>
    80000c9e:	00000097          	auipc	ra,0x0
    80000ca2:	d8a080e7          	jalr	-630(ra) # 80000a28 <printf>
  printf(s);
    80000ca6:	fe843503          	ld	a0,-24(s0)
    80000caa:	00000097          	auipc	ra,0x0
    80000cae:	d7e080e7          	jalr	-642(ra) # 80000a28 <printf>
  printf("\n");
    80000cb2:	0000a517          	auipc	a0,0xa
    80000cb6:	37650513          	addi	a0,a0,886 # 8000b028 <etext+0x28>
    80000cba:	00000097          	auipc	ra,0x0
    80000cbe:	d6e080e7          	jalr	-658(ra) # 80000a28 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000cc2:	0000b797          	auipc	a5,0xb
    80000cc6:	33e78793          	addi	a5,a5,830 # 8000c000 <panicked>
    80000cca:	4705                	li	a4,1
    80000ccc:	c398                	sw	a4,0(a5)
  for(;;)
    80000cce:	a001                	j	80000cce <panic+0x50>

0000000080000cd0 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000cd0:	1141                	addi	sp,sp,-16
    80000cd2:	e406                	sd	ra,8(sp)
    80000cd4:	e022                	sd	s0,0(sp)
    80000cd6:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80000cd8:	0000a597          	auipc	a1,0xa
    80000cdc:	35858593          	addi	a1,a1,856 # 8000b030 <etext+0x30>
    80000ce0:	00013517          	auipc	a0,0x13
    80000ce4:	54850513          	addi	a0,a0,1352 # 80014228 <pr>
    80000ce8:	00000097          	auipc	ra,0x0
    80000cec:	556080e7          	jalr	1366(ra) # 8000123e <initlock>
  pr.locking = 1;
    80000cf0:	00013797          	auipc	a5,0x13
    80000cf4:	53878793          	addi	a5,a5,1336 # 80014228 <pr>
    80000cf8:	4705                	li	a4,1
    80000cfa:	cf98                	sw	a4,24(a5)
}
    80000cfc:	0001                	nop
    80000cfe:	60a2                	ld	ra,8(sp)
    80000d00:	6402                	ld	s0,0(sp)
    80000d02:	0141                	addi	sp,sp,16
    80000d04:	8082                	ret

0000000080000d06 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000d06:	1141                	addi	sp,sp,-16
    80000d08:	e406                	sd	ra,8(sp)
    80000d0a:	e022                	sd	s0,0(sp)
    80000d0c:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80000d0e:	100007b7          	lui	a5,0x10000
    80000d12:	0785                	addi	a5,a5,1
    80000d14:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80000d18:	100007b7          	lui	a5,0x10000
    80000d1c:	078d                	addi	a5,a5,3
    80000d1e:	f8000713          	li	a4,-128
    80000d22:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80000d26:	100007b7          	lui	a5,0x10000
    80000d2a:	470d                	li	a4,3
    80000d2c:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80000d30:	100007b7          	lui	a5,0x10000
    80000d34:	0785                	addi	a5,a5,1
    80000d36:	00078023          	sb	zero,0(a5) # 10000000 <_entry-0x70000000>

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80000d3a:	100007b7          	lui	a5,0x10000
    80000d3e:	078d                	addi	a5,a5,3
    80000d40:	470d                	li	a4,3
    80000d42:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80000d46:	100007b7          	lui	a5,0x10000
    80000d4a:	0789                	addi	a5,a5,2
    80000d4c:	471d                	li	a4,7
    80000d4e:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80000d52:	100007b7          	lui	a5,0x10000
    80000d56:	0785                	addi	a5,a5,1
    80000d58:	470d                	li	a4,3
    80000d5a:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  initlock(&uart_tx_lock, "uart");
    80000d5e:	0000a597          	auipc	a1,0xa
    80000d62:	2da58593          	addi	a1,a1,730 # 8000b038 <etext+0x38>
    80000d66:	00013517          	auipc	a0,0x13
    80000d6a:	4e250513          	addi	a0,a0,1250 # 80014248 <uart_tx_lock>
    80000d6e:	00000097          	auipc	ra,0x0
    80000d72:	4d0080e7          	jalr	1232(ra) # 8000123e <initlock>
}
    80000d76:	0001                	nop
    80000d78:	60a2                	ld	ra,8(sp)
    80000d7a:	6402                	ld	s0,0(sp)
    80000d7c:	0141                	addi	sp,sp,16
    80000d7e:	8082                	ret

0000000080000d80 <uartputc>:
// because it may block, it can't be called
// from interrupts; it's only suitable for use
// by write().
void
uartputc(int c)
{
    80000d80:	1101                	addi	sp,sp,-32
    80000d82:	ec06                	sd	ra,24(sp)
    80000d84:	e822                	sd	s0,16(sp)
    80000d86:	1000                	addi	s0,sp,32
    80000d88:	87aa                	mv	a5,a0
    80000d8a:	fef42623          	sw	a5,-20(s0)
  acquire(&uart_tx_lock);
    80000d8e:	00013517          	auipc	a0,0x13
    80000d92:	4ba50513          	addi	a0,a0,1210 # 80014248 <uart_tx_lock>
    80000d96:	00000097          	auipc	ra,0x0
    80000d9a:	4d8080e7          	jalr	1240(ra) # 8000126e <acquire>

  if(panicked){
    80000d9e:	0000b797          	auipc	a5,0xb
    80000da2:	26278793          	addi	a5,a5,610 # 8000c000 <panicked>
    80000da6:	439c                	lw	a5,0(a5)
    80000da8:	2781                	sext.w	a5,a5
    80000daa:	c391                	beqz	a5,80000dae <uartputc+0x2e>
    for(;;)
    80000dac:	a001                	j	80000dac <uartputc+0x2c>
      ;
  }

  while(1){
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000dae:	0000b797          	auipc	a5,0xb
    80000db2:	26278793          	addi	a5,a5,610 # 8000c010 <uart_tx_r>
    80000db6:	639c                	ld	a5,0(a5)
    80000db8:	02078713          	addi	a4,a5,32
    80000dbc:	0000b797          	auipc	a5,0xb
    80000dc0:	24c78793          	addi	a5,a5,588 # 8000c008 <uart_tx_w>
    80000dc4:	639c                	ld	a5,0(a5)
    80000dc6:	00f71f63          	bne	a4,a5,80000de4 <uartputc+0x64>
      // buffer is full.
      // wait for uartstart() to open up space in the buffer.
      sleep(&uart_tx_r, &uart_tx_lock);
    80000dca:	00013597          	auipc	a1,0x13
    80000dce:	47e58593          	addi	a1,a1,1150 # 80014248 <uart_tx_lock>
    80000dd2:	0000b517          	auipc	a0,0xb
    80000dd6:	23e50513          	addi	a0,a0,574 # 8000c010 <uart_tx_r>
    80000dda:	00002097          	auipc	ra,0x2
    80000dde:	706080e7          	jalr	1798(ra) # 800034e0 <sleep>
    80000de2:	b7f1                	j	80000dae <uartputc+0x2e>
    } else {
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80000de4:	0000b797          	auipc	a5,0xb
    80000de8:	22478793          	addi	a5,a5,548 # 8000c008 <uart_tx_w>
    80000dec:	639c                	ld	a5,0(a5)
    80000dee:	8bfd                	andi	a5,a5,31
    80000df0:	fec42703          	lw	a4,-20(s0)
    80000df4:	0ff77713          	andi	a4,a4,255
    80000df8:	00013697          	auipc	a3,0x13
    80000dfc:	46868693          	addi	a3,a3,1128 # 80014260 <uart_tx_buf>
    80000e00:	97b6                	add	a5,a5,a3
    80000e02:	00e78023          	sb	a4,0(a5)
      uart_tx_w += 1;
    80000e06:	0000b797          	auipc	a5,0xb
    80000e0a:	20278793          	addi	a5,a5,514 # 8000c008 <uart_tx_w>
    80000e0e:	639c                	ld	a5,0(a5)
    80000e10:	00178713          	addi	a4,a5,1
    80000e14:	0000b797          	auipc	a5,0xb
    80000e18:	1f478793          	addi	a5,a5,500 # 8000c008 <uart_tx_w>
    80000e1c:	e398                	sd	a4,0(a5)
      uartstart();
    80000e1e:	00000097          	auipc	ra,0x0
    80000e22:	084080e7          	jalr	132(ra) # 80000ea2 <uartstart>
      release(&uart_tx_lock);
    80000e26:	00013517          	auipc	a0,0x13
    80000e2a:	42250513          	addi	a0,a0,1058 # 80014248 <uart_tx_lock>
    80000e2e:	00000097          	auipc	ra,0x0
    80000e32:	4a4080e7          	jalr	1188(ra) # 800012d2 <release>
      return;
    80000e36:	0001                	nop
    }
  }
}
    80000e38:	60e2                	ld	ra,24(sp)
    80000e3a:	6442                	ld	s0,16(sp)
    80000e3c:	6105                	addi	sp,sp,32
    80000e3e:	8082                	ret

0000000080000e40 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80000e40:	1101                	addi	sp,sp,-32
    80000e42:	ec06                	sd	ra,24(sp)
    80000e44:	e822                	sd	s0,16(sp)
    80000e46:	1000                	addi	s0,sp,32
    80000e48:	87aa                	mv	a5,a0
    80000e4a:	fef42623          	sw	a5,-20(s0)
  push_off();
    80000e4e:	00000097          	auipc	ra,0x0
    80000e52:	51e080e7          	jalr	1310(ra) # 8000136c <push_off>

  if(panicked){
    80000e56:	0000b797          	auipc	a5,0xb
    80000e5a:	1aa78793          	addi	a5,a5,426 # 8000c000 <panicked>
    80000e5e:	439c                	lw	a5,0(a5)
    80000e60:	2781                	sext.w	a5,a5
    80000e62:	c391                	beqz	a5,80000e66 <uartputc_sync+0x26>
    for(;;)
    80000e64:	a001                	j	80000e64 <uartputc_sync+0x24>
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000e66:	0001                	nop
    80000e68:	100007b7          	lui	a5,0x10000
    80000e6c:	0795                	addi	a5,a5,5
    80000e6e:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000e72:	0ff7f793          	andi	a5,a5,255
    80000e76:	2781                	sext.w	a5,a5
    80000e78:	0207f793          	andi	a5,a5,32
    80000e7c:	2781                	sext.w	a5,a5
    80000e7e:	d7ed                	beqz	a5,80000e68 <uartputc_sync+0x28>
    ;
  WriteReg(THR, c);
    80000e80:	100007b7          	lui	a5,0x10000
    80000e84:	fec42703          	lw	a4,-20(s0)
    80000e88:	0ff77713          	andi	a4,a4,255
    80000e8c:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80000e90:	00000097          	auipc	ra,0x0
    80000e94:	534080e7          	jalr	1332(ra) # 800013c4 <pop_off>
}
    80000e98:	0001                	nop
    80000e9a:	60e2                	ld	ra,24(sp)
    80000e9c:	6442                	ld	s0,16(sp)
    80000e9e:	6105                	addi	sp,sp,32
    80000ea0:	8082                	ret

0000000080000ea2 <uartstart>:
// in the transmit buffer, send it.
// caller must hold uart_tx_lock.
// called from both the top- and bottom-half.
void
uartstart()
{
    80000ea2:	1101                	addi	sp,sp,-32
    80000ea4:	ec06                	sd	ra,24(sp)
    80000ea6:	e822                	sd	s0,16(sp)
    80000ea8:	1000                	addi	s0,sp,32
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000eaa:	0000b797          	auipc	a5,0xb
    80000eae:	15e78793          	addi	a5,a5,350 # 8000c008 <uart_tx_w>
    80000eb2:	6398                	ld	a4,0(a5)
    80000eb4:	0000b797          	auipc	a5,0xb
    80000eb8:	15c78793          	addi	a5,a5,348 # 8000c010 <uart_tx_r>
    80000ebc:	639c                	ld	a5,0(a5)
    80000ebe:	06f70a63          	beq	a4,a5,80000f32 <uartstart+0x90>
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000ec2:	100007b7          	lui	a5,0x10000
    80000ec6:	0795                	addi	a5,a5,5
    80000ec8:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000ecc:	0ff7f793          	andi	a5,a5,255
    80000ed0:	2781                	sext.w	a5,a5
    80000ed2:	0207f793          	andi	a5,a5,32
    80000ed6:	2781                	sext.w	a5,a5
    80000ed8:	cfb9                	beqz	a5,80000f36 <uartstart+0x94>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80000eda:	0000b797          	auipc	a5,0xb
    80000ede:	13678793          	addi	a5,a5,310 # 8000c010 <uart_tx_r>
    80000ee2:	639c                	ld	a5,0(a5)
    80000ee4:	8bfd                	andi	a5,a5,31
    80000ee6:	00013717          	auipc	a4,0x13
    80000eea:	37a70713          	addi	a4,a4,890 # 80014260 <uart_tx_buf>
    80000eee:	97ba                	add	a5,a5,a4
    80000ef0:	0007c783          	lbu	a5,0(a5)
    80000ef4:	fef42623          	sw	a5,-20(s0)
    uart_tx_r += 1;
    80000ef8:	0000b797          	auipc	a5,0xb
    80000efc:	11878793          	addi	a5,a5,280 # 8000c010 <uart_tx_r>
    80000f00:	639c                	ld	a5,0(a5)
    80000f02:	00178713          	addi	a4,a5,1
    80000f06:	0000b797          	auipc	a5,0xb
    80000f0a:	10a78793          	addi	a5,a5,266 # 8000c010 <uart_tx_r>
    80000f0e:	e398                	sd	a4,0(a5)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80000f10:	0000b517          	auipc	a0,0xb
    80000f14:	10050513          	addi	a0,a0,256 # 8000c010 <uart_tx_r>
    80000f18:	00002097          	auipc	ra,0x2
    80000f1c:	68c080e7          	jalr	1676(ra) # 800035a4 <wakeup>
    
    WriteReg(THR, c);
    80000f20:	100007b7          	lui	a5,0x10000
    80000f24:	fec42703          	lw	a4,-20(s0)
    80000f28:	0ff77713          	andi	a4,a4,255
    80000f2c:	00e78023          	sb	a4,0(a5) # 10000000 <_entry-0x70000000>
  while(1){
    80000f30:	bfad                	j	80000eaa <uartstart+0x8>
      return;
    80000f32:	0001                	nop
    80000f34:	a011                	j	80000f38 <uartstart+0x96>
      return;
    80000f36:	0001                	nop
  }
}
    80000f38:	60e2                	ld	ra,24(sp)
    80000f3a:	6442                	ld	s0,16(sp)
    80000f3c:	6105                	addi	sp,sp,32
    80000f3e:	8082                	ret

0000000080000f40 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80000f40:	1141                	addi	sp,sp,-16
    80000f42:	e422                	sd	s0,8(sp)
    80000f44:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000f46:	100007b7          	lui	a5,0x10000
    80000f4a:	0795                	addi	a5,a5,5
    80000f4c:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f50:	0ff7f793          	andi	a5,a5,255
    80000f54:	2781                	sext.w	a5,a5
    80000f56:	8b85                	andi	a5,a5,1
    80000f58:	2781                	sext.w	a5,a5
    80000f5a:	cb89                	beqz	a5,80000f6c <uartgetc+0x2c>
    // input data is ready.
    return ReadReg(RHR);
    80000f5c:	100007b7          	lui	a5,0x10000
    80000f60:	0007c783          	lbu	a5,0(a5) # 10000000 <_entry-0x70000000>
    80000f64:	0ff7f793          	andi	a5,a5,255
    80000f68:	2781                	sext.w	a5,a5
    80000f6a:	a011                	j	80000f6e <uartgetc+0x2e>
  } else {
    return -1;
    80000f6c:	57fd                	li	a5,-1
  }
}
    80000f6e:	853e                	mv	a0,a5
    80000f70:	6422                	ld	s0,8(sp)
    80000f72:	0141                	addi	sp,sp,16
    80000f74:	8082                	ret

0000000080000f76 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000f76:	1101                	addi	sp,sp,-32
    80000f78:	ec06                	sd	ra,24(sp)
    80000f7a:	e822                	sd	s0,16(sp)
    80000f7c:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    80000f7e:	00000097          	auipc	ra,0x0
    80000f82:	fc2080e7          	jalr	-62(ra) # 80000f40 <uartgetc>
    80000f86:	87aa                	mv	a5,a0
    80000f88:	fef42623          	sw	a5,-20(s0)
    if(c == -1)
    80000f8c:	fec42783          	lw	a5,-20(s0)
    80000f90:	0007871b          	sext.w	a4,a5
    80000f94:	57fd                	li	a5,-1
    80000f96:	00f70a63          	beq	a4,a5,80000faa <uartintr+0x34>
      break;
    consoleintr(c);
    80000f9a:	fec42783          	lw	a5,-20(s0)
    80000f9e:	853e                	mv	a0,a5
    80000fa0:	fffff097          	auipc	ra,0xfffff
    80000fa4:	64a080e7          	jalr	1610(ra) # 800005ea <consoleintr>
  while(1){
    80000fa8:	bfd9                	j	80000f7e <uartintr+0x8>
      break;
    80000faa:	0001                	nop
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80000fac:	00013517          	auipc	a0,0x13
    80000fb0:	29c50513          	addi	a0,a0,668 # 80014248 <uart_tx_lock>
    80000fb4:	00000097          	auipc	ra,0x0
    80000fb8:	2ba080e7          	jalr	698(ra) # 8000126e <acquire>
  uartstart();
    80000fbc:	00000097          	auipc	ra,0x0
    80000fc0:	ee6080e7          	jalr	-282(ra) # 80000ea2 <uartstart>
  release(&uart_tx_lock);
    80000fc4:	00013517          	auipc	a0,0x13
    80000fc8:	28450513          	addi	a0,a0,644 # 80014248 <uart_tx_lock>
    80000fcc:	00000097          	auipc	ra,0x0
    80000fd0:	306080e7          	jalr	774(ra) # 800012d2 <release>
}
    80000fd4:	0001                	nop
    80000fd6:	60e2                	ld	ra,24(sp)
    80000fd8:	6442                	ld	s0,16(sp)
    80000fda:	6105                	addi	sp,sp,32
    80000fdc:	8082                	ret

0000000080000fde <kinit>:
  struct run *freelist;
} kmem;

void
kinit()
{
    80000fde:	1141                	addi	sp,sp,-16
    80000fe0:	e406                	sd	ra,8(sp)
    80000fe2:	e022                	sd	s0,0(sp)
    80000fe4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000fe6:	0000a597          	auipc	a1,0xa
    80000fea:	05a58593          	addi	a1,a1,90 # 8000b040 <etext+0x40>
    80000fee:	00013517          	auipc	a0,0x13
    80000ff2:	29250513          	addi	a0,a0,658 # 80014280 <kmem>
    80000ff6:	00000097          	auipc	ra,0x0
    80000ffa:	248080e7          	jalr	584(ra) # 8000123e <initlock>
  freerange(end, (void*)PHYSTOP);
    80000ffe:	47c5                	li	a5,17
    80001000:	01b79593          	slli	a1,a5,0x1b
    80001004:	00028517          	auipc	a0,0x28
    80001008:	ffc50513          	addi	a0,a0,-4 # 80029000 <end>
    8000100c:	00000097          	auipc	ra,0x0
    80001010:	012080e7          	jalr	18(ra) # 8000101e <freerange>
}
    80001014:	0001                	nop
    80001016:	60a2                	ld	ra,8(sp)
    80001018:	6402                	ld	s0,0(sp)
    8000101a:	0141                	addi	sp,sp,16
    8000101c:	8082                	ret

000000008000101e <freerange>:

void
freerange(void *pa_start, void *pa_end)
{
    8000101e:	7179                	addi	sp,sp,-48
    80001020:	f406                	sd	ra,40(sp)
    80001022:	f022                	sd	s0,32(sp)
    80001024:	1800                	addi	s0,sp,48
    80001026:	fca43c23          	sd	a0,-40(s0)
    8000102a:	fcb43823          	sd	a1,-48(s0)
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000102e:	fd843703          	ld	a4,-40(s0)
    80001032:	6785                	lui	a5,0x1
    80001034:	17fd                	addi	a5,a5,-1
    80001036:	973e                	add	a4,a4,a5
    80001038:	77fd                	lui	a5,0xfffff
    8000103a:	8ff9                	and	a5,a5,a4
    8000103c:	fef43423          	sd	a5,-24(s0)
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80001040:	a829                	j	8000105a <freerange+0x3c>
    kfree(p);
    80001042:	fe843503          	ld	a0,-24(s0)
    80001046:	00000097          	auipc	ra,0x0
    8000104a:	030080e7          	jalr	48(ra) # 80001076 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000104e:	fe843703          	ld	a4,-24(s0)
    80001052:	6785                	lui	a5,0x1
    80001054:	97ba                	add	a5,a5,a4
    80001056:	fef43423          	sd	a5,-24(s0)
    8000105a:	fe843703          	ld	a4,-24(s0)
    8000105e:	6785                	lui	a5,0x1
    80001060:	97ba                	add	a5,a5,a4
    80001062:	fd043703          	ld	a4,-48(s0)
    80001066:	fcf77ee3          	bgeu	a4,a5,80001042 <freerange+0x24>
}
    8000106a:	0001                	nop
    8000106c:	0001                	nop
    8000106e:	70a2                	ld	ra,40(sp)
    80001070:	7402                	ld	s0,32(sp)
    80001072:	6145                	addi	sp,sp,48
    80001074:	8082                	ret

0000000080001076 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    80001076:	7179                	addi	sp,sp,-48
    80001078:	f406                	sd	ra,40(sp)
    8000107a:	f022                	sd	s0,32(sp)
    8000107c:	1800                	addi	s0,sp,48
    8000107e:	fca43c23          	sd	a0,-40(s0)
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80001082:	fd843703          	ld	a4,-40(s0)
    80001086:	6785                	lui	a5,0x1
    80001088:	17fd                	addi	a5,a5,-1
    8000108a:	8ff9                	and	a5,a5,a4
    8000108c:	ef99                	bnez	a5,800010aa <kfree+0x34>
    8000108e:	fd843703          	ld	a4,-40(s0)
    80001092:	00028797          	auipc	a5,0x28
    80001096:	f6e78793          	addi	a5,a5,-146 # 80029000 <end>
    8000109a:	00f76863          	bltu	a4,a5,800010aa <kfree+0x34>
    8000109e:	fd843703          	ld	a4,-40(s0)
    800010a2:	47c5                	li	a5,17
    800010a4:	07ee                	slli	a5,a5,0x1b
    800010a6:	00f76a63          	bltu	a4,a5,800010ba <kfree+0x44>
    panic("kfree");
    800010aa:	0000a517          	auipc	a0,0xa
    800010ae:	f9e50513          	addi	a0,a0,-98 # 8000b048 <etext+0x48>
    800010b2:	00000097          	auipc	ra,0x0
    800010b6:	bcc080e7          	jalr	-1076(ra) # 80000c7e <panic>

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    800010ba:	6605                	lui	a2,0x1
    800010bc:	4585                	li	a1,1
    800010be:	fd843503          	ld	a0,-40(s0)
    800010c2:	00000097          	auipc	ra,0x0
    800010c6:	380080e7          	jalr	896(ra) # 80001442 <memset>

  r = (struct run*)pa;
    800010ca:	fd843783          	ld	a5,-40(s0)
    800010ce:	fef43423          	sd	a5,-24(s0)

  acquire(&kmem.lock);
    800010d2:	00013517          	auipc	a0,0x13
    800010d6:	1ae50513          	addi	a0,a0,430 # 80014280 <kmem>
    800010da:	00000097          	auipc	ra,0x0
    800010de:	194080e7          	jalr	404(ra) # 8000126e <acquire>
  r->next = kmem.freelist;
    800010e2:	00013797          	auipc	a5,0x13
    800010e6:	19e78793          	addi	a5,a5,414 # 80014280 <kmem>
    800010ea:	6f98                	ld	a4,24(a5)
    800010ec:	fe843783          	ld	a5,-24(s0)
    800010f0:	e398                	sd	a4,0(a5)
  kmem.freelist = r;
    800010f2:	00013797          	auipc	a5,0x13
    800010f6:	18e78793          	addi	a5,a5,398 # 80014280 <kmem>
    800010fa:	fe843703          	ld	a4,-24(s0)
    800010fe:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001100:	00013517          	auipc	a0,0x13
    80001104:	18050513          	addi	a0,a0,384 # 80014280 <kmem>
    80001108:	00000097          	auipc	ra,0x0
    8000110c:	1ca080e7          	jalr	458(ra) # 800012d2 <release>
}
    80001110:	0001                	nop
    80001112:	70a2                	ld	ra,40(sp)
    80001114:	7402                	ld	s0,32(sp)
    80001116:	6145                	addi	sp,sp,48
    80001118:	8082                	ret

000000008000111a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000111a:	1101                	addi	sp,sp,-32
    8000111c:	ec06                	sd	ra,24(sp)
    8000111e:	e822                	sd	s0,16(sp)
    80001120:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80001122:	00013517          	auipc	a0,0x13
    80001126:	15e50513          	addi	a0,a0,350 # 80014280 <kmem>
    8000112a:	00000097          	auipc	ra,0x0
    8000112e:	144080e7          	jalr	324(ra) # 8000126e <acquire>
  r = kmem.freelist;
    80001132:	00013797          	auipc	a5,0x13
    80001136:	14e78793          	addi	a5,a5,334 # 80014280 <kmem>
    8000113a:	6f9c                	ld	a5,24(a5)
    8000113c:	fef43423          	sd	a5,-24(s0)
  if(r)
    80001140:	fe843783          	ld	a5,-24(s0)
    80001144:	cb89                	beqz	a5,80001156 <kalloc+0x3c>
    kmem.freelist = r->next;
    80001146:	fe843783          	ld	a5,-24(s0)
    8000114a:	6398                	ld	a4,0(a5)
    8000114c:	00013797          	auipc	a5,0x13
    80001150:	13478793          	addi	a5,a5,308 # 80014280 <kmem>
    80001154:	ef98                	sd	a4,24(a5)
  release(&kmem.lock);
    80001156:	00013517          	auipc	a0,0x13
    8000115a:	12a50513          	addi	a0,a0,298 # 80014280 <kmem>
    8000115e:	00000097          	auipc	ra,0x0
    80001162:	174080e7          	jalr	372(ra) # 800012d2 <release>

  if(r)
    80001166:	fe843783          	ld	a5,-24(s0)
    8000116a:	cb89                	beqz	a5,8000117c <kalloc+0x62>
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000116c:	6605                	lui	a2,0x1
    8000116e:	4595                	li	a1,5
    80001170:	fe843503          	ld	a0,-24(s0)
    80001174:	00000097          	auipc	ra,0x0
    80001178:	2ce080e7          	jalr	718(ra) # 80001442 <memset>
  return (void*)r;
    8000117c:	fe843783          	ld	a5,-24(s0)
}
    80001180:	853e                	mv	a0,a5
    80001182:	60e2                	ld	ra,24(sp)
    80001184:	6442                	ld	s0,16(sp)
    80001186:	6105                	addi	sp,sp,32
    80001188:	8082                	ret

000000008000118a <r_sstatus>:
{
    8000118a:	1101                	addi	sp,sp,-32
    8000118c:	ec22                	sd	s0,24(sp)
    8000118e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001190:	100027f3          	csrr	a5,sstatus
    80001194:	fef43423          	sd	a5,-24(s0)
  return x;
    80001198:	fe843783          	ld	a5,-24(s0)
}
    8000119c:	853e                	mv	a0,a5
    8000119e:	6462                	ld	s0,24(sp)
    800011a0:	6105                	addi	sp,sp,32
    800011a2:	8082                	ret

00000000800011a4 <w_sstatus>:
{
    800011a4:	1101                	addi	sp,sp,-32
    800011a6:	ec22                	sd	s0,24(sp)
    800011a8:	1000                	addi	s0,sp,32
    800011aa:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800011ae:	fe843783          	ld	a5,-24(s0)
    800011b2:	10079073          	csrw	sstatus,a5
}
    800011b6:	0001                	nop
    800011b8:	6462                	ld	s0,24(sp)
    800011ba:	6105                	addi	sp,sp,32
    800011bc:	8082                	ret

00000000800011be <intr_on>:
{
    800011be:	1141                	addi	sp,sp,-16
    800011c0:	e406                	sd	ra,8(sp)
    800011c2:	e022                	sd	s0,0(sp)
    800011c4:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800011c6:	00000097          	auipc	ra,0x0
    800011ca:	fc4080e7          	jalr	-60(ra) # 8000118a <r_sstatus>
    800011ce:	87aa                	mv	a5,a0
    800011d0:	0027e793          	ori	a5,a5,2
    800011d4:	853e                	mv	a0,a5
    800011d6:	00000097          	auipc	ra,0x0
    800011da:	fce080e7          	jalr	-50(ra) # 800011a4 <w_sstatus>
}
    800011de:	0001                	nop
    800011e0:	60a2                	ld	ra,8(sp)
    800011e2:	6402                	ld	s0,0(sp)
    800011e4:	0141                	addi	sp,sp,16
    800011e6:	8082                	ret

00000000800011e8 <intr_off>:
{
    800011e8:	1141                	addi	sp,sp,-16
    800011ea:	e406                	sd	ra,8(sp)
    800011ec:	e022                	sd	s0,0(sp)
    800011ee:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800011f0:	00000097          	auipc	ra,0x0
    800011f4:	f9a080e7          	jalr	-102(ra) # 8000118a <r_sstatus>
    800011f8:	87aa                	mv	a5,a0
    800011fa:	9bf5                	andi	a5,a5,-3
    800011fc:	853e                	mv	a0,a5
    800011fe:	00000097          	auipc	ra,0x0
    80001202:	fa6080e7          	jalr	-90(ra) # 800011a4 <w_sstatus>
}
    80001206:	0001                	nop
    80001208:	60a2                	ld	ra,8(sp)
    8000120a:	6402                	ld	s0,0(sp)
    8000120c:	0141                	addi	sp,sp,16
    8000120e:	8082                	ret

0000000080001210 <intr_get>:
{
    80001210:	1101                	addi	sp,sp,-32
    80001212:	ec06                	sd	ra,24(sp)
    80001214:	e822                	sd	s0,16(sp)
    80001216:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80001218:	00000097          	auipc	ra,0x0
    8000121c:	f72080e7          	jalr	-142(ra) # 8000118a <r_sstatus>
    80001220:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80001224:	fe843783          	ld	a5,-24(s0)
    80001228:	8b89                	andi	a5,a5,2
    8000122a:	00f037b3          	snez	a5,a5
    8000122e:	0ff7f793          	andi	a5,a5,255
    80001232:	2781                	sext.w	a5,a5
}
    80001234:	853e                	mv	a0,a5
    80001236:	60e2                	ld	ra,24(sp)
    80001238:	6442                	ld	s0,16(sp)
    8000123a:	6105                	addi	sp,sp,32
    8000123c:	8082                	ret

000000008000123e <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000123e:	1101                	addi	sp,sp,-32
    80001240:	ec22                	sd	s0,24(sp)
    80001242:	1000                	addi	s0,sp,32
    80001244:	fea43423          	sd	a0,-24(s0)
    80001248:	feb43023          	sd	a1,-32(s0)
  lk->name = name;
    8000124c:	fe843783          	ld	a5,-24(s0)
    80001250:	fe043703          	ld	a4,-32(s0)
    80001254:	e798                	sd	a4,8(a5)
  lk->locked = 0;
    80001256:	fe843783          	ld	a5,-24(s0)
    8000125a:	0007a023          	sw	zero,0(a5)
  lk->cpu = 0;
    8000125e:	fe843783          	ld	a5,-24(s0)
    80001262:	0007b823          	sd	zero,16(a5)
}
    80001266:	0001                	nop
    80001268:	6462                	ld	s0,24(sp)
    8000126a:	6105                	addi	sp,sp,32
    8000126c:	8082                	ret

000000008000126e <acquire>:

// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
    8000126e:	1101                	addi	sp,sp,-32
    80001270:	ec06                	sd	ra,24(sp)
    80001272:	e822                	sd	s0,16(sp)
    80001274:	1000                	addi	s0,sp,32
    80001276:	fea43423          	sd	a0,-24(s0)
  push_off(); // disable interrupts to avoid deadlock.
    8000127a:	00000097          	auipc	ra,0x0
    8000127e:	0f2080e7          	jalr	242(ra) # 8000136c <push_off>
  if(holding(lk))
    80001282:	fe843503          	ld	a0,-24(s0)
    80001286:	00000097          	auipc	ra,0x0
    8000128a:	0a2080e7          	jalr	162(ra) # 80001328 <holding>
    8000128e:	87aa                	mv	a5,a0
    80001290:	cb89                	beqz	a5,800012a2 <acquire+0x34>
    panic("acquire");
    80001292:	0000a517          	auipc	a0,0xa
    80001296:	dbe50513          	addi	a0,a0,-578 # 8000b050 <etext+0x50>
    8000129a:	00000097          	auipc	ra,0x0
    8000129e:	9e4080e7          	jalr	-1564(ra) # 80000c7e <panic>

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800012a2:	0001                	nop
    800012a4:	fe843783          	ld	a5,-24(s0)
    800012a8:	4705                	li	a4,1
    800012aa:	0ce7a72f          	amoswap.w.aq	a4,a4,(a5)
    800012ae:	0007079b          	sext.w	a5,a4
    800012b2:	fbed                	bnez	a5,800012a4 <acquire+0x36>

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    800012b4:	0ff0000f          	fence

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
    800012b8:	00001097          	auipc	ra,0x1
    800012bc:	522080e7          	jalr	1314(ra) # 800027da <mycpu>
    800012c0:	872a                	mv	a4,a0
    800012c2:	fe843783          	ld	a5,-24(s0)
    800012c6:	eb98                	sd	a4,16(a5)
}
    800012c8:	0001                	nop
    800012ca:	60e2                	ld	ra,24(sp)
    800012cc:	6442                	ld	s0,16(sp)
    800012ce:	6105                	addi	sp,sp,32
    800012d0:	8082                	ret

00000000800012d2 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
    800012d2:	1101                	addi	sp,sp,-32
    800012d4:	ec06                	sd	ra,24(sp)
    800012d6:	e822                	sd	s0,16(sp)
    800012d8:	1000                	addi	s0,sp,32
    800012da:	fea43423          	sd	a0,-24(s0)
  if(!holding(lk))
    800012de:	fe843503          	ld	a0,-24(s0)
    800012e2:	00000097          	auipc	ra,0x0
    800012e6:	046080e7          	jalr	70(ra) # 80001328 <holding>
    800012ea:	87aa                	mv	a5,a0
    800012ec:	eb89                	bnez	a5,800012fe <release+0x2c>
    panic("release");
    800012ee:	0000a517          	auipc	a0,0xa
    800012f2:	d6a50513          	addi	a0,a0,-662 # 8000b058 <etext+0x58>
    800012f6:	00000097          	auipc	ra,0x0
    800012fa:	988080e7          	jalr	-1656(ra) # 80000c7e <panic>

  lk->cpu = 0;
    800012fe:	fe843783          	ld	a5,-24(s0)
    80001302:	0007b823          	sd	zero,16(a5)
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();
    80001306:	0ff0000f          	fence
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);
    8000130a:	fe843783          	ld	a5,-24(s0)
    8000130e:	0f50000f          	fence	iorw,ow
    80001312:	0807a02f          	amoswap.w	zero,zero,(a5)

  pop_off();
    80001316:	00000097          	auipc	ra,0x0
    8000131a:	0ae080e7          	jalr	174(ra) # 800013c4 <pop_off>
}
    8000131e:	0001                	nop
    80001320:	60e2                	ld	ra,24(sp)
    80001322:	6442                	ld	s0,16(sp)
    80001324:	6105                	addi	sp,sp,32
    80001326:	8082                	ret

0000000080001328 <holding>:

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
    80001328:	7139                	addi	sp,sp,-64
    8000132a:	fc06                	sd	ra,56(sp)
    8000132c:	f822                	sd	s0,48(sp)
    8000132e:	f426                	sd	s1,40(sp)
    80001330:	0080                	addi	s0,sp,64
    80001332:	fca43423          	sd	a0,-56(s0)
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80001336:	fc843783          	ld	a5,-56(s0)
    8000133a:	439c                	lw	a5,0(a5)
    8000133c:	cf89                	beqz	a5,80001356 <holding+0x2e>
    8000133e:	fc843783          	ld	a5,-56(s0)
    80001342:	6b84                	ld	s1,16(a5)
    80001344:	00001097          	auipc	ra,0x1
    80001348:	496080e7          	jalr	1174(ra) # 800027da <mycpu>
    8000134c:	87aa                	mv	a5,a0
    8000134e:	00f49463          	bne	s1,a5,80001356 <holding+0x2e>
    80001352:	4785                	li	a5,1
    80001354:	a011                	j	80001358 <holding+0x30>
    80001356:	4781                	li	a5,0
    80001358:	fcf42e23          	sw	a5,-36(s0)
  return r;
    8000135c:	fdc42783          	lw	a5,-36(s0)
}
    80001360:	853e                	mv	a0,a5
    80001362:	70e2                	ld	ra,56(sp)
    80001364:	7442                	ld	s0,48(sp)
    80001366:	74a2                	ld	s1,40(sp)
    80001368:	6121                	addi	sp,sp,64
    8000136a:	8082                	ret

000000008000136c <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000136c:	1101                	addi	sp,sp,-32
    8000136e:	ec06                	sd	ra,24(sp)
    80001370:	e822                	sd	s0,16(sp)
    80001372:	1000                	addi	s0,sp,32
  int old = intr_get();
    80001374:	00000097          	auipc	ra,0x0
    80001378:	e9c080e7          	jalr	-356(ra) # 80001210 <intr_get>
    8000137c:	87aa                	mv	a5,a0
    8000137e:	fef42623          	sw	a5,-20(s0)

  intr_off();
    80001382:	00000097          	auipc	ra,0x0
    80001386:	e66080e7          	jalr	-410(ra) # 800011e8 <intr_off>
  if(mycpu()->noff == 0)
    8000138a:	00001097          	auipc	ra,0x1
    8000138e:	450080e7          	jalr	1104(ra) # 800027da <mycpu>
    80001392:	87aa                	mv	a5,a0
    80001394:	5fbc                	lw	a5,120(a5)
    80001396:	eb89                	bnez	a5,800013a8 <push_off+0x3c>
    mycpu()->intena = old;
    80001398:	00001097          	auipc	ra,0x1
    8000139c:	442080e7          	jalr	1090(ra) # 800027da <mycpu>
    800013a0:	872a                	mv	a4,a0
    800013a2:	fec42783          	lw	a5,-20(s0)
    800013a6:	df7c                	sw	a5,124(a4)
  mycpu()->noff += 1;
    800013a8:	00001097          	auipc	ra,0x1
    800013ac:	432080e7          	jalr	1074(ra) # 800027da <mycpu>
    800013b0:	87aa                	mv	a5,a0
    800013b2:	5fb8                	lw	a4,120(a5)
    800013b4:	2705                	addiw	a4,a4,1
    800013b6:	2701                	sext.w	a4,a4
    800013b8:	dfb8                	sw	a4,120(a5)
}
    800013ba:	0001                	nop
    800013bc:	60e2                	ld	ra,24(sp)
    800013be:	6442                	ld	s0,16(sp)
    800013c0:	6105                	addi	sp,sp,32
    800013c2:	8082                	ret

00000000800013c4 <pop_off>:

void
pop_off(void)
{
    800013c4:	1101                	addi	sp,sp,-32
    800013c6:	ec06                	sd	ra,24(sp)
    800013c8:	e822                	sd	s0,16(sp)
    800013ca:	1000                	addi	s0,sp,32
  struct cpu *c = mycpu();
    800013cc:	00001097          	auipc	ra,0x1
    800013d0:	40e080e7          	jalr	1038(ra) # 800027da <mycpu>
    800013d4:	fea43423          	sd	a0,-24(s0)
  if(intr_get())
    800013d8:	00000097          	auipc	ra,0x0
    800013dc:	e38080e7          	jalr	-456(ra) # 80001210 <intr_get>
    800013e0:	87aa                	mv	a5,a0
    800013e2:	cb89                	beqz	a5,800013f4 <pop_off+0x30>
    panic("pop_off - interruptible");
    800013e4:	0000a517          	auipc	a0,0xa
    800013e8:	c7c50513          	addi	a0,a0,-900 # 8000b060 <etext+0x60>
    800013ec:	00000097          	auipc	ra,0x0
    800013f0:	892080e7          	jalr	-1902(ra) # 80000c7e <panic>
  if(c->noff < 1)
    800013f4:	fe843783          	ld	a5,-24(s0)
    800013f8:	5fbc                	lw	a5,120(a5)
    800013fa:	00f04a63          	bgtz	a5,8000140e <pop_off+0x4a>
    panic("pop_off");
    800013fe:	0000a517          	auipc	a0,0xa
    80001402:	c7a50513          	addi	a0,a0,-902 # 8000b078 <etext+0x78>
    80001406:	00000097          	auipc	ra,0x0
    8000140a:	878080e7          	jalr	-1928(ra) # 80000c7e <panic>
  c->noff -= 1;
    8000140e:	fe843783          	ld	a5,-24(s0)
    80001412:	5fbc                	lw	a5,120(a5)
    80001414:	37fd                	addiw	a5,a5,-1
    80001416:	0007871b          	sext.w	a4,a5
    8000141a:	fe843783          	ld	a5,-24(s0)
    8000141e:	dfb8                	sw	a4,120(a5)
  if(c->noff == 0 && c->intena)
    80001420:	fe843783          	ld	a5,-24(s0)
    80001424:	5fbc                	lw	a5,120(a5)
    80001426:	eb89                	bnez	a5,80001438 <pop_off+0x74>
    80001428:	fe843783          	ld	a5,-24(s0)
    8000142c:	5ffc                	lw	a5,124(a5)
    8000142e:	c789                	beqz	a5,80001438 <pop_off+0x74>
    intr_on();
    80001430:	00000097          	auipc	ra,0x0
    80001434:	d8e080e7          	jalr	-626(ra) # 800011be <intr_on>
}
    80001438:	0001                	nop
    8000143a:	60e2                	ld	ra,24(sp)
    8000143c:	6442                	ld	s0,16(sp)
    8000143e:	6105                	addi	sp,sp,32
    80001440:	8082                	ret

0000000080001442 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80001442:	7179                	addi	sp,sp,-48
    80001444:	f422                	sd	s0,40(sp)
    80001446:	1800                	addi	s0,sp,48
    80001448:	fca43c23          	sd	a0,-40(s0)
    8000144c:	87ae                	mv	a5,a1
    8000144e:	8732                	mv	a4,a2
    80001450:	fcf42a23          	sw	a5,-44(s0)
    80001454:	87ba                	mv	a5,a4
    80001456:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
    8000145a:	fd843783          	ld	a5,-40(s0)
    8000145e:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
    80001462:	fe042623          	sw	zero,-20(s0)
    80001466:	a00d                	j	80001488 <memset+0x46>
    cdst[i] = c;
    80001468:	fec42783          	lw	a5,-20(s0)
    8000146c:	fe043703          	ld	a4,-32(s0)
    80001470:	97ba                	add	a5,a5,a4
    80001472:	fd442703          	lw	a4,-44(s0)
    80001476:	0ff77713          	andi	a4,a4,255
    8000147a:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
    8000147e:	fec42783          	lw	a5,-20(s0)
    80001482:	2785                	addiw	a5,a5,1
    80001484:	fef42623          	sw	a5,-20(s0)
    80001488:	fec42703          	lw	a4,-20(s0)
    8000148c:	fd042783          	lw	a5,-48(s0)
    80001490:	2781                	sext.w	a5,a5
    80001492:	fcf76be3          	bltu	a4,a5,80001468 <memset+0x26>
  }
  return dst;
    80001496:	fd843783          	ld	a5,-40(s0)
}
    8000149a:	853e                	mv	a0,a5
    8000149c:	7422                	ld	s0,40(sp)
    8000149e:	6145                	addi	sp,sp,48
    800014a0:	8082                	ret

00000000800014a2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800014a2:	7139                	addi	sp,sp,-64
    800014a4:	fc22                	sd	s0,56(sp)
    800014a6:	0080                	addi	s0,sp,64
    800014a8:	fca43c23          	sd	a0,-40(s0)
    800014ac:	fcb43823          	sd	a1,-48(s0)
    800014b0:	87b2                	mv	a5,a2
    800014b2:	fcf42623          	sw	a5,-52(s0)
  const uchar *s1, *s2;

  s1 = v1;
    800014b6:	fd843783          	ld	a5,-40(s0)
    800014ba:	fef43423          	sd	a5,-24(s0)
  s2 = v2;
    800014be:	fd043783          	ld	a5,-48(s0)
    800014c2:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    800014c6:	a0a1                	j	8000150e <memcmp+0x6c>
    if(*s1 != *s2)
    800014c8:	fe843783          	ld	a5,-24(s0)
    800014cc:	0007c703          	lbu	a4,0(a5)
    800014d0:	fe043783          	ld	a5,-32(s0)
    800014d4:	0007c783          	lbu	a5,0(a5)
    800014d8:	02f70163          	beq	a4,a5,800014fa <memcmp+0x58>
      return *s1 - *s2;
    800014dc:	fe843783          	ld	a5,-24(s0)
    800014e0:	0007c783          	lbu	a5,0(a5)
    800014e4:	0007871b          	sext.w	a4,a5
    800014e8:	fe043783          	ld	a5,-32(s0)
    800014ec:	0007c783          	lbu	a5,0(a5)
    800014f0:	2781                	sext.w	a5,a5
    800014f2:	40f707bb          	subw	a5,a4,a5
    800014f6:	2781                	sext.w	a5,a5
    800014f8:	a01d                	j	8000151e <memcmp+0x7c>
    s1++, s2++;
    800014fa:	fe843783          	ld	a5,-24(s0)
    800014fe:	0785                	addi	a5,a5,1
    80001500:	fef43423          	sd	a5,-24(s0)
    80001504:	fe043783          	ld	a5,-32(s0)
    80001508:	0785                	addi	a5,a5,1
    8000150a:	fef43023          	sd	a5,-32(s0)
  while(n-- > 0){
    8000150e:	fcc42783          	lw	a5,-52(s0)
    80001512:	fff7871b          	addiw	a4,a5,-1
    80001516:	fce42623          	sw	a4,-52(s0)
    8000151a:	f7dd                	bnez	a5,800014c8 <memcmp+0x26>
  }

  return 0;
    8000151c:	4781                	li	a5,0
}
    8000151e:	853e                	mv	a0,a5
    80001520:	7462                	ld	s0,56(sp)
    80001522:	6121                	addi	sp,sp,64
    80001524:	8082                	ret

0000000080001526 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80001526:	7139                	addi	sp,sp,-64
    80001528:	fc22                	sd	s0,56(sp)
    8000152a:	0080                	addi	s0,sp,64
    8000152c:	fca43c23          	sd	a0,-40(s0)
    80001530:	fcb43823          	sd	a1,-48(s0)
    80001534:	87b2                	mv	a5,a2
    80001536:	fcf42623          	sw	a5,-52(s0)
  const char *s;
  char *d;

  if(n == 0)
    8000153a:	fcc42783          	lw	a5,-52(s0)
    8000153e:	2781                	sext.w	a5,a5
    80001540:	e781                	bnez	a5,80001548 <memmove+0x22>
    return dst;
    80001542:	fd843783          	ld	a5,-40(s0)
    80001546:	a855                	j	800015fa <memmove+0xd4>
  
  s = src;
    80001548:	fd043783          	ld	a5,-48(s0)
    8000154c:	fef43423          	sd	a5,-24(s0)
  d = dst;
    80001550:	fd843783          	ld	a5,-40(s0)
    80001554:	fef43023          	sd	a5,-32(s0)
  if(s < d && s + n > d){
    80001558:	fe843703          	ld	a4,-24(s0)
    8000155c:	fe043783          	ld	a5,-32(s0)
    80001560:	08f77463          	bgeu	a4,a5,800015e8 <memmove+0xc2>
    80001564:	fcc46783          	lwu	a5,-52(s0)
    80001568:	fe843703          	ld	a4,-24(s0)
    8000156c:	97ba                	add	a5,a5,a4
    8000156e:	fe043703          	ld	a4,-32(s0)
    80001572:	06f77b63          	bgeu	a4,a5,800015e8 <memmove+0xc2>
    s += n;
    80001576:	fcc46783          	lwu	a5,-52(s0)
    8000157a:	fe843703          	ld	a4,-24(s0)
    8000157e:	97ba                	add	a5,a5,a4
    80001580:	fef43423          	sd	a5,-24(s0)
    d += n;
    80001584:	fcc46783          	lwu	a5,-52(s0)
    80001588:	fe043703          	ld	a4,-32(s0)
    8000158c:	97ba                	add	a5,a5,a4
    8000158e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
    80001592:	a01d                	j	800015b8 <memmove+0x92>
      *--d = *--s;
    80001594:	fe843783          	ld	a5,-24(s0)
    80001598:	17fd                	addi	a5,a5,-1
    8000159a:	fef43423          	sd	a5,-24(s0)
    8000159e:	fe043783          	ld	a5,-32(s0)
    800015a2:	17fd                	addi	a5,a5,-1
    800015a4:	fef43023          	sd	a5,-32(s0)
    800015a8:	fe843783          	ld	a5,-24(s0)
    800015ac:	0007c703          	lbu	a4,0(a5)
    800015b0:	fe043783          	ld	a5,-32(s0)
    800015b4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015b8:	fcc42783          	lw	a5,-52(s0)
    800015bc:	fff7871b          	addiw	a4,a5,-1
    800015c0:	fce42623          	sw	a4,-52(s0)
    800015c4:	fbe1                	bnez	a5,80001594 <memmove+0x6e>
  if(s < d && s + n > d){
    800015c6:	a805                	j	800015f6 <memmove+0xd0>
  } else
    while(n-- > 0)
      *d++ = *s++;
    800015c8:	fe843703          	ld	a4,-24(s0)
    800015cc:	00170793          	addi	a5,a4,1
    800015d0:	fef43423          	sd	a5,-24(s0)
    800015d4:	fe043783          	ld	a5,-32(s0)
    800015d8:	00178693          	addi	a3,a5,1
    800015dc:	fed43023          	sd	a3,-32(s0)
    800015e0:	00074703          	lbu	a4,0(a4)
    800015e4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
    800015e8:	fcc42783          	lw	a5,-52(s0)
    800015ec:	fff7871b          	addiw	a4,a5,-1
    800015f0:	fce42623          	sw	a4,-52(s0)
    800015f4:	fbf1                	bnez	a5,800015c8 <memmove+0xa2>

  return dst;
    800015f6:	fd843783          	ld	a5,-40(s0)
}
    800015fa:	853e                	mv	a0,a5
    800015fc:	7462                	ld	s0,56(sp)
    800015fe:	6121                	addi	sp,sp,64
    80001600:	8082                	ret

0000000080001602 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80001602:	7179                	addi	sp,sp,-48
    80001604:	f406                	sd	ra,40(sp)
    80001606:	f022                	sd	s0,32(sp)
    80001608:	1800                	addi	s0,sp,48
    8000160a:	fea43423          	sd	a0,-24(s0)
    8000160e:	feb43023          	sd	a1,-32(s0)
    80001612:	87b2                	mv	a5,a2
    80001614:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
    80001618:	fdc42783          	lw	a5,-36(s0)
    8000161c:	863e                	mv	a2,a5
    8000161e:	fe043583          	ld	a1,-32(s0)
    80001622:	fe843503          	ld	a0,-24(s0)
    80001626:	00000097          	auipc	ra,0x0
    8000162a:	f00080e7          	jalr	-256(ra) # 80001526 <memmove>
    8000162e:	87aa                	mv	a5,a0
}
    80001630:	853e                	mv	a0,a5
    80001632:	70a2                	ld	ra,40(sp)
    80001634:	7402                	ld	s0,32(sp)
    80001636:	6145                	addi	sp,sp,48
    80001638:	8082                	ret

000000008000163a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000163a:	7179                	addi	sp,sp,-48
    8000163c:	f422                	sd	s0,40(sp)
    8000163e:	1800                	addi	s0,sp,48
    80001640:	fea43423          	sd	a0,-24(s0)
    80001644:	feb43023          	sd	a1,-32(s0)
    80001648:	87b2                	mv	a5,a2
    8000164a:	fcf42e23          	sw	a5,-36(s0)
  while(n > 0 && *p && *p == *q)
    8000164e:	a005                	j	8000166e <strncmp+0x34>
    n--, p++, q++;
    80001650:	fdc42783          	lw	a5,-36(s0)
    80001654:	37fd                	addiw	a5,a5,-1
    80001656:	fcf42e23          	sw	a5,-36(s0)
    8000165a:	fe843783          	ld	a5,-24(s0)
    8000165e:	0785                	addi	a5,a5,1
    80001660:	fef43423          	sd	a5,-24(s0)
    80001664:	fe043783          	ld	a5,-32(s0)
    80001668:	0785                	addi	a5,a5,1
    8000166a:	fef43023          	sd	a5,-32(s0)
  while(n > 0 && *p && *p == *q)
    8000166e:	fdc42783          	lw	a5,-36(s0)
    80001672:	2781                	sext.w	a5,a5
    80001674:	c385                	beqz	a5,80001694 <strncmp+0x5a>
    80001676:	fe843783          	ld	a5,-24(s0)
    8000167a:	0007c783          	lbu	a5,0(a5)
    8000167e:	cb99                	beqz	a5,80001694 <strncmp+0x5a>
    80001680:	fe843783          	ld	a5,-24(s0)
    80001684:	0007c703          	lbu	a4,0(a5)
    80001688:	fe043783          	ld	a5,-32(s0)
    8000168c:	0007c783          	lbu	a5,0(a5)
    80001690:	fcf700e3          	beq	a4,a5,80001650 <strncmp+0x16>
  if(n == 0)
    80001694:	fdc42783          	lw	a5,-36(s0)
    80001698:	2781                	sext.w	a5,a5
    8000169a:	e399                	bnez	a5,800016a0 <strncmp+0x66>
    return 0;
    8000169c:	4781                	li	a5,0
    8000169e:	a839                	j	800016bc <strncmp+0x82>
  return (uchar)*p - (uchar)*q;
    800016a0:	fe843783          	ld	a5,-24(s0)
    800016a4:	0007c783          	lbu	a5,0(a5)
    800016a8:	0007871b          	sext.w	a4,a5
    800016ac:	fe043783          	ld	a5,-32(s0)
    800016b0:	0007c783          	lbu	a5,0(a5)
    800016b4:	2781                	sext.w	a5,a5
    800016b6:	40f707bb          	subw	a5,a4,a5
    800016ba:	2781                	sext.w	a5,a5
}
    800016bc:	853e                	mv	a0,a5
    800016be:	7422                	ld	s0,40(sp)
    800016c0:	6145                	addi	sp,sp,48
    800016c2:	8082                	ret

00000000800016c4 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    800016c4:	7139                	addi	sp,sp,-64
    800016c6:	fc22                	sd	s0,56(sp)
    800016c8:	0080                	addi	s0,sp,64
    800016ca:	fca43c23          	sd	a0,-40(s0)
    800016ce:	fcb43823          	sd	a1,-48(s0)
    800016d2:	87b2                	mv	a5,a2
    800016d4:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    800016d8:	fd843783          	ld	a5,-40(s0)
    800016dc:	fef43423          	sd	a5,-24(s0)
  while(n-- > 0 && (*s++ = *t++) != 0)
    800016e0:	0001                	nop
    800016e2:	fcc42783          	lw	a5,-52(s0)
    800016e6:	fff7871b          	addiw	a4,a5,-1
    800016ea:	fce42623          	sw	a4,-52(s0)
    800016ee:	02f05e63          	blez	a5,8000172a <strncpy+0x66>
    800016f2:	fd043703          	ld	a4,-48(s0)
    800016f6:	00170793          	addi	a5,a4,1
    800016fa:	fcf43823          	sd	a5,-48(s0)
    800016fe:	fd843783          	ld	a5,-40(s0)
    80001702:	00178693          	addi	a3,a5,1
    80001706:	fcd43c23          	sd	a3,-40(s0)
    8000170a:	00074703          	lbu	a4,0(a4)
    8000170e:	00e78023          	sb	a4,0(a5)
    80001712:	0007c783          	lbu	a5,0(a5)
    80001716:	f7f1                	bnez	a5,800016e2 <strncpy+0x1e>
    ;
  while(n-- > 0)
    80001718:	a809                	j	8000172a <strncpy+0x66>
    *s++ = 0;
    8000171a:	fd843783          	ld	a5,-40(s0)
    8000171e:	00178713          	addi	a4,a5,1
    80001722:	fce43c23          	sd	a4,-40(s0)
    80001726:	00078023          	sb	zero,0(a5)
  while(n-- > 0)
    8000172a:	fcc42783          	lw	a5,-52(s0)
    8000172e:	fff7871b          	addiw	a4,a5,-1
    80001732:	fce42623          	sw	a4,-52(s0)
    80001736:	fef042e3          	bgtz	a5,8000171a <strncpy+0x56>
  return os;
    8000173a:	fe843783          	ld	a5,-24(s0)
}
    8000173e:	853e                	mv	a0,a5
    80001740:	7462                	ld	s0,56(sp)
    80001742:	6121                	addi	sp,sp,64
    80001744:	8082                	ret

0000000080001746 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80001746:	7139                	addi	sp,sp,-64
    80001748:	fc22                	sd	s0,56(sp)
    8000174a:	0080                	addi	s0,sp,64
    8000174c:	fca43c23          	sd	a0,-40(s0)
    80001750:	fcb43823          	sd	a1,-48(s0)
    80001754:	87b2                	mv	a5,a2
    80001756:	fcf42623          	sw	a5,-52(s0)
  char *os;

  os = s;
    8000175a:	fd843783          	ld	a5,-40(s0)
    8000175e:	fef43423          	sd	a5,-24(s0)
  if(n <= 0)
    80001762:	fcc42783          	lw	a5,-52(s0)
    80001766:	2781                	sext.w	a5,a5
    80001768:	00f04563          	bgtz	a5,80001772 <safestrcpy+0x2c>
    return os;
    8000176c:	fe843783          	ld	a5,-24(s0)
    80001770:	a0a1                	j	800017b8 <safestrcpy+0x72>
  while(--n > 0 && (*s++ = *t++) != 0)
    80001772:	fcc42783          	lw	a5,-52(s0)
    80001776:	37fd                	addiw	a5,a5,-1
    80001778:	fcf42623          	sw	a5,-52(s0)
    8000177c:	fcc42783          	lw	a5,-52(s0)
    80001780:	2781                	sext.w	a5,a5
    80001782:	02f05563          	blez	a5,800017ac <safestrcpy+0x66>
    80001786:	fd043703          	ld	a4,-48(s0)
    8000178a:	00170793          	addi	a5,a4,1
    8000178e:	fcf43823          	sd	a5,-48(s0)
    80001792:	fd843783          	ld	a5,-40(s0)
    80001796:	00178693          	addi	a3,a5,1
    8000179a:	fcd43c23          	sd	a3,-40(s0)
    8000179e:	00074703          	lbu	a4,0(a4)
    800017a2:	00e78023          	sb	a4,0(a5)
    800017a6:	0007c783          	lbu	a5,0(a5)
    800017aa:	f7e1                	bnez	a5,80001772 <safestrcpy+0x2c>
    ;
  *s = 0;
    800017ac:	fd843783          	ld	a5,-40(s0)
    800017b0:	00078023          	sb	zero,0(a5)
  return os;
    800017b4:	fe843783          	ld	a5,-24(s0)
}
    800017b8:	853e                	mv	a0,a5
    800017ba:	7462                	ld	s0,56(sp)
    800017bc:	6121                	addi	sp,sp,64
    800017be:	8082                	ret

00000000800017c0 <strlen>:

int
strlen(const char *s)
{
    800017c0:	7179                	addi	sp,sp,-48
    800017c2:	f422                	sd	s0,40(sp)
    800017c4:	1800                	addi	s0,sp,48
    800017c6:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
    800017ca:	fe042623          	sw	zero,-20(s0)
    800017ce:	a031                	j	800017da <strlen+0x1a>
    800017d0:	fec42783          	lw	a5,-20(s0)
    800017d4:	2785                	addiw	a5,a5,1
    800017d6:	fef42623          	sw	a5,-20(s0)
    800017da:	fec42783          	lw	a5,-20(s0)
    800017de:	fd843703          	ld	a4,-40(s0)
    800017e2:	97ba                	add	a5,a5,a4
    800017e4:	0007c783          	lbu	a5,0(a5)
    800017e8:	f7e5                	bnez	a5,800017d0 <strlen+0x10>
    ;
  return n;
    800017ea:	fec42783          	lw	a5,-20(s0)
}
    800017ee:	853e                	mv	a0,a5
    800017f0:	7422                	ld	s0,40(sp)
    800017f2:	6145                	addi	sp,sp,48
    800017f4:	8082                	ret

00000000800017f6 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    800017f6:	1141                	addi	sp,sp,-16
    800017f8:	e406                	sd	ra,8(sp)
    800017fa:	e022                	sd	s0,0(sp)
    800017fc:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    800017fe:	00001097          	auipc	ra,0x1
    80001802:	fb8080e7          	jalr	-72(ra) # 800027b6 <cpuid>
    80001806:	87aa                	mv	a5,a0
    80001808:	efd5                	bnez	a5,800018c4 <main+0xce>
    consoleinit();
    8000180a:	fffff097          	auipc	ra,0xfffff
    8000180e:	048080e7          	jalr	72(ra) # 80000852 <consoleinit>
    printfinit();
    80001812:	fffff097          	auipc	ra,0xfffff
    80001816:	4be080e7          	jalr	1214(ra) # 80000cd0 <printfinit>
    printf("\n");
    8000181a:	0000a517          	auipc	a0,0xa
    8000181e:	86650513          	addi	a0,a0,-1946 # 8000b080 <etext+0x80>
    80001822:	fffff097          	auipc	ra,0xfffff
    80001826:	206080e7          	jalr	518(ra) # 80000a28 <printf>
    printf("xv6 kernel is booting\n");
    8000182a:	0000a517          	auipc	a0,0xa
    8000182e:	85e50513          	addi	a0,a0,-1954 # 8000b088 <etext+0x88>
    80001832:	fffff097          	auipc	ra,0xfffff
    80001836:	1f6080e7          	jalr	502(ra) # 80000a28 <printf>
    printf("\n");
    8000183a:	0000a517          	auipc	a0,0xa
    8000183e:	84650513          	addi	a0,a0,-1978 # 8000b080 <etext+0x80>
    80001842:	fffff097          	auipc	ra,0xfffff
    80001846:	1e6080e7          	jalr	486(ra) # 80000a28 <printf>
    kinit();         // physical page allocator
    8000184a:	fffff097          	auipc	ra,0xfffff
    8000184e:	794080e7          	jalr	1940(ra) # 80000fde <kinit>
    kvminit();       // create kernel page table
    80001852:	00000097          	auipc	ra,0x0
    80001856:	1f4080e7          	jalr	500(ra) # 80001a46 <kvminit>
    kvminithart();   // turn on paging
    8000185a:	00000097          	auipc	ra,0x0
    8000185e:	212080e7          	jalr	530(ra) # 80001a6c <kvminithart>
    procinit();      // process table
    80001862:	00001097          	auipc	ra,0x1
    80001866:	e8e080e7          	jalr	-370(ra) # 800026f0 <procinit>
    trapinit();      // trap vectors
    8000186a:	00002097          	auipc	ra,0x2
    8000186e:	4ae080e7          	jalr	1198(ra) # 80003d18 <trapinit>
    trapinithart();  // install kernel trap vector
    80001872:	00002097          	auipc	ra,0x2
    80001876:	4d0080e7          	jalr	1232(ra) # 80003d42 <trapinithart>
    plicinit();      // set up interrupt controller
    8000187a:	00007097          	auipc	ra,0x7
    8000187e:	360080e7          	jalr	864(ra) # 80008bda <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80001882:	00007097          	auipc	ra,0x7
    80001886:	37c080e7          	jalr	892(ra) # 80008bfe <plicinithart>
    binit();         // buffer cache
    8000188a:	00003097          	auipc	ra,0x3
    8000188e:	f7a080e7          	jalr	-134(ra) # 80004804 <binit>
    iinit();         // inode table
    80001892:	00003097          	auipc	ra,0x3
    80001896:	7c6080e7          	jalr	1990(ra) # 80005058 <iinit>
    fileinit();      // file table
    8000189a:	00005097          	auipc	ra,0x5
    8000189e:	168080e7          	jalr	360(ra) # 80006a02 <fileinit>
    virtio_disk_init(); // emulated hard disk
    800018a2:	00007097          	auipc	ra,0x7
    800018a6:	430080e7          	jalr	1072(ra) # 80008cd2 <virtio_disk_init>
    userinit();      // first user process
    800018aa:	00001097          	auipc	ra,0x1
    800018ae:	302080e7          	jalr	770(ra) # 80002bac <userinit>
    __sync_synchronize();
    800018b2:	0ff0000f          	fence
    started = 1;
    800018b6:	00013797          	auipc	a5,0x13
    800018ba:	9ea78793          	addi	a5,a5,-1558 # 800142a0 <started>
    800018be:	4705                	li	a4,1
    800018c0:	c398                	sw	a4,0(a5)
    800018c2:	a0a9                	j	8000190c <main+0x116>
  } else {
    while(started == 0)
    800018c4:	0001                	nop
    800018c6:	00013797          	auipc	a5,0x13
    800018ca:	9da78793          	addi	a5,a5,-1574 # 800142a0 <started>
    800018ce:	439c                	lw	a5,0(a5)
    800018d0:	2781                	sext.w	a5,a5
    800018d2:	dbf5                	beqz	a5,800018c6 <main+0xd0>
      ;
    __sync_synchronize();
    800018d4:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    800018d8:	00001097          	auipc	ra,0x1
    800018dc:	ede080e7          	jalr	-290(ra) # 800027b6 <cpuid>
    800018e0:	87aa                	mv	a5,a0
    800018e2:	85be                	mv	a1,a5
    800018e4:	00009517          	auipc	a0,0x9
    800018e8:	7bc50513          	addi	a0,a0,1980 # 8000b0a0 <etext+0xa0>
    800018ec:	fffff097          	auipc	ra,0xfffff
    800018f0:	13c080e7          	jalr	316(ra) # 80000a28 <printf>
    kvminithart();    // turn on paging
    800018f4:	00000097          	auipc	ra,0x0
    800018f8:	178080e7          	jalr	376(ra) # 80001a6c <kvminithart>
    trapinithart();   // install kernel trap vector
    800018fc:	00002097          	auipc	ra,0x2
    80001900:	446080e7          	jalr	1094(ra) # 80003d42 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80001904:	00007097          	auipc	ra,0x7
    80001908:	2fa080e7          	jalr	762(ra) # 80008bfe <plicinithart>
  }

  scheduler();        
    8000190c:	00002097          	auipc	ra,0x2
    80001910:	922080e7          	jalr	-1758(ra) # 8000322e <scheduler>

0000000080001914 <w_satp>:
{
    80001914:	1101                	addi	sp,sp,-32
    80001916:	ec22                	sd	s0,24(sp)
    80001918:	1000                	addi	s0,sp,32
    8000191a:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw satp, %0" : : "r" (x));
    8000191e:	fe843783          	ld	a5,-24(s0)
    80001922:	18079073          	csrw	satp,a5
}
    80001926:	0001                	nop
    80001928:	6462                	ld	s0,24(sp)
    8000192a:	6105                	addi	sp,sp,32
    8000192c:	8082                	ret

000000008000192e <sfence_vma>:
}

// flush the TLB.
static inline void
sfence_vma()
{
    8000192e:	1141                	addi	sp,sp,-16
    80001930:	e422                	sd	s0,8(sp)
    80001932:	0800                	addi	s0,sp,16
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80001934:	12000073          	sfence.vma
}
    80001938:	0001                	nop
    8000193a:	6422                	ld	s0,8(sp)
    8000193c:	0141                	addi	sp,sp,16
    8000193e:	8082                	ret

0000000080001940 <kvmmake>:
extern char trampoline[]; // trampoline.S

// Make a direct-map page table for the kernel.
pagetable_t
kvmmake(void)
{
    80001940:	1101                	addi	sp,sp,-32
    80001942:	ec06                	sd	ra,24(sp)
    80001944:	e822                	sd	s0,16(sp)
    80001946:	1000                	addi	s0,sp,32
  pagetable_t kpgtbl;

  kpgtbl = (pagetable_t) kalloc();
    80001948:	fffff097          	auipc	ra,0xfffff
    8000194c:	7d2080e7          	jalr	2002(ra) # 8000111a <kalloc>
    80001950:	fea43423          	sd	a0,-24(s0)
  memset(kpgtbl, 0, PGSIZE);
    80001954:	6605                	lui	a2,0x1
    80001956:	4581                	li	a1,0
    80001958:	fe843503          	ld	a0,-24(s0)
    8000195c:	00000097          	auipc	ra,0x0
    80001960:	ae6080e7          	jalr	-1306(ra) # 80001442 <memset>

  // uart registers
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80001964:	4719                	li	a4,6
    80001966:	6685                	lui	a3,0x1
    80001968:	10000637          	lui	a2,0x10000
    8000196c:	100005b7          	lui	a1,0x10000
    80001970:	fe843503          	ld	a0,-24(s0)
    80001974:	00000097          	auipc	ra,0x0
    80001978:	298080e7          	jalr	664(ra) # 80001c0c <kvmmap>

  // virtio mmio disk interface
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000197c:	4719                	li	a4,6
    8000197e:	6685                	lui	a3,0x1
    80001980:	10001637          	lui	a2,0x10001
    80001984:	100015b7          	lui	a1,0x10001
    80001988:	fe843503          	ld	a0,-24(s0)
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	280080e7          	jalr	640(ra) # 80001c0c <kvmmap>

  // PLIC
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80001994:	4719                	li	a4,6
    80001996:	004006b7          	lui	a3,0x400
    8000199a:	0c000637          	lui	a2,0xc000
    8000199e:	0c0005b7          	lui	a1,0xc000
    800019a2:	fe843503          	ld	a0,-24(s0)
    800019a6:	00000097          	auipc	ra,0x0
    800019aa:	266080e7          	jalr	614(ra) # 80001c0c <kvmmap>

  // map kernel text executable and read-only.
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800019ae:	00009717          	auipc	a4,0x9
    800019b2:	65270713          	addi	a4,a4,1618 # 8000b000 <etext>
    800019b6:	800007b7          	lui	a5,0x80000
    800019ba:	97ba                	add	a5,a5,a4
    800019bc:	4729                	li	a4,10
    800019be:	86be                	mv	a3,a5
    800019c0:	4785                	li	a5,1
    800019c2:	01f79613          	slli	a2,a5,0x1f
    800019c6:	4785                	li	a5,1
    800019c8:	01f79593          	slli	a1,a5,0x1f
    800019cc:	fe843503          	ld	a0,-24(s0)
    800019d0:	00000097          	auipc	ra,0x0
    800019d4:	23c080e7          	jalr	572(ra) # 80001c0c <kvmmap>

  // map kernel data and the physical RAM we'll make use of.
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800019d8:	00009597          	auipc	a1,0x9
    800019dc:	62858593          	addi	a1,a1,1576 # 8000b000 <etext>
    800019e0:	00009617          	auipc	a2,0x9
    800019e4:	62060613          	addi	a2,a2,1568 # 8000b000 <etext>
    800019e8:	00009797          	auipc	a5,0x9
    800019ec:	61878793          	addi	a5,a5,1560 # 8000b000 <etext>
    800019f0:	4745                	li	a4,17
    800019f2:	076e                	slli	a4,a4,0x1b
    800019f4:	40f707b3          	sub	a5,a4,a5
    800019f8:	4719                	li	a4,6
    800019fa:	86be                	mv	a3,a5
    800019fc:	fe843503          	ld	a0,-24(s0)
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	20c080e7          	jalr	524(ra) # 80001c0c <kvmmap>

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80001a08:	00008797          	auipc	a5,0x8
    80001a0c:	5f878793          	addi	a5,a5,1528 # 8000a000 <_trampoline>
    80001a10:	4729                	li	a4,10
    80001a12:	6685                	lui	a3,0x1
    80001a14:	863e                	mv	a2,a5
    80001a16:	040007b7          	lui	a5,0x4000
    80001a1a:	17fd                	addi	a5,a5,-1
    80001a1c:	00c79593          	slli	a1,a5,0xc
    80001a20:	fe843503          	ld	a0,-24(s0)
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	1e8080e7          	jalr	488(ra) # 80001c0c <kvmmap>

  // map kernel stacks
  proc_mapstacks(kpgtbl);
    80001a2c:	fe843503          	ld	a0,-24(s0)
    80001a30:	00001097          	auipc	ra,0x1
    80001a34:	c04080e7          	jalr	-1020(ra) # 80002634 <proc_mapstacks>
  
  return kpgtbl;
    80001a38:	fe843783          	ld	a5,-24(s0)
}
    80001a3c:	853e                	mv	a0,a5
    80001a3e:	60e2                	ld	ra,24(sp)
    80001a40:	6442                	ld	s0,16(sp)
    80001a42:	6105                	addi	sp,sp,32
    80001a44:	8082                	ret

0000000080001a46 <kvminit>:

// Initialize the one kernel_pagetable
void
kvminit(void)
{
    80001a46:	1141                	addi	sp,sp,-16
    80001a48:	e406                	sd	ra,8(sp)
    80001a4a:	e022                	sd	s0,0(sp)
    80001a4c:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001a4e:	00000097          	auipc	ra,0x0
    80001a52:	ef2080e7          	jalr	-270(ra) # 80001940 <kvmmake>
    80001a56:	872a                	mv	a4,a0
    80001a58:	0000a797          	auipc	a5,0xa
    80001a5c:	5c078793          	addi	a5,a5,1472 # 8000c018 <kernel_pagetable>
    80001a60:	e398                	sd	a4,0(a5)
}
    80001a62:	0001                	nop
    80001a64:	60a2                	ld	ra,8(sp)
    80001a66:	6402                	ld	s0,0(sp)
    80001a68:	0141                	addi	sp,sp,16
    80001a6a:	8082                	ret

0000000080001a6c <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80001a6c:	1141                	addi	sp,sp,-16
    80001a6e:	e406                	sd	ra,8(sp)
    80001a70:	e022                	sd	s0,0(sp)
    80001a72:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80001a74:	0000a797          	auipc	a5,0xa
    80001a78:	5a478793          	addi	a5,a5,1444 # 8000c018 <kernel_pagetable>
    80001a7c:	639c                	ld	a5,0(a5)
    80001a7e:	00c7d713          	srli	a4,a5,0xc
    80001a82:	57fd                	li	a5,-1
    80001a84:	17fe                	slli	a5,a5,0x3f
    80001a86:	8fd9                	or	a5,a5,a4
    80001a88:	853e                	mv	a0,a5
    80001a8a:	00000097          	auipc	ra,0x0
    80001a8e:	e8a080e7          	jalr	-374(ra) # 80001914 <w_satp>
  sfence_vma();
    80001a92:	00000097          	auipc	ra,0x0
    80001a96:	e9c080e7          	jalr	-356(ra) # 8000192e <sfence_vma>
}
    80001a9a:	0001                	nop
    80001a9c:	60a2                	ld	ra,8(sp)
    80001a9e:	6402                	ld	s0,0(sp)
    80001aa0:	0141                	addi	sp,sp,16
    80001aa2:	8082                	ret

0000000080001aa4 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80001aa4:	7139                	addi	sp,sp,-64
    80001aa6:	fc06                	sd	ra,56(sp)
    80001aa8:	f822                	sd	s0,48(sp)
    80001aaa:	0080                	addi	s0,sp,64
    80001aac:	fca43c23          	sd	a0,-40(s0)
    80001ab0:	fcb43823          	sd	a1,-48(s0)
    80001ab4:	87b2                	mv	a5,a2
    80001ab6:	fcf42623          	sw	a5,-52(s0)
  if(va >= MAXVA)
    80001aba:	fd043703          	ld	a4,-48(s0)
    80001abe:	57fd                	li	a5,-1
    80001ac0:	83e9                	srli	a5,a5,0x1a
    80001ac2:	00e7fa63          	bgeu	a5,a4,80001ad6 <walk+0x32>
    panic("walk");
    80001ac6:	00009517          	auipc	a0,0x9
    80001aca:	5f250513          	addi	a0,a0,1522 # 8000b0b8 <etext+0xb8>
    80001ace:	fffff097          	auipc	ra,0xfffff
    80001ad2:	1b0080e7          	jalr	432(ra) # 80000c7e <panic>

  for(int level = 2; level > 0; level--) {
    80001ad6:	4789                	li	a5,2
    80001ad8:	fef42623          	sw	a5,-20(s0)
    80001adc:	a849                	j	80001b6e <walk+0xca>
    pte_t *pte = &pagetable[PX(level, va)];
    80001ade:	fec42703          	lw	a4,-20(s0)
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
    80001b12:	cb89                	beqz	a5,80001b24 <walk+0x80>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001b14:	fe043783          	ld	a5,-32(s0)
    80001b18:	639c                	ld	a5,0(a5)
    80001b1a:	83a9                	srli	a5,a5,0xa
    80001b1c:	07b2                	slli	a5,a5,0xc
    80001b1e:	fcf43c23          	sd	a5,-40(s0)
    80001b22:	a089                	j	80001b64 <walk+0xc0>
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80001b24:	fcc42783          	lw	a5,-52(s0)
    80001b28:	2781                	sext.w	a5,a5
    80001b2a:	cb91                	beqz	a5,80001b3e <walk+0x9a>
    80001b2c:	fffff097          	auipc	ra,0xfffff
    80001b30:	5ee080e7          	jalr	1518(ra) # 8000111a <kalloc>
    80001b34:	fca43c23          	sd	a0,-40(s0)
    80001b38:	fd843783          	ld	a5,-40(s0)
    80001b3c:	e399                	bnez	a5,80001b42 <walk+0x9e>
        return 0;
    80001b3e:	4781                	li	a5,0
    80001b40:	a0a9                	j	80001b8a <walk+0xe6>
      memset(pagetable, 0, PGSIZE);
    80001b42:	6605                	lui	a2,0x1
    80001b44:	4581                	li	a1,0
    80001b46:	fd843503          	ld	a0,-40(s0)
    80001b4a:	00000097          	auipc	ra,0x0
    80001b4e:	8f8080e7          	jalr	-1800(ra) # 80001442 <memset>
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
    80001b74:	f6f045e3          	bgtz	a5,80001ade <walk+0x3a>
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
    80001bc2:	ee6080e7          	jalr	-282(ra) # 80001aa4 <walk>
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
    80001c58:	02a080e7          	jalr	42(ra) # 80000c7e <panic>
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
    80001c96:	fec080e7          	jalr	-20(ra) # 80000c7e <panic>
  
  a = PGROUNDDOWN(va);
    80001c9a:	fc043703          	ld	a4,-64(s0)
    80001c9e:	77fd                	lui	a5,0xfffff
    80001ca0:	8ff9                	and	a5,a5,a4
    80001ca2:	fef43423          	sd	a5,-24(s0)
  last = PGROUNDDOWN(va + size - 1);
    80001ca6:	fc043703          	ld	a4,-64(s0)
    80001caa:	fb843783          	ld	a5,-72(s0)
    80001cae:	97ba                	add	a5,a5,a4
    80001cb0:	fff78713          	addi	a4,a5,-1 # ffffffffffffefff <end+0xffffffff7ffd5fff>
    80001cb4:	77fd                	lui	a5,0xfffff
    80001cb6:	8ff9                	and	a5,a5,a4
    80001cb8:	fef43023          	sd	a5,-32(s0)
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80001cbc:	4605                	li	a2,1
    80001cbe:	fe843583          	ld	a1,-24(s0)
    80001cc2:	fc843503          	ld	a0,-56(s0)
    80001cc6:	00000097          	auipc	ra,0x0
    80001cca:	dde080e7          	jalr	-546(ra) # 80001aa4 <walk>
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
    80001cf2:	f90080e7          	jalr	-112(ra) # 80000c7e <panic>
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
    80001d76:	f0c080e7          	jalr	-244(ra) # 80000c7e <panic>

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001d7a:	fc043783          	ld	a5,-64(s0)
    80001d7e:	fef43423          	sd	a5,-24(s0)
    80001d82:	a045                	j	80001e22 <uvmunmap+0xde>
    if((pte = walk(pagetable, a, 0)) == 0)
    80001d84:	4601                	li	a2,0
    80001d86:	fe843583          	ld	a1,-24(s0)
    80001d8a:	fc843503          	ld	a0,-56(s0)
    80001d8e:	00000097          	auipc	ra,0x0
    80001d92:	d16080e7          	jalr	-746(ra) # 80001aa4 <walk>
    80001d96:	fea43023          	sd	a0,-32(s0)
    80001d9a:	fe043783          	ld	a5,-32(s0)
    80001d9e:	eb89                	bnez	a5,80001db0 <uvmunmap+0x6c>
      panic("uvmunmap: walk");
    80001da0:	00009517          	auipc	a0,0x9
    80001da4:	36050513          	addi	a0,a0,864 # 8000b100 <etext+0x100>
    80001da8:	fffff097          	auipc	ra,0xfffff
    80001dac:	ed6080e7          	jalr	-298(ra) # 80000c7e <panic>
    if((*pte & PTE_V) == 0)
    80001db0:	fe043783          	ld	a5,-32(s0)
    80001db4:	639c                	ld	a5,0(a5)
    80001db6:	8b85                	andi	a5,a5,1
    80001db8:	eb89                	bnez	a5,80001dca <uvmunmap+0x86>
      panic("uvmunmap: not mapped");
    80001dba:	00009517          	auipc	a0,0x9
    80001dbe:	35650513          	addi	a0,a0,854 # 8000b110 <etext+0x110>
    80001dc2:	fffff097          	auipc	ra,0xfffff
    80001dc6:	ebc080e7          	jalr	-324(ra) # 80000c7e <panic>
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
    80001de6:	e9c080e7          	jalr	-356(ra) # 80000c7e <panic>
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
    80001e0a:	270080e7          	jalr	624(ra) # 80001076 <kfree>
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
    80001e50:	2ce080e7          	jalr	718(ra) # 8000111a <kalloc>
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
    80001e6e:	5d8080e7          	jalr	1496(ra) # 80001442 <memset>
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
    80001eb0:	dd2080e7          	jalr	-558(ra) # 80000c7e <panic>
  mem = kalloc();
    80001eb4:	fffff097          	auipc	ra,0xfffff
    80001eb8:	266080e7          	jalr	614(ra) # 8000111a <kalloc>
    80001ebc:	fea43423          	sd	a0,-24(s0)
  memset(mem, 0, PGSIZE);
    80001ec0:	6605                	lui	a2,0x1
    80001ec2:	4581                	li	a1,0
    80001ec4:	fe843503          	ld	a0,-24(s0)
    80001ec8:	fffff097          	auipc	ra,0xfffff
    80001ecc:	57a080e7          	jalr	1402(ra) # 80001442 <memset>
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
    80001efa:	630080e7          	jalr	1584(ra) # 80001526 <memmove>
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
    80001f4e:	1d0080e7          	jalr	464(ra) # 8000111a <kalloc>
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
    80001f80:	4c6080e7          	jalr	1222(ra) # 80001442 <memset>
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
    80001faa:	0d0080e7          	jalr	208(ra) # 80001076 <kfree>
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
    800020e4:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0xffffffff7ffd6000>
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
    800020fe:	b84080e7          	jalr	-1148(ra) # 80000c7e <panic>
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
    80002124:	f56080e7          	jalr	-170(ra) # 80001076 <kfree>
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
    800021a4:	904080e7          	jalr	-1788(ra) # 80001aa4 <walk>
    800021a8:	fea43023          	sd	a0,-32(s0)
    800021ac:	fe043783          	ld	a5,-32(s0)
    800021b0:	eb89                	bnez	a5,800021c2 <uvmcopy+0x46>
      panic("uvmcopy: pte should exist");
    800021b2:	00009517          	auipc	a0,0x9
    800021b6:	fbe50513          	addi	a0,a0,-66 # 8000b170 <etext+0x170>
    800021ba:	fffff097          	auipc	ra,0xfffff
    800021be:	ac4080e7          	jalr	-1340(ra) # 80000c7e <panic>
    if((*pte & PTE_V) == 0)
    800021c2:	fe043783          	ld	a5,-32(s0)
    800021c6:	639c                	ld	a5,0(a5)
    800021c8:	8b85                	andi	a5,a5,1
    800021ca:	eb89                	bnez	a5,800021dc <uvmcopy+0x60>
      panic("uvmcopy: page not present");
    800021cc:	00009517          	auipc	a0,0x9
    800021d0:	fc450513          	addi	a0,a0,-60 # 8000b190 <etext+0x190>
    800021d4:	fffff097          	auipc	ra,0xfffff
    800021d8:	aaa080e7          	jalr	-1366(ra) # 80000c7e <panic>
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
    800021fe:	f20080e7          	jalr	-224(ra) # 8000111a <kalloc>
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
    8000221c:	30e080e7          	jalr	782(ra) # 80001526 <memmove>
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
    80002248:	e32080e7          	jalr	-462(ra) # 80001076 <kfree>
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

0000000080002290 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80002290:	7179                	addi	sp,sp,-48
    80002292:	f406                	sd	ra,40(sp)
    80002294:	f022                	sd	s0,32(sp)
    80002296:	1800                	addi	s0,sp,48
    80002298:	fca43c23          	sd	a0,-40(s0)
    8000229c:	fcb43823          	sd	a1,-48(s0)
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    800022a0:	4601                	li	a2,0
    800022a2:	fd043583          	ld	a1,-48(s0)
    800022a6:	fd843503          	ld	a0,-40(s0)
    800022aa:	fffff097          	auipc	ra,0xfffff
    800022ae:	7fa080e7          	jalr	2042(ra) # 80001aa4 <walk>
    800022b2:	fea43423          	sd	a0,-24(s0)
  if(pte == 0)
    800022b6:	fe843783          	ld	a5,-24(s0)
    800022ba:	eb89                	bnez	a5,800022cc <uvmclear+0x3c>
    panic("uvmclear");
    800022bc:	00009517          	auipc	a0,0x9
    800022c0:	ef450513          	addi	a0,a0,-268 # 8000b1b0 <etext+0x1b0>
    800022c4:	fffff097          	auipc	ra,0xfffff
    800022c8:	9ba080e7          	jalr	-1606(ra) # 80000c7e <panic>
  *pte &= ~PTE_U;
    800022cc:	fe843783          	ld	a5,-24(s0)
    800022d0:	639c                	ld	a5,0(a5)
    800022d2:	fef7f713          	andi	a4,a5,-17
    800022d6:	fe843783          	ld	a5,-24(s0)
    800022da:	e398                	sd	a4,0(a5)
}
    800022dc:	0001                	nop
    800022de:	70a2                	ld	ra,40(sp)
    800022e0:	7402                	ld	s0,32(sp)
    800022e2:	6145                	addi	sp,sp,48
    800022e4:	8082                	ret

00000000800022e6 <copyout>:
// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
    800022e6:	715d                	addi	sp,sp,-80
    800022e8:	e486                	sd	ra,72(sp)
    800022ea:	e0a2                	sd	s0,64(sp)
    800022ec:	0880                	addi	s0,sp,80
    800022ee:	fca43423          	sd	a0,-56(s0)
    800022f2:	fcb43023          	sd	a1,-64(s0)
    800022f6:	fac43c23          	sd	a2,-72(s0)
    800022fa:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800022fe:	a055                	j	800023a2 <copyout+0xbc>
    va0 = PGROUNDDOWN(dstva);
    80002300:	fc043703          	ld	a4,-64(s0)
    80002304:	77fd                	lui	a5,0xfffff
    80002306:	8ff9                	and	a5,a5,a4
    80002308:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    8000230c:	fe043583          	ld	a1,-32(s0)
    80002310:	fc843503          	ld	a0,-56(s0)
    80002314:	00000097          	auipc	ra,0x0
    80002318:	880080e7          	jalr	-1920(ra) # 80001b94 <walkaddr>
    8000231c:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    80002320:	fd843783          	ld	a5,-40(s0)
    80002324:	e399                	bnez	a5,8000232a <copyout+0x44>
      return -1;
    80002326:	57fd                	li	a5,-1
    80002328:	a049                	j	800023aa <copyout+0xc4>
    n = PGSIZE - (dstva - va0);
    8000232a:	fe043703          	ld	a4,-32(s0)
    8000232e:	fc043783          	ld	a5,-64(s0)
    80002332:	8f1d                	sub	a4,a4,a5
    80002334:	6785                	lui	a5,0x1
    80002336:	97ba                	add	a5,a5,a4
    80002338:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000233c:	fe843703          	ld	a4,-24(s0)
    80002340:	fb043783          	ld	a5,-80(s0)
    80002344:	00e7f663          	bgeu	a5,a4,80002350 <copyout+0x6a>
      n = len;
    80002348:	fb043783          	ld	a5,-80(s0)
    8000234c:	fef43423          	sd	a5,-24(s0)
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80002350:	fc043703          	ld	a4,-64(s0)
    80002354:	fe043783          	ld	a5,-32(s0)
    80002358:	8f1d                	sub	a4,a4,a5
    8000235a:	fd843783          	ld	a5,-40(s0)
    8000235e:	97ba                	add	a5,a5,a4
    80002360:	873e                	mv	a4,a5
    80002362:	fe843783          	ld	a5,-24(s0)
    80002366:	2781                	sext.w	a5,a5
    80002368:	863e                	mv	a2,a5
    8000236a:	fb843583          	ld	a1,-72(s0)
    8000236e:	853a                	mv	a0,a4
    80002370:	fffff097          	auipc	ra,0xfffff
    80002374:	1b6080e7          	jalr	438(ra) # 80001526 <memmove>

    len -= n;
    80002378:	fb043703          	ld	a4,-80(s0)
    8000237c:	fe843783          	ld	a5,-24(s0)
    80002380:	40f707b3          	sub	a5,a4,a5
    80002384:	faf43823          	sd	a5,-80(s0)
    src += n;
    80002388:	fb843703          	ld	a4,-72(s0)
    8000238c:	fe843783          	ld	a5,-24(s0)
    80002390:	97ba                	add	a5,a5,a4
    80002392:	faf43c23          	sd	a5,-72(s0)
    dstva = va0 + PGSIZE;
    80002396:	fe043703          	ld	a4,-32(s0)
    8000239a:	6785                	lui	a5,0x1
    8000239c:	97ba                	add	a5,a5,a4
    8000239e:	fcf43023          	sd	a5,-64(s0)
  while(len > 0){
    800023a2:	fb043783          	ld	a5,-80(s0)
    800023a6:	ffa9                	bnez	a5,80002300 <copyout+0x1a>
  }
  return 0;
    800023a8:	4781                	li	a5,0
}
    800023aa:	853e                	mv	a0,a5
    800023ac:	60a6                	ld	ra,72(sp)
    800023ae:	6406                	ld	s0,64(sp)
    800023b0:	6161                	addi	sp,sp,80
    800023b2:	8082                	ret

00000000800023b4 <copyin>:
// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
    800023b4:	715d                	addi	sp,sp,-80
    800023b6:	e486                	sd	ra,72(sp)
    800023b8:	e0a2                	sd	s0,64(sp)
    800023ba:	0880                	addi	s0,sp,80
    800023bc:	fca43423          	sd	a0,-56(s0)
    800023c0:	fcb43023          	sd	a1,-64(s0)
    800023c4:	fac43c23          	sd	a2,-72(s0)
    800023c8:	fad43823          	sd	a3,-80(s0)
  uint64 n, va0, pa0;

  while(len > 0){
    800023cc:	a055                	j	80002470 <copyin+0xbc>
    va0 = PGROUNDDOWN(srcva);
    800023ce:	fb843703          	ld	a4,-72(s0)
    800023d2:	77fd                	lui	a5,0xfffff
    800023d4:	8ff9                	and	a5,a5,a4
    800023d6:	fef43023          	sd	a5,-32(s0)
    pa0 = walkaddr(pagetable, va0);
    800023da:	fe043583          	ld	a1,-32(s0)
    800023de:	fc843503          	ld	a0,-56(s0)
    800023e2:	fffff097          	auipc	ra,0xfffff
    800023e6:	7b2080e7          	jalr	1970(ra) # 80001b94 <walkaddr>
    800023ea:	fca43c23          	sd	a0,-40(s0)
    if(pa0 == 0)
    800023ee:	fd843783          	ld	a5,-40(s0)
    800023f2:	e399                	bnez	a5,800023f8 <copyin+0x44>
      return -1;
    800023f4:	57fd                	li	a5,-1
    800023f6:	a049                	j	80002478 <copyin+0xc4>
    n = PGSIZE - (srcva - va0);
    800023f8:	fe043703          	ld	a4,-32(s0)
    800023fc:	fb843783          	ld	a5,-72(s0)
    80002400:	8f1d                	sub	a4,a4,a5
    80002402:	6785                	lui	a5,0x1
    80002404:	97ba                	add	a5,a5,a4
    80002406:	fef43423          	sd	a5,-24(s0)
    if(n > len)
    8000240a:	fe843703          	ld	a4,-24(s0)
    8000240e:	fb043783          	ld	a5,-80(s0)
    80002412:	00e7f663          	bgeu	a5,a4,8000241e <copyin+0x6a>
      n = len;
    80002416:	fb043783          	ld	a5,-80(s0)
    8000241a:	fef43423          	sd	a5,-24(s0)
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    8000241e:	fb843703          	ld	a4,-72(s0)
    80002422:	fe043783          	ld	a5,-32(s0)
    80002426:	8f1d                	sub	a4,a4,a5
    80002428:	fd843783          	ld	a5,-40(s0)
    8000242c:	97ba                	add	a5,a5,a4
    8000242e:	873e                	mv	a4,a5
    80002430:	fe843783          	ld	a5,-24(s0)
    80002434:	2781                	sext.w	a5,a5
    80002436:	863e                	mv	a2,a5
    80002438:	85ba                	mv	a1,a4
    8000243a:	fc043503          	ld	a0,-64(s0)
    8000243e:	fffff097          	auipc	ra,0xfffff
    80002442:	0e8080e7          	jalr	232(ra) # 80001526 <memmove>

    len -= n;
    80002446:	fb043703          	ld	a4,-80(s0)
    8000244a:	fe843783          	ld	a5,-24(s0)
    8000244e:	40f707b3          	sub	a5,a4,a5
    80002452:	faf43823          	sd	a5,-80(s0)
    dst += n;
    80002456:	fc043703          	ld	a4,-64(s0)
    8000245a:	fe843783          	ld	a5,-24(s0)
    8000245e:	97ba                	add	a5,a5,a4
    80002460:	fcf43023          	sd	a5,-64(s0)
    srcva = va0 + PGSIZE;
    80002464:	fe043703          	ld	a4,-32(s0)
    80002468:	6785                	lui	a5,0x1
    8000246a:	97ba                	add	a5,a5,a4
    8000246c:	faf43c23          	sd	a5,-72(s0)
  while(len > 0){
    80002470:	fb043783          	ld	a5,-80(s0)
    80002474:	ffa9                	bnez	a5,800023ce <copyin+0x1a>
  }
  return 0;
    80002476:	4781                	li	a5,0
}
    80002478:	853e                	mv	a0,a5
    8000247a:	60a6                	ld	ra,72(sp)
    8000247c:	6406                	ld	s0,64(sp)
    8000247e:	6161                	addi	sp,sp,80
    80002480:	8082                	ret

0000000080002482 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80002482:	711d                	addi	sp,sp,-96
    80002484:	ec86                	sd	ra,88(sp)
    80002486:	e8a2                	sd	s0,80(sp)
    80002488:	1080                	addi	s0,sp,96
    8000248a:	faa43c23          	sd	a0,-72(s0)
    8000248e:	fab43823          	sd	a1,-80(s0)
    80002492:	fac43423          	sd	a2,-88(s0)
    80002496:	fad43023          	sd	a3,-96(s0)
  uint64 n, va0, pa0;
  int got_null = 0;
    8000249a:	fe042223          	sw	zero,-28(s0)

  while(got_null == 0 && max > 0){
    8000249e:	a0f1                	j	8000256a <copyinstr+0xe8>
    va0 = PGROUNDDOWN(srcva);
    800024a0:	fa843703          	ld	a4,-88(s0)
    800024a4:	77fd                	lui	a5,0xfffff
    800024a6:	8ff9                	and	a5,a5,a4
    800024a8:	fcf43823          	sd	a5,-48(s0)
    pa0 = walkaddr(pagetable, va0);
    800024ac:	fd043583          	ld	a1,-48(s0)
    800024b0:	fb843503          	ld	a0,-72(s0)
    800024b4:	fffff097          	auipc	ra,0xfffff
    800024b8:	6e0080e7          	jalr	1760(ra) # 80001b94 <walkaddr>
    800024bc:	fca43423          	sd	a0,-56(s0)
    if(pa0 == 0)
    800024c0:	fc843783          	ld	a5,-56(s0)
    800024c4:	e399                	bnez	a5,800024ca <copyinstr+0x48>
      return -1;
    800024c6:	57fd                	li	a5,-1
    800024c8:	a87d                	j	80002586 <copyinstr+0x104>
    n = PGSIZE - (srcva - va0);
    800024ca:	fd043703          	ld	a4,-48(s0)
    800024ce:	fa843783          	ld	a5,-88(s0)
    800024d2:	8f1d                	sub	a4,a4,a5
    800024d4:	6785                	lui	a5,0x1
    800024d6:	97ba                	add	a5,a5,a4
    800024d8:	fef43423          	sd	a5,-24(s0)
    if(n > max)
    800024dc:	fe843703          	ld	a4,-24(s0)
    800024e0:	fa043783          	ld	a5,-96(s0)
    800024e4:	00e7f663          	bgeu	a5,a4,800024f0 <copyinstr+0x6e>
      n = max;
    800024e8:	fa043783          	ld	a5,-96(s0)
    800024ec:	fef43423          	sd	a5,-24(s0)

    char *p = (char *) (pa0 + (srcva - va0));
    800024f0:	fa843703          	ld	a4,-88(s0)
    800024f4:	fd043783          	ld	a5,-48(s0)
    800024f8:	8f1d                	sub	a4,a4,a5
    800024fa:	fc843783          	ld	a5,-56(s0)
    800024fe:	97ba                	add	a5,a5,a4
    80002500:	fcf43c23          	sd	a5,-40(s0)
    while(n > 0){
    80002504:	a891                	j	80002558 <copyinstr+0xd6>
      if(*p == '\0'){
    80002506:	fd843783          	ld	a5,-40(s0)
    8000250a:	0007c783          	lbu	a5,0(a5) # 1000 <_entry-0x7ffff000>
    8000250e:	eb89                	bnez	a5,80002520 <copyinstr+0x9e>
        *dst = '\0';
    80002510:	fb043783          	ld	a5,-80(s0)
    80002514:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80002518:	4785                	li	a5,1
    8000251a:	fef42223          	sw	a5,-28(s0)
        break;
    8000251e:	a081                	j	8000255e <copyinstr+0xdc>
      } else {
        *dst = *p;
    80002520:	fd843783          	ld	a5,-40(s0)
    80002524:	0007c703          	lbu	a4,0(a5)
    80002528:	fb043783          	ld	a5,-80(s0)
    8000252c:	00e78023          	sb	a4,0(a5)
      }
      --n;
    80002530:	fe843783          	ld	a5,-24(s0)
    80002534:	17fd                	addi	a5,a5,-1
    80002536:	fef43423          	sd	a5,-24(s0)
      --max;
    8000253a:	fa043783          	ld	a5,-96(s0)
    8000253e:	17fd                	addi	a5,a5,-1
    80002540:	faf43023          	sd	a5,-96(s0)
      p++;
    80002544:	fd843783          	ld	a5,-40(s0)
    80002548:	0785                	addi	a5,a5,1
    8000254a:	fcf43c23          	sd	a5,-40(s0)
      dst++;
    8000254e:	fb043783          	ld	a5,-80(s0)
    80002552:	0785                	addi	a5,a5,1
    80002554:	faf43823          	sd	a5,-80(s0)
    while(n > 0){
    80002558:	fe843783          	ld	a5,-24(s0)
    8000255c:	f7cd                	bnez	a5,80002506 <copyinstr+0x84>
    }

    srcva = va0 + PGSIZE;
    8000255e:	fd043703          	ld	a4,-48(s0)
    80002562:	6785                	lui	a5,0x1
    80002564:	97ba                	add	a5,a5,a4
    80002566:	faf43423          	sd	a5,-88(s0)
  while(got_null == 0 && max > 0){
    8000256a:	fe442783          	lw	a5,-28(s0)
    8000256e:	2781                	sext.w	a5,a5
    80002570:	e781                	bnez	a5,80002578 <copyinstr+0xf6>
    80002572:	fa043783          	ld	a5,-96(s0)
    80002576:	f78d                	bnez	a5,800024a0 <copyinstr+0x1e>
  }
  if(got_null){
    80002578:	fe442783          	lw	a5,-28(s0)
    8000257c:	2781                	sext.w	a5,a5
    8000257e:	c399                	beqz	a5,80002584 <copyinstr+0x102>
    return 0;
    80002580:	4781                	li	a5,0
    80002582:	a011                	j	80002586 <copyinstr+0x104>
  } else {
    return -1;
    80002584:	57fd                	li	a5,-1
  }
}
    80002586:	853e                	mv	a0,a5
    80002588:	60e6                	ld	ra,88(sp)
    8000258a:	6446                	ld	s0,80(sp)
    8000258c:	6125                	addi	sp,sp,96
    8000258e:	8082                	ret

0000000080002590 <r_sstatus>:
{
    80002590:	1101                	addi	sp,sp,-32
    80002592:	ec22                	sd	s0,24(sp)
    80002594:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002596:	100027f3          	csrr	a5,sstatus
    8000259a:	fef43423          	sd	a5,-24(s0)
  return x;
    8000259e:	fe843783          	ld	a5,-24(s0)
}
    800025a2:	853e                	mv	a0,a5
    800025a4:	6462                	ld	s0,24(sp)
    800025a6:	6105                	addi	sp,sp,32
    800025a8:	8082                	ret

00000000800025aa <w_sstatus>:
{
    800025aa:	1101                	addi	sp,sp,-32
    800025ac:	ec22                	sd	s0,24(sp)
    800025ae:	1000                	addi	s0,sp,32
    800025b0:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800025b4:	fe843783          	ld	a5,-24(s0)
    800025b8:	10079073          	csrw	sstatus,a5
}
    800025bc:	0001                	nop
    800025be:	6462                	ld	s0,24(sp)
    800025c0:	6105                	addi	sp,sp,32
    800025c2:	8082                	ret

00000000800025c4 <intr_on>:
{
    800025c4:	1141                	addi	sp,sp,-16
    800025c6:	e406                	sd	ra,8(sp)
    800025c8:	e022                	sd	s0,0(sp)
    800025ca:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800025cc:	00000097          	auipc	ra,0x0
    800025d0:	fc4080e7          	jalr	-60(ra) # 80002590 <r_sstatus>
    800025d4:	87aa                	mv	a5,a0
    800025d6:	0027e793          	ori	a5,a5,2
    800025da:	853e                	mv	a0,a5
    800025dc:	00000097          	auipc	ra,0x0
    800025e0:	fce080e7          	jalr	-50(ra) # 800025aa <w_sstatus>
}
    800025e4:	0001                	nop
    800025e6:	60a2                	ld	ra,8(sp)
    800025e8:	6402                	ld	s0,0(sp)
    800025ea:	0141                	addi	sp,sp,16
    800025ec:	8082                	ret

00000000800025ee <intr_get>:
{
    800025ee:	1101                	addi	sp,sp,-32
    800025f0:	ec06                	sd	ra,24(sp)
    800025f2:	e822                	sd	s0,16(sp)
    800025f4:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    800025f6:	00000097          	auipc	ra,0x0
    800025fa:	f9a080e7          	jalr	-102(ra) # 80002590 <r_sstatus>
    800025fe:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80002602:	fe843783          	ld	a5,-24(s0)
    80002606:	8b89                	andi	a5,a5,2
    80002608:	00f037b3          	snez	a5,a5
    8000260c:	0ff7f793          	andi	a5,a5,255
    80002610:	2781                	sext.w	a5,a5
}
    80002612:	853e                	mv	a0,a5
    80002614:	60e2                	ld	ra,24(sp)
    80002616:	6442                	ld	s0,16(sp)
    80002618:	6105                	addi	sp,sp,32
    8000261a:	8082                	ret

000000008000261c <r_tp>:
{
    8000261c:	1101                	addi	sp,sp,-32
    8000261e:	ec22                	sd	s0,24(sp)
    80002620:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80002622:	8792                	mv	a5,tp
    80002624:	fef43423          	sd	a5,-24(s0)
  return x;
    80002628:	fe843783          	ld	a5,-24(s0)
}
    8000262c:	853e                	mv	a0,a5
    8000262e:	6462                	ld	s0,24(sp)
    80002630:	6105                	addi	sp,sp,32
    80002632:	8082                	ret

0000000080002634 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80002634:	7139                	addi	sp,sp,-64
    80002636:	fc06                	sd	ra,56(sp)
    80002638:	f822                	sd	s0,48(sp)
    8000263a:	0080                	addi	s0,sp,64
    8000263c:	fca43423          	sd	a0,-56(s0)
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80002640:	00012797          	auipc	a5,0x12
    80002644:	08078793          	addi	a5,a5,128 # 800146c0 <proc>
    80002648:	fef43423          	sd	a5,-24(s0)
    8000264c:	a061                	j	800026d4 <proc_mapstacks+0xa0>
    char *pa = kalloc();
    8000264e:	fffff097          	auipc	ra,0xfffff
    80002652:	acc080e7          	jalr	-1332(ra) # 8000111a <kalloc>
    80002656:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000265a:	fe043783          	ld	a5,-32(s0)
    8000265e:	eb89                	bnez	a5,80002670 <proc_mapstacks+0x3c>
      panic("kalloc");
    80002660:	00009517          	auipc	a0,0x9
    80002664:	b6050513          	addi	a0,a0,-1184 # 8000b1c0 <etext+0x1c0>
    80002668:	ffffe097          	auipc	ra,0xffffe
    8000266c:	616080e7          	jalr	1558(ra) # 80000c7e <panic>
    uint64 va = KSTACK((int) (p - proc));
    80002670:	fe843703          	ld	a4,-24(s0)
    80002674:	00012797          	auipc	a5,0x12
    80002678:	04c78793          	addi	a5,a5,76 # 800146c0 <proc>
    8000267c:	40f707b3          	sub	a5,a4,a5
    80002680:	4047d713          	srai	a4,a5,0x4
    80002684:	00009797          	auipc	a5,0x9
    80002688:	c2c78793          	addi	a5,a5,-980 # 8000b2b0 <etext+0x2b0>
    8000268c:	639c                	ld	a5,0(a5)
    8000268e:	02f707b3          	mul	a5,a4,a5
    80002692:	2781                	sext.w	a5,a5
    80002694:	2785                	addiw	a5,a5,1
    80002696:	2781                	sext.w	a5,a5
    80002698:	00d7979b          	slliw	a5,a5,0xd
    8000269c:	2781                	sext.w	a5,a5
    8000269e:	873e                	mv	a4,a5
    800026a0:	040007b7          	lui	a5,0x4000
    800026a4:	17fd                	addi	a5,a5,-1
    800026a6:	07b2                	slli	a5,a5,0xc
    800026a8:	8f99                	sub	a5,a5,a4
    800026aa:	fcf43c23          	sd	a5,-40(s0)
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    800026ae:	fe043783          	ld	a5,-32(s0)
    800026b2:	4719                	li	a4,6
    800026b4:	6685                	lui	a3,0x1
    800026b6:	863e                	mv	a2,a5
    800026b8:	fd843583          	ld	a1,-40(s0)
    800026bc:	fc843503          	ld	a0,-56(s0)
    800026c0:	fffff097          	auipc	ra,0xfffff
    800026c4:	54c080e7          	jalr	1356(ra) # 80001c0c <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    800026c8:	fe843783          	ld	a5,-24(s0)
    800026cc:	17078793          	addi	a5,a5,368 # 4000170 <_entry-0x7bfffe90>
    800026d0:	fef43423          	sd	a5,-24(s0)
    800026d4:	fe843703          	ld	a4,-24(s0)
    800026d8:	00018797          	auipc	a5,0x18
    800026dc:	be878793          	addi	a5,a5,-1048 # 8001a2c0 <pid_lock>
    800026e0:	f6f767e3          	bltu	a4,a5,8000264e <proc_mapstacks+0x1a>
  }
}
    800026e4:	0001                	nop
    800026e6:	0001                	nop
    800026e8:	70e2                	ld	ra,56(sp)
    800026ea:	7442                	ld	s0,48(sp)
    800026ec:	6121                	addi	sp,sp,64
    800026ee:	8082                	ret

00000000800026f0 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    800026f0:	1101                	addi	sp,sp,-32
    800026f2:	ec06                	sd	ra,24(sp)
    800026f4:	e822                	sd	s0,16(sp)
    800026f6:	1000                	addi	s0,sp,32
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    800026f8:	00009597          	auipc	a1,0x9
    800026fc:	ad058593          	addi	a1,a1,-1328 # 8000b1c8 <etext+0x1c8>
    80002700:	00018517          	auipc	a0,0x18
    80002704:	bc050513          	addi	a0,a0,-1088 # 8001a2c0 <pid_lock>
    80002708:	fffff097          	auipc	ra,0xfffff
    8000270c:	b36080e7          	jalr	-1226(ra) # 8000123e <initlock>
  initlock(&wait_lock, "wait_lock");
    80002710:	00009597          	auipc	a1,0x9
    80002714:	ac058593          	addi	a1,a1,-1344 # 8000b1d0 <etext+0x1d0>
    80002718:	00018517          	auipc	a0,0x18
    8000271c:	bc050513          	addi	a0,a0,-1088 # 8001a2d8 <wait_lock>
    80002720:	fffff097          	auipc	ra,0xfffff
    80002724:	b1e080e7          	jalr	-1250(ra) # 8000123e <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80002728:	00012797          	auipc	a5,0x12
    8000272c:	f9878793          	addi	a5,a5,-104 # 800146c0 <proc>
    80002730:	fef43423          	sd	a5,-24(s0)
    80002734:	a09d                	j	8000279a <procinit+0xaa>
      initlock(&p->lock, "proc");
    80002736:	fe843783          	ld	a5,-24(s0)
    8000273a:	00009597          	auipc	a1,0x9
    8000273e:	aa658593          	addi	a1,a1,-1370 # 8000b1e0 <etext+0x1e0>
    80002742:	853e                	mv	a0,a5
    80002744:	fffff097          	auipc	ra,0xfffff
    80002748:	afa080e7          	jalr	-1286(ra) # 8000123e <initlock>
      p->kstack = KSTACK((int) (p - proc));
    8000274c:	fe843703          	ld	a4,-24(s0)
    80002750:	00012797          	auipc	a5,0x12
    80002754:	f7078793          	addi	a5,a5,-144 # 800146c0 <proc>
    80002758:	40f707b3          	sub	a5,a4,a5
    8000275c:	4047d713          	srai	a4,a5,0x4
    80002760:	00009797          	auipc	a5,0x9
    80002764:	b5078793          	addi	a5,a5,-1200 # 8000b2b0 <etext+0x2b0>
    80002768:	639c                	ld	a5,0(a5)
    8000276a:	02f707b3          	mul	a5,a4,a5
    8000276e:	2781                	sext.w	a5,a5
    80002770:	2785                	addiw	a5,a5,1
    80002772:	2781                	sext.w	a5,a5
    80002774:	00d7979b          	slliw	a5,a5,0xd
    80002778:	2781                	sext.w	a5,a5
    8000277a:	873e                	mv	a4,a5
    8000277c:	040007b7          	lui	a5,0x4000
    80002780:	17fd                	addi	a5,a5,-1
    80002782:	07b2                	slli	a5,a5,0xc
    80002784:	8f99                	sub	a5,a5,a4
    80002786:	873e                	mv	a4,a5
    80002788:	fe843783          	ld	a5,-24(s0)
    8000278c:	e7b8                	sd	a4,72(a5)
  for(p = proc; p < &proc[NPROC]; p++) {
    8000278e:	fe843783          	ld	a5,-24(s0)
    80002792:	17078793          	addi	a5,a5,368 # 4000170 <_entry-0x7bfffe90>
    80002796:	fef43423          	sd	a5,-24(s0)
    8000279a:	fe843703          	ld	a4,-24(s0)
    8000279e:	00018797          	auipc	a5,0x18
    800027a2:	b2278793          	addi	a5,a5,-1246 # 8001a2c0 <pid_lock>
    800027a6:	f8f768e3          	bltu	a4,a5,80002736 <procinit+0x46>
  }
}
    800027aa:	0001                	nop
    800027ac:	0001                	nop
    800027ae:	60e2                	ld	ra,24(sp)
    800027b0:	6442                	ld	s0,16(sp)
    800027b2:	6105                	addi	sp,sp,32
    800027b4:	8082                	ret

00000000800027b6 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    800027b6:	1101                	addi	sp,sp,-32
    800027b8:	ec06                	sd	ra,24(sp)
    800027ba:	e822                	sd	s0,16(sp)
    800027bc:	1000                	addi	s0,sp,32
  int id = r_tp();
    800027be:	00000097          	auipc	ra,0x0
    800027c2:	e5e080e7          	jalr	-418(ra) # 8000261c <r_tp>
    800027c6:	87aa                	mv	a5,a0
    800027c8:	fef42623          	sw	a5,-20(s0)
  return id;
    800027cc:	fec42783          	lw	a5,-20(s0)
}
    800027d0:	853e                	mv	a0,a5
    800027d2:	60e2                	ld	ra,24(sp)
    800027d4:	6442                	ld	s0,16(sp)
    800027d6:	6105                	addi	sp,sp,32
    800027d8:	8082                	ret

00000000800027da <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    800027da:	1101                	addi	sp,sp,-32
    800027dc:	ec06                	sd	ra,24(sp)
    800027de:	e822                	sd	s0,16(sp)
    800027e0:	1000                	addi	s0,sp,32
  int id = cpuid();
    800027e2:	00000097          	auipc	ra,0x0
    800027e6:	fd4080e7          	jalr	-44(ra) # 800027b6 <cpuid>
    800027ea:	87aa                	mv	a5,a0
    800027ec:	fef42623          	sw	a5,-20(s0)
  struct cpu *c = &cpus[id];
    800027f0:	fec42783          	lw	a5,-20(s0)
    800027f4:	00779713          	slli	a4,a5,0x7
    800027f8:	00012797          	auipc	a5,0x12
    800027fc:	ac878793          	addi	a5,a5,-1336 # 800142c0 <cpus>
    80002800:	97ba                	add	a5,a5,a4
    80002802:	fef43023          	sd	a5,-32(s0)
  return c;
    80002806:	fe043783          	ld	a5,-32(s0)
}
    8000280a:	853e                	mv	a0,a5
    8000280c:	60e2                	ld	ra,24(sp)
    8000280e:	6442                	ld	s0,16(sp)
    80002810:	6105                	addi	sp,sp,32
    80002812:	8082                	ret

0000000080002814 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80002814:	1101                	addi	sp,sp,-32
    80002816:	ec06                	sd	ra,24(sp)
    80002818:	e822                	sd	s0,16(sp)
    8000281a:	1000                	addi	s0,sp,32
  push_off();
    8000281c:	fffff097          	auipc	ra,0xfffff
    80002820:	b50080e7          	jalr	-1200(ra) # 8000136c <push_off>
  struct cpu *c = mycpu();
    80002824:	00000097          	auipc	ra,0x0
    80002828:	fb6080e7          	jalr	-74(ra) # 800027da <mycpu>
    8000282c:	fea43423          	sd	a0,-24(s0)
  struct proc *p = c->proc;
    80002830:	fe843783          	ld	a5,-24(s0)
    80002834:	639c                	ld	a5,0(a5)
    80002836:	fef43023          	sd	a5,-32(s0)
  pop_off();
    8000283a:	fffff097          	auipc	ra,0xfffff
    8000283e:	b8a080e7          	jalr	-1142(ra) # 800013c4 <pop_off>
  return p;
    80002842:	fe043783          	ld	a5,-32(s0)
}
    80002846:	853e                	mv	a0,a5
    80002848:	60e2                	ld	ra,24(sp)
    8000284a:	6442                	ld	s0,16(sp)
    8000284c:	6105                	addi	sp,sp,32
    8000284e:	8082                	ret

0000000080002850 <allocpid>:

int
allocpid() {
    80002850:	1101                	addi	sp,sp,-32
    80002852:	ec06                	sd	ra,24(sp)
    80002854:	e822                	sd	s0,16(sp)
    80002856:	1000                	addi	s0,sp,32
  int pid;
  
  acquire(&pid_lock);
    80002858:	00018517          	auipc	a0,0x18
    8000285c:	a6850513          	addi	a0,a0,-1432 # 8001a2c0 <pid_lock>
    80002860:	fffff097          	auipc	ra,0xfffff
    80002864:	a0e080e7          	jalr	-1522(ra) # 8000126e <acquire>
  pid = nextpid;
    80002868:	00009797          	auipc	a5,0x9
    8000286c:	ec878793          	addi	a5,a5,-312 # 8000b730 <nextpid>
    80002870:	439c                	lw	a5,0(a5)
    80002872:	fef42623          	sw	a5,-20(s0)
  nextpid = nextpid + 1;
    80002876:	00009797          	auipc	a5,0x9
    8000287a:	eba78793          	addi	a5,a5,-326 # 8000b730 <nextpid>
    8000287e:	439c                	lw	a5,0(a5)
    80002880:	2785                	addiw	a5,a5,1
    80002882:	0007871b          	sext.w	a4,a5
    80002886:	00009797          	auipc	a5,0x9
    8000288a:	eaa78793          	addi	a5,a5,-342 # 8000b730 <nextpid>
    8000288e:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80002890:	00018517          	auipc	a0,0x18
    80002894:	a3050513          	addi	a0,a0,-1488 # 8001a2c0 <pid_lock>
    80002898:	fffff097          	auipc	ra,0xfffff
    8000289c:	a3a080e7          	jalr	-1478(ra) # 800012d2 <release>

  return pid;
    800028a0:	fec42783          	lw	a5,-20(s0)
}
    800028a4:	853e                	mv	a0,a5
    800028a6:	60e2                	ld	ra,24(sp)
    800028a8:	6442                	ld	s0,16(sp)
    800028aa:	6105                	addi	sp,sp,32
    800028ac:	8082                	ret

00000000800028ae <allocproc>:
// If found, initialize state required to run in the kernel,
// and return with p->lock held.
// If there are no free procs, or a memory allocation fails, return 0.
static struct proc*
allocproc(void)
{
    800028ae:	1101                	addi	sp,sp,-32
    800028b0:	ec06                	sd	ra,24(sp)
    800028b2:	e822                	sd	s0,16(sp)
    800028b4:	1000                	addi	s0,sp,32
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800028b6:	00012797          	auipc	a5,0x12
    800028ba:	e0a78793          	addi	a5,a5,-502 # 800146c0 <proc>
    800028be:	fef43423          	sd	a5,-24(s0)
    800028c2:	a80d                	j	800028f4 <allocproc+0x46>
    acquire(&p->lock);
    800028c4:	fe843783          	ld	a5,-24(s0)
    800028c8:	853e                	mv	a0,a5
    800028ca:	fffff097          	auipc	ra,0xfffff
    800028ce:	9a4080e7          	jalr	-1628(ra) # 8000126e <acquire>
    if(p->state == UNUSED) {
    800028d2:	fe843783          	ld	a5,-24(s0)
    800028d6:	4f9c                	lw	a5,24(a5)
    800028d8:	cb85                	beqz	a5,80002908 <allocproc+0x5a>
      goto found;
    } else {
      release(&p->lock);
    800028da:	fe843783          	ld	a5,-24(s0)
    800028de:	853e                	mv	a0,a5
    800028e0:	fffff097          	auipc	ra,0xfffff
    800028e4:	9f2080e7          	jalr	-1550(ra) # 800012d2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800028e8:	fe843783          	ld	a5,-24(s0)
    800028ec:	17078793          	addi	a5,a5,368
    800028f0:	fef43423          	sd	a5,-24(s0)
    800028f4:	fe843703          	ld	a4,-24(s0)
    800028f8:	00018797          	auipc	a5,0x18
    800028fc:	9c878793          	addi	a5,a5,-1592 # 8001a2c0 <pid_lock>
    80002900:	fcf762e3          	bltu	a4,a5,800028c4 <allocproc+0x16>
    }
  }
  return 0;
    80002904:	4781                	li	a5,0
    80002906:	a0c5                	j	800029e6 <allocproc+0x138>
      goto found;
    80002908:	0001                	nop

found:
  p->pid = allocpid();
    8000290a:	00000097          	auipc	ra,0x0
    8000290e:	f46080e7          	jalr	-186(ra) # 80002850 <allocpid>
    80002912:	87aa                	mv	a5,a0
    80002914:	873e                	mv	a4,a5
    80002916:	fe843783          	ld	a5,-24(s0)
    8000291a:	db98                	sw	a4,48(a5)
  p->state = USED;
    8000291c:	fe843783          	ld	a5,-24(s0)
    80002920:	4705                	li	a4,1
    80002922:	cf98                	sw	a4,24(a5)

  //añadimos campos
  p->priority = LOW_PRIORITY;
    80002924:	fe843783          	ld	a5,-24(s0)
    80002928:	4705                	li	a4,1
    8000292a:	dbd8                	sw	a4,52(a5)
  p->hticks = 0;
    8000292c:	fe843783          	ld	a5,-24(s0)
    80002930:	0207ac23          	sw	zero,56(a5)
  p->lticks = 0;
    80002934:	fe843783          	ld	a5,-24(s0)
    80002938:	0207ae23          	sw	zero,60(a5)

  // Allocate a trapframe page.
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000293c:	ffffe097          	auipc	ra,0xffffe
    80002940:	7de080e7          	jalr	2014(ra) # 8000111a <kalloc>
    80002944:	872a                	mv	a4,a0
    80002946:	fe843783          	ld	a5,-24(s0)
    8000294a:	f3b8                	sd	a4,96(a5)
    8000294c:	fe843783          	ld	a5,-24(s0)
    80002950:	73bc                	ld	a5,96(a5)
    80002952:	e385                	bnez	a5,80002972 <allocproc+0xc4>
    freeproc(p);
    80002954:	fe843503          	ld	a0,-24(s0)
    80002958:	00000097          	auipc	ra,0x0
    8000295c:	098080e7          	jalr	152(ra) # 800029f0 <freeproc>
    release(&p->lock);
    80002960:	fe843783          	ld	a5,-24(s0)
    80002964:	853e                	mv	a0,a5
    80002966:	fffff097          	auipc	ra,0xfffff
    8000296a:	96c080e7          	jalr	-1684(ra) # 800012d2 <release>
    return 0;
    8000296e:	4781                	li	a5,0
    80002970:	a89d                	j	800029e6 <allocproc+0x138>
  }

  // An empty user page table.
  p->pagetable = proc_pagetable(p);
    80002972:	fe843503          	ld	a0,-24(s0)
    80002976:	00000097          	auipc	ra,0x0
    8000297a:	118080e7          	jalr	280(ra) # 80002a8e <proc_pagetable>
    8000297e:	872a                	mv	a4,a0
    80002980:	fe843783          	ld	a5,-24(s0)
    80002984:	efb8                	sd	a4,88(a5)
  if(p->pagetable == 0){
    80002986:	fe843783          	ld	a5,-24(s0)
    8000298a:	6fbc                	ld	a5,88(a5)
    8000298c:	e385                	bnez	a5,800029ac <allocproc+0xfe>
    freeproc(p);
    8000298e:	fe843503          	ld	a0,-24(s0)
    80002992:	00000097          	auipc	ra,0x0
    80002996:	05e080e7          	jalr	94(ra) # 800029f0 <freeproc>
    release(&p->lock);
    8000299a:	fe843783          	ld	a5,-24(s0)
    8000299e:	853e                	mv	a0,a5
    800029a0:	fffff097          	auipc	ra,0xfffff
    800029a4:	932080e7          	jalr	-1742(ra) # 800012d2 <release>
    return 0;
    800029a8:	4781                	li	a5,0
    800029aa:	a835                	j	800029e6 <allocproc+0x138>
  }

  // Set up new context to start executing at forkret,
  // which returns to user space.
  memset(&p->context, 0, sizeof(p->context));
    800029ac:	fe843783          	ld	a5,-24(s0)
    800029b0:	06878793          	addi	a5,a5,104
    800029b4:	07000613          	li	a2,112
    800029b8:	4581                	li	a1,0
    800029ba:	853e                	mv	a0,a5
    800029bc:	fffff097          	auipc	ra,0xfffff
    800029c0:	a86080e7          	jalr	-1402(ra) # 80001442 <memset>
  p->context.ra = (uint64)forkret;
    800029c4:	00001717          	auipc	a4,0x1
    800029c8:	acc70713          	addi	a4,a4,-1332 # 80003490 <forkret>
    800029cc:	fe843783          	ld	a5,-24(s0)
    800029d0:	f7b8                	sd	a4,104(a5)
  p->context.sp = p->kstack + PGSIZE;
    800029d2:	fe843783          	ld	a5,-24(s0)
    800029d6:	67b8                	ld	a4,72(a5)
    800029d8:	6785                	lui	a5,0x1
    800029da:	973e                	add	a4,a4,a5
    800029dc:	fe843783          	ld	a5,-24(s0)
    800029e0:	fbb8                	sd	a4,112(a5)

  return p;
    800029e2:	fe843783          	ld	a5,-24(s0)
}        
    800029e6:	853e                	mv	a0,a5
    800029e8:	60e2                	ld	ra,24(sp)
    800029ea:	6442                	ld	s0,16(sp)
    800029ec:	6105                	addi	sp,sp,32
    800029ee:	8082                	ret

00000000800029f0 <freeproc>:
// free a proc structure and the data hanging from it,
// including user pages.
// p->lock must be held.
static void
freeproc(struct proc *p)
{
    800029f0:	1101                	addi	sp,sp,-32
    800029f2:	ec06                	sd	ra,24(sp)
    800029f4:	e822                	sd	s0,16(sp)
    800029f6:	1000                	addi	s0,sp,32
    800029f8:	fea43423          	sd	a0,-24(s0)
  if(p->trapframe)
    800029fc:	fe843783          	ld	a5,-24(s0)
    80002a00:	73bc                	ld	a5,96(a5)
    80002a02:	cb89                	beqz	a5,80002a14 <freeproc+0x24>
    kfree((void*)p->trapframe);
    80002a04:	fe843783          	ld	a5,-24(s0)
    80002a08:	73bc                	ld	a5,96(a5)
    80002a0a:	853e                	mv	a0,a5
    80002a0c:	ffffe097          	auipc	ra,0xffffe
    80002a10:	66a080e7          	jalr	1642(ra) # 80001076 <kfree>
  p->trapframe = 0;
    80002a14:	fe843783          	ld	a5,-24(s0)
    80002a18:	0607b023          	sd	zero,96(a5) # 1060 <_entry-0x7fffefa0>
  if(p->pagetable)
    80002a1c:	fe843783          	ld	a5,-24(s0)
    80002a20:	6fbc                	ld	a5,88(a5)
    80002a22:	cf89                	beqz	a5,80002a3c <freeproc+0x4c>
    proc_freepagetable(p->pagetable, p->sz);
    80002a24:	fe843783          	ld	a5,-24(s0)
    80002a28:	6fb8                	ld	a4,88(a5)
    80002a2a:	fe843783          	ld	a5,-24(s0)
    80002a2e:	6bbc                	ld	a5,80(a5)
    80002a30:	85be                	mv	a1,a5
    80002a32:	853a                	mv	a0,a4
    80002a34:	00000097          	auipc	ra,0x0
    80002a38:	11a080e7          	jalr	282(ra) # 80002b4e <proc_freepagetable>
  p->pagetable = 0;
    80002a3c:	fe843783          	ld	a5,-24(s0)
    80002a40:	0407bc23          	sd	zero,88(a5)
  p->sz = 0;
    80002a44:	fe843783          	ld	a5,-24(s0)
    80002a48:	0407b823          	sd	zero,80(a5)
  p->pid = 0;
    80002a4c:	fe843783          	ld	a5,-24(s0)
    80002a50:	0207a823          	sw	zero,48(a5)
  p->parent = 0;
    80002a54:	fe843783          	ld	a5,-24(s0)
    80002a58:	0407b023          	sd	zero,64(a5)
  p->name[0] = 0;
    80002a5c:	fe843783          	ld	a5,-24(s0)
    80002a60:	16078023          	sb	zero,352(a5)
  p->chan = 0;
    80002a64:	fe843783          	ld	a5,-24(s0)
    80002a68:	0207b023          	sd	zero,32(a5)
  p->killed = 0;
    80002a6c:	fe843783          	ld	a5,-24(s0)
    80002a70:	0207a423          	sw	zero,40(a5)
  p->xstate = 0;
    80002a74:	fe843783          	ld	a5,-24(s0)
    80002a78:	0207a623          	sw	zero,44(a5)
  p->state = UNUSED;
    80002a7c:	fe843783          	ld	a5,-24(s0)
    80002a80:	0007ac23          	sw	zero,24(a5)
}
    80002a84:	0001                	nop
    80002a86:	60e2                	ld	ra,24(sp)
    80002a88:	6442                	ld	s0,16(sp)
    80002a8a:	6105                	addi	sp,sp,32
    80002a8c:	8082                	ret

0000000080002a8e <proc_pagetable>:

// Create a user page table for a given process,
// with no user memory, but with trampoline pages.
pagetable_t
proc_pagetable(struct proc *p)
{
    80002a8e:	7179                	addi	sp,sp,-48
    80002a90:	f406                	sd	ra,40(sp)
    80002a92:	f022                	sd	s0,32(sp)
    80002a94:	1800                	addi	s0,sp,48
    80002a96:	fca43c23          	sd	a0,-40(s0)
  pagetable_t pagetable;

  // An empty page table.
  pagetable = uvmcreate();
    80002a9a:	fffff097          	auipc	ra,0xfffff
    80002a9e:	3aa080e7          	jalr	938(ra) # 80001e44 <uvmcreate>
    80002aa2:	fea43423          	sd	a0,-24(s0)
  if(pagetable == 0)
    80002aa6:	fe843783          	ld	a5,-24(s0)
    80002aaa:	e399                	bnez	a5,80002ab0 <proc_pagetable+0x22>
    return 0;
    80002aac:	4781                	li	a5,0
    80002aae:	a859                	j	80002b44 <proc_pagetable+0xb6>

  // map the trampoline code (for system call return)
  // at the highest user virtual address.
  // only the supervisor uses it, on the way
  // to/from user space, so not PTE_U.
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80002ab0:	00007797          	auipc	a5,0x7
    80002ab4:	55078793          	addi	a5,a5,1360 # 8000a000 <_trampoline>
    80002ab8:	4729                	li	a4,10
    80002aba:	86be                	mv	a3,a5
    80002abc:	6605                	lui	a2,0x1
    80002abe:	040007b7          	lui	a5,0x4000
    80002ac2:	17fd                	addi	a5,a5,-1
    80002ac4:	00c79593          	slli	a1,a5,0xc
    80002ac8:	fe843503          	ld	a0,-24(s0)
    80002acc:	fffff097          	auipc	ra,0xfffff
    80002ad0:	19a080e7          	jalr	410(ra) # 80001c66 <mappages>
    80002ad4:	87aa                	mv	a5,a0
    80002ad6:	0007db63          	bgez	a5,80002aec <proc_pagetable+0x5e>
              (uint64)trampoline, PTE_R | PTE_X) < 0){
    uvmfree(pagetable, 0);
    80002ada:	4581                	li	a1,0
    80002adc:	fe843503          	ld	a0,-24(s0)
    80002ae0:	fffff097          	auipc	ra,0xfffff
    80002ae4:	652080e7          	jalr	1618(ra) # 80002132 <uvmfree>
    return 0;
    80002ae8:	4781                	li	a5,0
    80002aea:	a8a9                	j	80002b44 <proc_pagetable+0xb6>
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
              (uint64)(p->trapframe), PTE_R | PTE_W) < 0){
    80002aec:	fd843783          	ld	a5,-40(s0)
    80002af0:	73bc                	ld	a5,96(a5)
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80002af2:	4719                	li	a4,6
    80002af4:	86be                	mv	a3,a5
    80002af6:	6605                	lui	a2,0x1
    80002af8:	020007b7          	lui	a5,0x2000
    80002afc:	17fd                	addi	a5,a5,-1
    80002afe:	00d79593          	slli	a1,a5,0xd
    80002b02:	fe843503          	ld	a0,-24(s0)
    80002b06:	fffff097          	auipc	ra,0xfffff
    80002b0a:	160080e7          	jalr	352(ra) # 80001c66 <mappages>
    80002b0e:	87aa                	mv	a5,a0
    80002b10:	0207d863          	bgez	a5,80002b40 <proc_pagetable+0xb2>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002b14:	4681                	li	a3,0
    80002b16:	4605                	li	a2,1
    80002b18:	040007b7          	lui	a5,0x4000
    80002b1c:	17fd                	addi	a5,a5,-1
    80002b1e:	00c79593          	slli	a1,a5,0xc
    80002b22:	fe843503          	ld	a0,-24(s0)
    80002b26:	fffff097          	auipc	ra,0xfffff
    80002b2a:	21e080e7          	jalr	542(ra) # 80001d44 <uvmunmap>
    uvmfree(pagetable, 0);
    80002b2e:	4581                	li	a1,0
    80002b30:	fe843503          	ld	a0,-24(s0)
    80002b34:	fffff097          	auipc	ra,0xfffff
    80002b38:	5fe080e7          	jalr	1534(ra) # 80002132 <uvmfree>
    return 0;
    80002b3c:	4781                	li	a5,0
    80002b3e:	a019                	j	80002b44 <proc_pagetable+0xb6>
  }

  return pagetable;
    80002b40:	fe843783          	ld	a5,-24(s0)
}
    80002b44:	853e                	mv	a0,a5
    80002b46:	70a2                	ld	ra,40(sp)
    80002b48:	7402                	ld	s0,32(sp)
    80002b4a:	6145                	addi	sp,sp,48
    80002b4c:	8082                	ret

0000000080002b4e <proc_freepagetable>:

// Free a process's page table, and free the
// physical memory it refers to.
void
proc_freepagetable(pagetable_t pagetable, uint64 sz)
{
    80002b4e:	1101                	addi	sp,sp,-32
    80002b50:	ec06                	sd	ra,24(sp)
    80002b52:	e822                	sd	s0,16(sp)
    80002b54:	1000                	addi	s0,sp,32
    80002b56:	fea43423          	sd	a0,-24(s0)
    80002b5a:	feb43023          	sd	a1,-32(s0)
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80002b5e:	4681                	li	a3,0
    80002b60:	4605                	li	a2,1
    80002b62:	040007b7          	lui	a5,0x4000
    80002b66:	17fd                	addi	a5,a5,-1
    80002b68:	00c79593          	slli	a1,a5,0xc
    80002b6c:	fe843503          	ld	a0,-24(s0)
    80002b70:	fffff097          	auipc	ra,0xfffff
    80002b74:	1d4080e7          	jalr	468(ra) # 80001d44 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80002b78:	4681                	li	a3,0
    80002b7a:	4605                	li	a2,1
    80002b7c:	020007b7          	lui	a5,0x2000
    80002b80:	17fd                	addi	a5,a5,-1
    80002b82:	00d79593          	slli	a1,a5,0xd
    80002b86:	fe843503          	ld	a0,-24(s0)
    80002b8a:	fffff097          	auipc	ra,0xfffff
    80002b8e:	1ba080e7          	jalr	442(ra) # 80001d44 <uvmunmap>
  uvmfree(pagetable, sz);
    80002b92:	fe043583          	ld	a1,-32(s0)
    80002b96:	fe843503          	ld	a0,-24(s0)
    80002b9a:	fffff097          	auipc	ra,0xfffff
    80002b9e:	598080e7          	jalr	1432(ra) # 80002132 <uvmfree>
}
    80002ba2:	0001                	nop
    80002ba4:	60e2                	ld	ra,24(sp)
    80002ba6:	6442                	ld	s0,16(sp)
    80002ba8:	6105                	addi	sp,sp,32
    80002baa:	8082                	ret

0000000080002bac <userinit>:
};

// Set up first user process.
void
userinit(void)
{
    80002bac:	1101                	addi	sp,sp,-32
    80002bae:	ec06                	sd	ra,24(sp)
    80002bb0:	e822                	sd	s0,16(sp)
    80002bb2:	1000                	addi	s0,sp,32
  struct proc *p;

  p = allocproc();
    80002bb4:	00000097          	auipc	ra,0x0
    80002bb8:	cfa080e7          	jalr	-774(ra) # 800028ae <allocproc>
    80002bbc:	fea43423          	sd	a0,-24(s0)
  initproc = p;
    80002bc0:	00009797          	auipc	a5,0x9
    80002bc4:	46878793          	addi	a5,a5,1128 # 8000c028 <initproc>
    80002bc8:	fe843703          	ld	a4,-24(s0)
    80002bcc:	e398                	sd	a4,0(a5)
  
  // allocate one user page and copy init's instructions
  // and data into it.
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80002bce:	fe843783          	ld	a5,-24(s0)
    80002bd2:	6fbc                	ld	a5,88(a5)
    80002bd4:	03400613          	li	a2,52
    80002bd8:	00009597          	auipc	a1,0x9
    80002bdc:	b8058593          	addi	a1,a1,-1152 # 8000b758 <initcode>
    80002be0:	853e                	mv	a0,a5
    80002be2:	fffff097          	auipc	ra,0xfffff
    80002be6:	29e080e7          	jalr	670(ra) # 80001e80 <uvminit>
  p->sz = PGSIZE;
    80002bea:	fe843783          	ld	a5,-24(s0)
    80002bee:	6705                	lui	a4,0x1
    80002bf0:	ebb8                	sd	a4,80(a5)

  // prepare for the very first "return" from kernel to user.
  p->trapframe->epc = 0;      // user program counter
    80002bf2:	fe843783          	ld	a5,-24(s0)
    80002bf6:	73bc                	ld	a5,96(a5)
    80002bf8:	0007bc23          	sd	zero,24(a5)
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80002bfc:	fe843783          	ld	a5,-24(s0)
    80002c00:	73bc                	ld	a5,96(a5)
    80002c02:	6705                	lui	a4,0x1
    80002c04:	fb98                	sd	a4,48(a5)

  safestrcpy(p->name, "initcode", sizeof(p->name));
    80002c06:	fe843783          	ld	a5,-24(s0)
    80002c0a:	16078793          	addi	a5,a5,352
    80002c0e:	4641                	li	a2,16
    80002c10:	00008597          	auipc	a1,0x8
    80002c14:	5d858593          	addi	a1,a1,1496 # 8000b1e8 <etext+0x1e8>
    80002c18:	853e                	mv	a0,a5
    80002c1a:	fffff097          	auipc	ra,0xfffff
    80002c1e:	b2c080e7          	jalr	-1236(ra) # 80001746 <safestrcpy>
  p->cwd = namei("/");
    80002c22:	00008517          	auipc	a0,0x8
    80002c26:	5d650513          	addi	a0,a0,1494 # 8000b1f8 <etext+0x1f8>
    80002c2a:	00003097          	auipc	ra,0x3
    80002c2e:	4ee080e7          	jalr	1262(ra) # 80006118 <namei>
    80002c32:	872a                	mv	a4,a0
    80002c34:	fe843783          	ld	a5,-24(s0)
    80002c38:	14e7bc23          	sd	a4,344(a5)

  p->state = RUNNABLE;
    80002c3c:	fe843783          	ld	a5,-24(s0)
    80002c40:	470d                	li	a4,3
    80002c42:	cf98                	sw	a4,24(a5)

  release(&p->lock);
    80002c44:	fe843783          	ld	a5,-24(s0)
    80002c48:	853e                	mv	a0,a5
    80002c4a:	ffffe097          	auipc	ra,0xffffe
    80002c4e:	688080e7          	jalr	1672(ra) # 800012d2 <release>
}
    80002c52:	0001                	nop
    80002c54:	60e2                	ld	ra,24(sp)
    80002c56:	6442                	ld	s0,16(sp)
    80002c58:	6105                	addi	sp,sp,32
    80002c5a:	8082                	ret

0000000080002c5c <growproc>:

// Grow or shrink user memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
    80002c5c:	7179                	addi	sp,sp,-48
    80002c5e:	f406                	sd	ra,40(sp)
    80002c60:	f022                	sd	s0,32(sp)
    80002c62:	1800                	addi	s0,sp,48
    80002c64:	87aa                	mv	a5,a0
    80002c66:	fcf42e23          	sw	a5,-36(s0)
  uint sz;
  struct proc *p = myproc();
    80002c6a:	00000097          	auipc	ra,0x0
    80002c6e:	baa080e7          	jalr	-1110(ra) # 80002814 <myproc>
    80002c72:	fea43023          	sd	a0,-32(s0)

  sz = p->sz;
    80002c76:	fe043783          	ld	a5,-32(s0)
    80002c7a:	6bbc                	ld	a5,80(a5)
    80002c7c:	fef42623          	sw	a5,-20(s0)
  if(n > 0){
    80002c80:	fdc42783          	lw	a5,-36(s0)
    80002c84:	2781                	sext.w	a5,a5
    80002c86:	02f05e63          	blez	a5,80002cc2 <growproc+0x66>
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80002c8a:	fe043783          	ld	a5,-32(s0)
    80002c8e:	6fb4                	ld	a3,88(a5)
    80002c90:	fec46583          	lwu	a1,-20(s0)
    80002c94:	fdc42783          	lw	a5,-36(s0)
    80002c98:	fec42703          	lw	a4,-20(s0)
    80002c9c:	9fb9                	addw	a5,a5,a4
    80002c9e:	2781                	sext.w	a5,a5
    80002ca0:	1782                	slli	a5,a5,0x20
    80002ca2:	9381                	srli	a5,a5,0x20
    80002ca4:	863e                	mv	a2,a5
    80002ca6:	8536                	mv	a0,a3
    80002ca8:	fffff097          	auipc	ra,0xfffff
    80002cac:	260080e7          	jalr	608(ra) # 80001f08 <uvmalloc>
    80002cb0:	87aa                	mv	a5,a0
    80002cb2:	fef42623          	sw	a5,-20(s0)
    80002cb6:	fec42783          	lw	a5,-20(s0)
    80002cba:	2781                	sext.w	a5,a5
    80002cbc:	ef95                	bnez	a5,80002cf8 <growproc+0x9c>
      return -1;
    80002cbe:	57fd                	li	a5,-1
    80002cc0:	a091                	j	80002d04 <growproc+0xa8>
    }
  } else if(n < 0){
    80002cc2:	fdc42783          	lw	a5,-36(s0)
    80002cc6:	2781                	sext.w	a5,a5
    80002cc8:	0207d863          	bgez	a5,80002cf8 <growproc+0x9c>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80002ccc:	fe043783          	ld	a5,-32(s0)
    80002cd0:	6fb4                	ld	a3,88(a5)
    80002cd2:	fec46583          	lwu	a1,-20(s0)
    80002cd6:	fdc42783          	lw	a5,-36(s0)
    80002cda:	fec42703          	lw	a4,-20(s0)
    80002cde:	9fb9                	addw	a5,a5,a4
    80002ce0:	2781                	sext.w	a5,a5
    80002ce2:	1782                	slli	a5,a5,0x20
    80002ce4:	9381                	srli	a5,a5,0x20
    80002ce6:	863e                	mv	a2,a5
    80002ce8:	8536                	mv	a0,a3
    80002cea:	fffff097          	auipc	ra,0xfffff
    80002cee:	302080e7          	jalr	770(ra) # 80001fec <uvmdealloc>
    80002cf2:	87aa                	mv	a5,a0
    80002cf4:	fef42623          	sw	a5,-20(s0)
  }
  p->sz = sz;
    80002cf8:	fec46703          	lwu	a4,-20(s0)
    80002cfc:	fe043783          	ld	a5,-32(s0)
    80002d00:	ebb8                	sd	a4,80(a5)
  return 0;
    80002d02:	4781                	li	a5,0
}
    80002d04:	853e                	mv	a0,a5
    80002d06:	70a2                	ld	ra,40(sp)
    80002d08:	7402                	ld	s0,32(sp)
    80002d0a:	6145                	addi	sp,sp,48
    80002d0c:	8082                	ret

0000000080002d0e <fork>:

// Create a new process, copying the parent.
// Sets up child kernel stack to return as if from fork() system call.
int
fork(void)
{
    80002d0e:	7179                	addi	sp,sp,-48
    80002d10:	f406                	sd	ra,40(sp)
    80002d12:	f022                	sd	s0,32(sp)
    80002d14:	1800                	addi	s0,sp,48
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
    80002d16:	00000097          	auipc	ra,0x0
    80002d1a:	afe080e7          	jalr	-1282(ra) # 80002814 <myproc>
    80002d1e:	fea43023          	sd	a0,-32(s0)

  // Allocate process.
  if((np = allocproc()) == 0){
    80002d22:	00000097          	auipc	ra,0x0
    80002d26:	b8c080e7          	jalr	-1140(ra) # 800028ae <allocproc>
    80002d2a:	fca43c23          	sd	a0,-40(s0)
    80002d2e:	fd843783          	ld	a5,-40(s0)
    80002d32:	e399                	bnez	a5,80002d38 <fork+0x2a>
    return -1;
    80002d34:	57fd                	li	a5,-1
    80002d36:	aab5                	j	80002eb2 <fork+0x1a4>
  }

  // Copy user memory from parent to child.
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80002d38:	fe043783          	ld	a5,-32(s0)
    80002d3c:	6fb8                	ld	a4,88(a5)
    80002d3e:	fd843783          	ld	a5,-40(s0)
    80002d42:	6fb4                	ld	a3,88(a5)
    80002d44:	fe043783          	ld	a5,-32(s0)
    80002d48:	6bbc                	ld	a5,80(a5)
    80002d4a:	863e                	mv	a2,a5
    80002d4c:	85b6                	mv	a1,a3
    80002d4e:	853a                	mv	a0,a4
    80002d50:	fffff097          	auipc	ra,0xfffff
    80002d54:	42c080e7          	jalr	1068(ra) # 8000217c <uvmcopy>
    80002d58:	87aa                	mv	a5,a0
    80002d5a:	0207d163          	bgez	a5,80002d7c <fork+0x6e>
    freeproc(np);
    80002d5e:	fd843503          	ld	a0,-40(s0)
    80002d62:	00000097          	auipc	ra,0x0
    80002d66:	c8e080e7          	jalr	-882(ra) # 800029f0 <freeproc>
    release(&np->lock);
    80002d6a:	fd843783          	ld	a5,-40(s0)
    80002d6e:	853e                	mv	a0,a5
    80002d70:	ffffe097          	auipc	ra,0xffffe
    80002d74:	562080e7          	jalr	1378(ra) # 800012d2 <release>
    return -1;
    80002d78:	57fd                	li	a5,-1
    80002d7a:	aa25                	j	80002eb2 <fork+0x1a4>
  }
  np->sz = p->sz;
    80002d7c:	fe043783          	ld	a5,-32(s0)
    80002d80:	6bb8                	ld	a4,80(a5)
    80002d82:	fd843783          	ld	a5,-40(s0)
    80002d86:	ebb8                	sd	a4,80(a5)

  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);
    80002d88:	fe043783          	ld	a5,-32(s0)
    80002d8c:	73b8                	ld	a4,96(a5)
    80002d8e:	fd843783          	ld	a5,-40(s0)
    80002d92:	73bc                	ld	a5,96(a5)
    80002d94:	86be                	mv	a3,a5
    80002d96:	12000793          	li	a5,288
    80002d9a:	863e                	mv	a2,a5
    80002d9c:	85ba                	mv	a1,a4
    80002d9e:	8536                	mv	a0,a3
    80002da0:	fffff097          	auipc	ra,0xfffff
    80002da4:	862080e7          	jalr	-1950(ra) # 80001602 <memcpy>

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;
    80002da8:	fd843783          	ld	a5,-40(s0)
    80002dac:	73bc                	ld	a5,96(a5)
    80002dae:	0607b823          	sd	zero,112(a5)

  // increment reference counts on open file descriptors.
  for(i = 0; i < NOFILE; i++)
    80002db2:	fe042623          	sw	zero,-20(s0)
    80002db6:	a0a9                	j	80002e00 <fork+0xf2>
    if(p->ofile[i])
    80002db8:	fe043703          	ld	a4,-32(s0)
    80002dbc:	fec42783          	lw	a5,-20(s0)
    80002dc0:	07e9                	addi	a5,a5,26
    80002dc2:	078e                	slli	a5,a5,0x3
    80002dc4:	97ba                	add	a5,a5,a4
    80002dc6:	679c                	ld	a5,8(a5)
    80002dc8:	c79d                	beqz	a5,80002df6 <fork+0xe8>
      np->ofile[i] = filedup(p->ofile[i]);
    80002dca:	fe043703          	ld	a4,-32(s0)
    80002dce:	fec42783          	lw	a5,-20(s0)
    80002dd2:	07e9                	addi	a5,a5,26
    80002dd4:	078e                	slli	a5,a5,0x3
    80002dd6:	97ba                	add	a5,a5,a4
    80002dd8:	679c                	ld	a5,8(a5)
    80002dda:	853e                	mv	a0,a5
    80002ddc:	00004097          	auipc	ra,0x4
    80002de0:	cd4080e7          	jalr	-812(ra) # 80006ab0 <filedup>
    80002de4:	86aa                	mv	a3,a0
    80002de6:	fd843703          	ld	a4,-40(s0)
    80002dea:	fec42783          	lw	a5,-20(s0)
    80002dee:	07e9                	addi	a5,a5,26
    80002df0:	078e                	slli	a5,a5,0x3
    80002df2:	97ba                	add	a5,a5,a4
    80002df4:	e794                	sd	a3,8(a5)
  for(i = 0; i < NOFILE; i++)
    80002df6:	fec42783          	lw	a5,-20(s0)
    80002dfa:	2785                	addiw	a5,a5,1
    80002dfc:	fef42623          	sw	a5,-20(s0)
    80002e00:	fec42783          	lw	a5,-20(s0)
    80002e04:	0007871b          	sext.w	a4,a5
    80002e08:	47bd                	li	a5,15
    80002e0a:	fae7d7e3          	bge	a5,a4,80002db8 <fork+0xaa>
  np->cwd = idup(p->cwd);
    80002e0e:	fe043783          	ld	a5,-32(s0)
    80002e12:	1587b783          	ld	a5,344(a5)
    80002e16:	853e                	mv	a0,a5
    80002e18:	00002097          	auipc	ra,0x2
    80002e1c:	5be080e7          	jalr	1470(ra) # 800053d6 <idup>
    80002e20:	872a                	mv	a4,a0
    80002e22:	fd843783          	ld	a5,-40(s0)
    80002e26:	14e7bc23          	sd	a4,344(a5)

  safestrcpy(np->name, p->name, sizeof(p->name));
    80002e2a:	fd843783          	ld	a5,-40(s0)
    80002e2e:	16078713          	addi	a4,a5,352
    80002e32:	fe043783          	ld	a5,-32(s0)
    80002e36:	16078793          	addi	a5,a5,352
    80002e3a:	4641                	li	a2,16
    80002e3c:	85be                	mv	a1,a5
    80002e3e:	853a                	mv	a0,a4
    80002e40:	fffff097          	auipc	ra,0xfffff
    80002e44:	906080e7          	jalr	-1786(ra) # 80001746 <safestrcpy>

  pid = np->pid;
    80002e48:	fd843783          	ld	a5,-40(s0)
    80002e4c:	5b9c                	lw	a5,48(a5)
    80002e4e:	fcf42a23          	sw	a5,-44(s0)

  release(&np->lock);
    80002e52:	fd843783          	ld	a5,-40(s0)
    80002e56:	853e                	mv	a0,a5
    80002e58:	ffffe097          	auipc	ra,0xffffe
    80002e5c:	47a080e7          	jalr	1146(ra) # 800012d2 <release>

  acquire(&wait_lock);
    80002e60:	00017517          	auipc	a0,0x17
    80002e64:	47850513          	addi	a0,a0,1144 # 8001a2d8 <wait_lock>
    80002e68:	ffffe097          	auipc	ra,0xffffe
    80002e6c:	406080e7          	jalr	1030(ra) # 8000126e <acquire>
  np->parent = p;
    80002e70:	fd843783          	ld	a5,-40(s0)
    80002e74:	fe043703          	ld	a4,-32(s0)
    80002e78:	e3b8                	sd	a4,64(a5)
  release(&wait_lock);
    80002e7a:	00017517          	auipc	a0,0x17
    80002e7e:	45e50513          	addi	a0,a0,1118 # 8001a2d8 <wait_lock>
    80002e82:	ffffe097          	auipc	ra,0xffffe
    80002e86:	450080e7          	jalr	1104(ra) # 800012d2 <release>

  acquire(&np->lock);
    80002e8a:	fd843783          	ld	a5,-40(s0)
    80002e8e:	853e                	mv	a0,a5
    80002e90:	ffffe097          	auipc	ra,0xffffe
    80002e94:	3de080e7          	jalr	990(ra) # 8000126e <acquire>
  np->state = RUNNABLE;
    80002e98:	fd843783          	ld	a5,-40(s0)
    80002e9c:	470d                	li	a4,3
    80002e9e:	cf98                	sw	a4,24(a5)
  release(&np->lock);
    80002ea0:	fd843783          	ld	a5,-40(s0)
    80002ea4:	853e                	mv	a0,a5
    80002ea6:	ffffe097          	auipc	ra,0xffffe
    80002eaa:	42c080e7          	jalr	1068(ra) # 800012d2 <release>

  return pid;
    80002eae:	fd442783          	lw	a5,-44(s0)
}
    80002eb2:	853e                	mv	a0,a5
    80002eb4:	70a2                	ld	ra,40(sp)
    80002eb6:	7402                	ld	s0,32(sp)
    80002eb8:	6145                	addi	sp,sp,48
    80002eba:	8082                	ret

0000000080002ebc <reparent>:

// Pass p's abandoned children to init.
// Caller must hold wait_lock.
void
reparent(struct proc *p)
{
    80002ebc:	7179                	addi	sp,sp,-48
    80002ebe:	f406                	sd	ra,40(sp)
    80002ec0:	f022                	sd	s0,32(sp)
    80002ec2:	1800                	addi	s0,sp,48
    80002ec4:	fca43c23          	sd	a0,-40(s0)
  struct proc *pp;

  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002ec8:	00011797          	auipc	a5,0x11
    80002ecc:	7f878793          	addi	a5,a5,2040 # 800146c0 <proc>
    80002ed0:	fef43423          	sd	a5,-24(s0)
    80002ed4:	a081                	j	80002f14 <reparent+0x58>
    if(pp->parent == p){
    80002ed6:	fe843783          	ld	a5,-24(s0)
    80002eda:	63bc                	ld	a5,64(a5)
    80002edc:	fd843703          	ld	a4,-40(s0)
    80002ee0:	02f71463          	bne	a4,a5,80002f08 <reparent+0x4c>
      pp->parent = initproc;
    80002ee4:	00009797          	auipc	a5,0x9
    80002ee8:	14478793          	addi	a5,a5,324 # 8000c028 <initproc>
    80002eec:	6398                	ld	a4,0(a5)
    80002eee:	fe843783          	ld	a5,-24(s0)
    80002ef2:	e3b8                	sd	a4,64(a5)
      wakeup(initproc);
    80002ef4:	00009797          	auipc	a5,0x9
    80002ef8:	13478793          	addi	a5,a5,308 # 8000c028 <initproc>
    80002efc:	639c                	ld	a5,0(a5)
    80002efe:	853e                	mv	a0,a5
    80002f00:	00000097          	auipc	ra,0x0
    80002f04:	6a4080e7          	jalr	1700(ra) # 800035a4 <wakeup>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80002f08:	fe843783          	ld	a5,-24(s0)
    80002f0c:	17078793          	addi	a5,a5,368
    80002f10:	fef43423          	sd	a5,-24(s0)
    80002f14:	fe843703          	ld	a4,-24(s0)
    80002f18:	00017797          	auipc	a5,0x17
    80002f1c:	3a878793          	addi	a5,a5,936 # 8001a2c0 <pid_lock>
    80002f20:	faf76be3          	bltu	a4,a5,80002ed6 <reparent+0x1a>
    }
  }
}
    80002f24:	0001                	nop
    80002f26:	0001                	nop
    80002f28:	70a2                	ld	ra,40(sp)
    80002f2a:	7402                	ld	s0,32(sp)
    80002f2c:	6145                	addi	sp,sp,48
    80002f2e:	8082                	ret

0000000080002f30 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait().
void
exit(int status)
{
    80002f30:	7139                	addi	sp,sp,-64
    80002f32:	fc06                	sd	ra,56(sp)
    80002f34:	f822                	sd	s0,48(sp)
    80002f36:	0080                	addi	s0,sp,64
    80002f38:	87aa                	mv	a5,a0
    80002f3a:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    80002f3e:	00000097          	auipc	ra,0x0
    80002f42:	8d6080e7          	jalr	-1834(ra) # 80002814 <myproc>
    80002f46:	fea43023          	sd	a0,-32(s0)

  if(p == initproc)
    80002f4a:	00009797          	auipc	a5,0x9
    80002f4e:	0de78793          	addi	a5,a5,222 # 8000c028 <initproc>
    80002f52:	639c                	ld	a5,0(a5)
    80002f54:	fe043703          	ld	a4,-32(s0)
    80002f58:	00f71a63          	bne	a4,a5,80002f6c <exit+0x3c>
    panic("init exiting");
    80002f5c:	00008517          	auipc	a0,0x8
    80002f60:	2a450513          	addi	a0,a0,676 # 8000b200 <etext+0x200>
    80002f64:	ffffe097          	auipc	ra,0xffffe
    80002f68:	d1a080e7          	jalr	-742(ra) # 80000c7e <panic>

  // Close all open files.
  for(int fd = 0; fd < NOFILE; fd++){
    80002f6c:	fe042623          	sw	zero,-20(s0)
    80002f70:	a881                	j	80002fc0 <exit+0x90>
    if(p->ofile[fd]){
    80002f72:	fe043703          	ld	a4,-32(s0)
    80002f76:	fec42783          	lw	a5,-20(s0)
    80002f7a:	07e9                	addi	a5,a5,26
    80002f7c:	078e                	slli	a5,a5,0x3
    80002f7e:	97ba                	add	a5,a5,a4
    80002f80:	679c                	ld	a5,8(a5)
    80002f82:	cb95                	beqz	a5,80002fb6 <exit+0x86>
      struct file *f = p->ofile[fd];
    80002f84:	fe043703          	ld	a4,-32(s0)
    80002f88:	fec42783          	lw	a5,-20(s0)
    80002f8c:	07e9                	addi	a5,a5,26
    80002f8e:	078e                	slli	a5,a5,0x3
    80002f90:	97ba                	add	a5,a5,a4
    80002f92:	679c                	ld	a5,8(a5)
    80002f94:	fcf43c23          	sd	a5,-40(s0)
      fileclose(f);
    80002f98:	fd843503          	ld	a0,-40(s0)
    80002f9c:	00004097          	auipc	ra,0x4
    80002fa0:	b7a080e7          	jalr	-1158(ra) # 80006b16 <fileclose>
      p->ofile[fd] = 0;
    80002fa4:	fe043703          	ld	a4,-32(s0)
    80002fa8:	fec42783          	lw	a5,-20(s0)
    80002fac:	07e9                	addi	a5,a5,26
    80002fae:	078e                	slli	a5,a5,0x3
    80002fb0:	97ba                	add	a5,a5,a4
    80002fb2:	0007b423          	sd	zero,8(a5)
  for(int fd = 0; fd < NOFILE; fd++){
    80002fb6:	fec42783          	lw	a5,-20(s0)
    80002fba:	2785                	addiw	a5,a5,1
    80002fbc:	fef42623          	sw	a5,-20(s0)
    80002fc0:	fec42783          	lw	a5,-20(s0)
    80002fc4:	0007871b          	sext.w	a4,a5
    80002fc8:	47bd                	li	a5,15
    80002fca:	fae7d4e3          	bge	a5,a4,80002f72 <exit+0x42>
    }
  }

  begin_op();
    80002fce:	00003097          	auipc	ra,0x3
    80002fd2:	4ae080e7          	jalr	1198(ra) # 8000647c <begin_op>
  iput(p->cwd);
    80002fd6:	fe043783          	ld	a5,-32(s0)
    80002fda:	1587b783          	ld	a5,344(a5)
    80002fde:	853e                	mv	a0,a5
    80002fe0:	00002097          	auipc	ra,0x2
    80002fe4:	5d0080e7          	jalr	1488(ra) # 800055b0 <iput>
  end_op();
    80002fe8:	00003097          	auipc	ra,0x3
    80002fec:	556080e7          	jalr	1366(ra) # 8000653e <end_op>
  p->cwd = 0;
    80002ff0:	fe043783          	ld	a5,-32(s0)
    80002ff4:	1407bc23          	sd	zero,344(a5)

  acquire(&wait_lock);
    80002ff8:	00017517          	auipc	a0,0x17
    80002ffc:	2e050513          	addi	a0,a0,736 # 8001a2d8 <wait_lock>
    80003000:	ffffe097          	auipc	ra,0xffffe
    80003004:	26e080e7          	jalr	622(ra) # 8000126e <acquire>

  // Give any children to init.
  reparent(p);
    80003008:	fe043503          	ld	a0,-32(s0)
    8000300c:	00000097          	auipc	ra,0x0
    80003010:	eb0080e7          	jalr	-336(ra) # 80002ebc <reparent>

  // Parent might be sleeping in wait().
  wakeup(p->parent);
    80003014:	fe043783          	ld	a5,-32(s0)
    80003018:	63bc                	ld	a5,64(a5)
    8000301a:	853e                	mv	a0,a5
    8000301c:	00000097          	auipc	ra,0x0
    80003020:	588080e7          	jalr	1416(ra) # 800035a4 <wakeup>
  
  acquire(&p->lock);
    80003024:	fe043783          	ld	a5,-32(s0)
    80003028:	853e                	mv	a0,a5
    8000302a:	ffffe097          	auipc	ra,0xffffe
    8000302e:	244080e7          	jalr	580(ra) # 8000126e <acquire>

  p->xstate = status;
    80003032:	fe043783          	ld	a5,-32(s0)
    80003036:	fcc42703          	lw	a4,-52(s0)
    8000303a:	d7d8                	sw	a4,44(a5)
  p->state = ZOMBIE;
    8000303c:	fe043783          	ld	a5,-32(s0)
    80003040:	4715                	li	a4,5
    80003042:	cf98                	sw	a4,24(a5)

  if (p->priority == HIGH_PRIORITY){
    80003044:	fe043783          	ld	a5,-32(s0)
    80003048:	5bdc                	lw	a5,52(a5)
    8000304a:	873e                	mv	a4,a5
    8000304c:	4789                	li	a5,2
    8000304e:	04f71c63          	bne	a4,a5,800030a6 <exit+0x176>
    acquire(&priority_lock);
    80003052:	00011517          	auipc	a0,0x11
    80003056:	25650513          	addi	a0,a0,598 # 800142a8 <priority_lock>
    8000305a:	ffffe097          	auipc	ra,0xffffe
    8000305e:	214080e7          	jalr	532(ra) # 8000126e <acquire>
    high_priority_procs--;
    80003062:	00009797          	auipc	a5,0x9
    80003066:	fc278793          	addi	a5,a5,-62 # 8000c024 <high_priority_procs>
    8000306a:	439c                	lw	a5,0(a5)
    8000306c:	37fd                	addiw	a5,a5,-1
    8000306e:	0007871b          	sext.w	a4,a5
    80003072:	00009797          	auipc	a5,0x9
    80003076:	fb278793          	addi	a5,a5,-78 # 8000c024 <high_priority_procs>
    8000307a:	c398                	sw	a4,0(a5)
    release(&priority_lock);
    8000307c:	00011517          	auipc	a0,0x11
    80003080:	22c50513          	addi	a0,a0,556 # 800142a8 <priority_lock>
    80003084:	ffffe097          	auipc	ra,0xffffe
    80003088:	24e080e7          	jalr	590(ra) # 800012d2 <release>

    if (high_priority_procs == 0){
    8000308c:	00009797          	auipc	a5,0x9
    80003090:	f9878793          	addi	a5,a5,-104 # 8000c024 <high_priority_procs>
    80003094:	439c                	lw	a5,0(a5)
    80003096:	eb81                	bnez	a5,800030a6 <exit+0x176>
      proc_break = true;
    80003098:	00009797          	auipc	a5,0x9
    8000309c:	f8878793          	addi	a5,a5,-120 # 8000c020 <proc_break>
    800030a0:	4705                	li	a4,1
    800030a2:	00e78023          	sb	a4,0(a5)
    }

    
  }

  release(&wait_lock);
    800030a6:	00017517          	auipc	a0,0x17
    800030aa:	23250513          	addi	a0,a0,562 # 8001a2d8 <wait_lock>
    800030ae:	ffffe097          	auipc	ra,0xffffe
    800030b2:	224080e7          	jalr	548(ra) # 800012d2 <release>

  // Jump into the scheduler, never to return.
  sched();
    800030b6:	00000097          	auipc	ra,0x0
    800030ba:	2ae080e7          	jalr	686(ra) # 80003364 <sched>
  panic("zombie exit");
    800030be:	00008517          	auipc	a0,0x8
    800030c2:	15250513          	addi	a0,a0,338 # 8000b210 <etext+0x210>
    800030c6:	ffffe097          	auipc	ra,0xffffe
    800030ca:	bb8080e7          	jalr	-1096(ra) # 80000c7e <panic>

00000000800030ce <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(uint64 addr)
{
    800030ce:	7139                	addi	sp,sp,-64
    800030d0:	fc06                	sd	ra,56(sp)
    800030d2:	f822                	sd	s0,48(sp)
    800030d4:	0080                	addi	s0,sp,64
    800030d6:	fca43423          	sd	a0,-56(s0)
  struct proc *np;
  int havekids, pid;
  struct proc *p = myproc();
    800030da:	fffff097          	auipc	ra,0xfffff
    800030de:	73a080e7          	jalr	1850(ra) # 80002814 <myproc>
    800030e2:	fca43c23          	sd	a0,-40(s0)

  acquire(&wait_lock);
    800030e6:	00017517          	auipc	a0,0x17
    800030ea:	1f250513          	addi	a0,a0,498 # 8001a2d8 <wait_lock>
    800030ee:	ffffe097          	auipc	ra,0xffffe
    800030f2:	180080e7          	jalr	384(ra) # 8000126e <acquire>

  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    800030f6:	fe042223          	sw	zero,-28(s0)
    for(np = proc; np < &proc[NPROC]; np++){
    800030fa:	00011797          	auipc	a5,0x11
    800030fe:	5c678793          	addi	a5,a5,1478 # 800146c0 <proc>
    80003102:	fef43423          	sd	a5,-24(s0)
    80003106:	a8d1                	j	800031da <wait+0x10c>
      if(np->parent == p){
    80003108:	fe843783          	ld	a5,-24(s0)
    8000310c:	63bc                	ld	a5,64(a5)
    8000310e:	fd843703          	ld	a4,-40(s0)
    80003112:	0af71e63          	bne	a4,a5,800031ce <wait+0x100>
        // make sure the child isn't still in exit() or swtch().
        acquire(&np->lock);
    80003116:	fe843783          	ld	a5,-24(s0)
    8000311a:	853e                	mv	a0,a5
    8000311c:	ffffe097          	auipc	ra,0xffffe
    80003120:	152080e7          	jalr	338(ra) # 8000126e <acquire>

        havekids = 1;
    80003124:	4785                	li	a5,1
    80003126:	fef42223          	sw	a5,-28(s0)
        if(np->state == ZOMBIE){ //pone el padre en zombie y espera a que el hijo termine. TODO 
    8000312a:	fe843783          	ld	a5,-24(s0)
    8000312e:	4f9c                	lw	a5,24(a5)
    80003130:	873e                	mv	a4,a5
    80003132:	4795                	li	a5,5
    80003134:	08f71663          	bne	a4,a5,800031c0 <wait+0xf2>

          
          // Found one.
          pid = np->pid;
    80003138:	fe843783          	ld	a5,-24(s0)
    8000313c:	5b9c                	lw	a5,48(a5)
    8000313e:	fcf42a23          	sw	a5,-44(s0)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80003142:	fc843783          	ld	a5,-56(s0)
    80003146:	c7a9                	beqz	a5,80003190 <wait+0xc2>
    80003148:	fd843783          	ld	a5,-40(s0)
    8000314c:	6fb8                	ld	a4,88(a5)
    8000314e:	fe843783          	ld	a5,-24(s0)
    80003152:	02c78793          	addi	a5,a5,44
    80003156:	4691                	li	a3,4
    80003158:	863e                	mv	a2,a5
    8000315a:	fc843583          	ld	a1,-56(s0)
    8000315e:	853a                	mv	a0,a4
    80003160:	fffff097          	auipc	ra,0xfffff
    80003164:	186080e7          	jalr	390(ra) # 800022e6 <copyout>
    80003168:	87aa                	mv	a5,a0
    8000316a:	0207d363          	bgez	a5,80003190 <wait+0xc2>
                                  sizeof(np->xstate)) < 0) {
            release(&np->lock);
    8000316e:	fe843783          	ld	a5,-24(s0)
    80003172:	853e                	mv	a0,a5
    80003174:	ffffe097          	auipc	ra,0xffffe
    80003178:	15e080e7          	jalr	350(ra) # 800012d2 <release>
            release(&wait_lock);
    8000317c:	00017517          	auipc	a0,0x17
    80003180:	15c50513          	addi	a0,a0,348 # 8001a2d8 <wait_lock>
    80003184:	ffffe097          	auipc	ra,0xffffe
    80003188:	14e080e7          	jalr	334(ra) # 800012d2 <release>
            return -1;
    8000318c:	57fd                	li	a5,-1
    8000318e:	a859                	j	80003224 <wait+0x156>
          }
          freeproc(np);
    80003190:	fe843503          	ld	a0,-24(s0)
    80003194:	00000097          	auipc	ra,0x0
    80003198:	85c080e7          	jalr	-1956(ra) # 800029f0 <freeproc>
          release(&np->lock);
    8000319c:	fe843783          	ld	a5,-24(s0)
    800031a0:	853e                	mv	a0,a5
    800031a2:	ffffe097          	auipc	ra,0xffffe
    800031a6:	130080e7          	jalr	304(ra) # 800012d2 <release>
          release(&wait_lock);
    800031aa:	00017517          	auipc	a0,0x17
    800031ae:	12e50513          	addi	a0,a0,302 # 8001a2d8 <wait_lock>
    800031b2:	ffffe097          	auipc	ra,0xffffe
    800031b6:	120080e7          	jalr	288(ra) # 800012d2 <release>
          return pid;
    800031ba:	fd442783          	lw	a5,-44(s0)
    800031be:	a09d                	j	80003224 <wait+0x156>
        }
        release(&np->lock);
    800031c0:	fe843783          	ld	a5,-24(s0)
    800031c4:	853e                	mv	a0,a5
    800031c6:	ffffe097          	auipc	ra,0xffffe
    800031ca:	10c080e7          	jalr	268(ra) # 800012d2 <release>
    for(np = proc; np < &proc[NPROC]; np++){
    800031ce:	fe843783          	ld	a5,-24(s0)
    800031d2:	17078793          	addi	a5,a5,368
    800031d6:	fef43423          	sd	a5,-24(s0)
    800031da:	fe843703          	ld	a4,-24(s0)
    800031de:	00017797          	auipc	a5,0x17
    800031e2:	0e278793          	addi	a5,a5,226 # 8001a2c0 <pid_lock>
    800031e6:	f2f761e3          	bltu	a4,a5,80003108 <wait+0x3a>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || p->killed){
    800031ea:	fe442783          	lw	a5,-28(s0)
    800031ee:	2781                	sext.w	a5,a5
    800031f0:	c789                	beqz	a5,800031fa <wait+0x12c>
    800031f2:	fd843783          	ld	a5,-40(s0)
    800031f6:	579c                	lw	a5,40(a5)
    800031f8:	cb99                	beqz	a5,8000320e <wait+0x140>
      release(&wait_lock);
    800031fa:	00017517          	auipc	a0,0x17
    800031fe:	0de50513          	addi	a0,a0,222 # 8001a2d8 <wait_lock>
    80003202:	ffffe097          	auipc	ra,0xffffe
    80003206:	0d0080e7          	jalr	208(ra) # 800012d2 <release>
      return -1;
    8000320a:	57fd                	li	a5,-1
    8000320c:	a821                	j	80003224 <wait+0x156>
    }
    
    // Wait for a child to exit.
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000320e:	00017597          	auipc	a1,0x17
    80003212:	0ca58593          	addi	a1,a1,202 # 8001a2d8 <wait_lock>
    80003216:	fd843503          	ld	a0,-40(s0)
    8000321a:	00000097          	auipc	ra,0x0
    8000321e:	2c6080e7          	jalr	710(ra) # 800034e0 <sleep>
    havekids = 0;
    80003222:	bdd1                	j	800030f6 <wait+0x28>
  }
}
    80003224:	853e                	mv	a0,a5
    80003226:	70e2                	ld	ra,56(sp)
    80003228:	7442                	ld	s0,48(sp)
    8000322a:	6121                	addi	sp,sp,64
    8000322c:	8082                	ret

000000008000322e <scheduler>:
//  - swtch to start running that process.
//  - eventually that process transfers control
//    via swtch back to the scheduler.
void
scheduler(void)
{
    8000322e:	1101                	addi	sp,sp,-32
    80003230:	ec06                	sd	ra,24(sp)
    80003232:	e822                	sd	s0,16(sp)
    80003234:	1000                	addi	s0,sp,32
  struct proc *p;
  struct cpu *c = mycpu();
    80003236:	fffff097          	auipc	ra,0xfffff
    8000323a:	5a4080e7          	jalr	1444(ra) # 800027da <mycpu>
    8000323e:	fea43023          	sd	a0,-32(s0)
  
  c->proc = 0;
    80003242:	fe043783          	ld	a5,-32(s0)
    80003246:	0007b023          	sd	zero,0(a5)
  for(;;){
    // Avoid deadlock by ensuring that devices can interrupt.
    intr_on();
    8000324a:	fffff097          	auipc	ra,0xfffff
    8000324e:	37a080e7          	jalr	890(ra) # 800025c4 <intr_on>

    for(p = proc; p < &proc[NPROC]; p++) {
    80003252:	00011797          	auipc	a5,0x11
    80003256:	46e78793          	addi	a5,a5,1134 # 800146c0 <proc>
    8000325a:	fef43423          	sd	a5,-24(s0)
    8000325e:	a8d5                	j	80003352 <scheduler+0x124>
      acquire(&p->lock);
    80003260:	fe843783          	ld	a5,-24(s0)
    80003264:	853e                	mv	a0,a5
    80003266:	ffffe097          	auipc	ra,0xffffe
    8000326a:	008080e7          	jalr	8(ra) # 8000126e <acquire>
      if((p->state == RUNNABLE ) && 
    8000326e:	fe843783          	ld	a5,-24(s0)
    80003272:	4f9c                	lw	a5,24(a5)
    80003274:	873e                	mv	a4,a5
    80003276:	478d                	li	a5,3
    80003278:	08f71b63          	bne	a4,a5,8000330e <scheduler+0xe0>
      ((p->priority == LOW_PRIORITY && high_priority_procs == 0) || (p->priority == HIGH_PRIORITY))) { 
    8000327c:	fe843783          	ld	a5,-24(s0)
    80003280:	5bdc                	lw	a5,52(a5)
      if((p->state == RUNNABLE ) && 
    80003282:	873e                	mv	a4,a5
    80003284:	4785                	li	a5,1
    80003286:	00f71863          	bne	a4,a5,80003296 <scheduler+0x68>
      ((p->priority == LOW_PRIORITY && high_priority_procs == 0) || (p->priority == HIGH_PRIORITY))) { 
    8000328a:	00009797          	auipc	a5,0x9
    8000328e:	d9a78793          	addi	a5,a5,-614 # 8000c024 <high_priority_procs>
    80003292:	439c                	lw	a5,0(a5)
    80003294:	cb81                	beqz	a5,800032a4 <scheduler+0x76>
    80003296:	fe843783          	ld	a5,-24(s0)
    8000329a:	5bdc                	lw	a5,52(a5)
    8000329c:	873e                	mv	a4,a5
    8000329e:	4789                	li	a5,2
    800032a0:	06f71763          	bne	a4,a5,8000330e <scheduler+0xe0>

        //modificamos ticks de reloj
        if (p->priority == HIGH_PRIORITY){
    800032a4:	fe843783          	ld	a5,-24(s0)
    800032a8:	5bdc                	lw	a5,52(a5)
    800032aa:	873e                	mv	a4,a5
    800032ac:	4789                	li	a5,2
    800032ae:	00f71c63          	bne	a4,a5,800032c6 <scheduler+0x98>
          p->hticks++;
    800032b2:	fe843783          	ld	a5,-24(s0)
    800032b6:	5f9c                	lw	a5,56(a5)
    800032b8:	2785                	addiw	a5,a5,1
    800032ba:	0007871b          	sext.w	a4,a5
    800032be:	fe843783          	ld	a5,-24(s0)
    800032c2:	df98                	sw	a4,56(a5)
    800032c4:	a811                	j	800032d8 <scheduler+0xaa>
        } else {
          p->lticks++;
    800032c6:	fe843783          	ld	a5,-24(s0)
    800032ca:	5fdc                	lw	a5,60(a5)
    800032cc:	2785                	addiw	a5,a5,1
    800032ce:	0007871b          	sext.w	a4,a5
    800032d2:	fe843783          	ld	a5,-24(s0)
    800032d6:	dfd8                	sw	a4,60(a5)
        }
        
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us
        p->state = RUNNING;
    800032d8:	fe843783          	ld	a5,-24(s0)
    800032dc:	4711                	li	a4,4
    800032de:	cf98                	sw	a4,24(a5)
        c->proc = p;
    800032e0:	fe043783          	ld	a5,-32(s0)
    800032e4:	fe843703          	ld	a4,-24(s0)
    800032e8:	e398                	sd	a4,0(a5)
        swtch(&c->context, &p->context);
    800032ea:	fe043783          	ld	a5,-32(s0)
    800032ee:	00878713          	addi	a4,a5,8
    800032f2:	fe843783          	ld	a5,-24(s0)
    800032f6:	06878793          	addi	a5,a5,104
    800032fa:	85be                	mv	a1,a5
    800032fc:	853a                	mv	a0,a4
    800032fe:	00001097          	auipc	ra,0x1
    80003302:	814080e7          	jalr	-2028(ra) # 80003b12 <swtch>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
    80003306:	fe043783          	ld	a5,-32(s0)
    8000330a:	0007b023          	sd	zero,0(a5)
      }
      if (proc_break == true){
    8000330e:	00009797          	auipc	a5,0x9
    80003312:	d1278793          	addi	a5,a5,-750 # 8000c020 <proc_break>
    80003316:	0007c783          	lbu	a5,0(a5)
    8000331a:	cf99                	beqz	a5,80003338 <scheduler+0x10a>
        proc_break = false;
    8000331c:	00009797          	auipc	a5,0x9
    80003320:	d0478793          	addi	a5,a5,-764 # 8000c020 <proc_break>
    80003324:	00078023          	sb	zero,0(a5)
        release(&p->lock);
    80003328:	fe843783          	ld	a5,-24(s0)
    8000332c:	853e                	mv	a0,a5
    8000332e:	ffffe097          	auipc	ra,0xffffe
    80003332:	fa4080e7          	jalr	-92(ra) # 800012d2 <release>
        break;
    80003336:	a035                	j	80003362 <scheduler+0x134>
      }
      release(&p->lock);
    80003338:	fe843783          	ld	a5,-24(s0)
    8000333c:	853e                	mv	a0,a5
    8000333e:	ffffe097          	auipc	ra,0xffffe
    80003342:	f94080e7          	jalr	-108(ra) # 800012d2 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80003346:	fe843783          	ld	a5,-24(s0)
    8000334a:	17078793          	addi	a5,a5,368
    8000334e:	fef43423          	sd	a5,-24(s0)
    80003352:	fe843703          	ld	a4,-24(s0)
    80003356:	00017797          	auipc	a5,0x17
    8000335a:	f6a78793          	addi	a5,a5,-150 # 8001a2c0 <pid_lock>
    8000335e:	f0f761e3          	bltu	a4,a5,80003260 <scheduler+0x32>
    intr_on();
    80003362:	b5e5                	j	8000324a <scheduler+0x1c>

0000000080003364 <sched>:
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
    80003364:	7179                	addi	sp,sp,-48
    80003366:	f406                	sd	ra,40(sp)
    80003368:	f022                	sd	s0,32(sp)
    8000336a:	ec26                	sd	s1,24(sp)
    8000336c:	1800                	addi	s0,sp,48
  int intena;
  struct proc *p = myproc();
    8000336e:	fffff097          	auipc	ra,0xfffff
    80003372:	4a6080e7          	jalr	1190(ra) # 80002814 <myproc>
    80003376:	fca43c23          	sd	a0,-40(s0)

  if(!holding(&p->lock))
    8000337a:	fd843783          	ld	a5,-40(s0)
    8000337e:	853e                	mv	a0,a5
    80003380:	ffffe097          	auipc	ra,0xffffe
    80003384:	fa8080e7          	jalr	-88(ra) # 80001328 <holding>
    80003388:	87aa                	mv	a5,a0
    8000338a:	eb89                	bnez	a5,8000339c <sched+0x38>
    panic("sched p->lock");
    8000338c:	00008517          	auipc	a0,0x8
    80003390:	e9450513          	addi	a0,a0,-364 # 8000b220 <etext+0x220>
    80003394:	ffffe097          	auipc	ra,0xffffe
    80003398:	8ea080e7          	jalr	-1814(ra) # 80000c7e <panic>
  if(mycpu()->noff != 1)
    8000339c:	fffff097          	auipc	ra,0xfffff
    800033a0:	43e080e7          	jalr	1086(ra) # 800027da <mycpu>
    800033a4:	87aa                	mv	a5,a0
    800033a6:	5fbc                	lw	a5,120(a5)
    800033a8:	873e                	mv	a4,a5
    800033aa:	4785                	li	a5,1
    800033ac:	00f70a63          	beq	a4,a5,800033c0 <sched+0x5c>
    panic("sched locks");
    800033b0:	00008517          	auipc	a0,0x8
    800033b4:	e8050513          	addi	a0,a0,-384 # 8000b230 <etext+0x230>
    800033b8:	ffffe097          	auipc	ra,0xffffe
    800033bc:	8c6080e7          	jalr	-1850(ra) # 80000c7e <panic>
  if(p->state == RUNNING)
    800033c0:	fd843783          	ld	a5,-40(s0)
    800033c4:	4f9c                	lw	a5,24(a5)
    800033c6:	873e                	mv	a4,a5
    800033c8:	4791                	li	a5,4
    800033ca:	00f71a63          	bne	a4,a5,800033de <sched+0x7a>
    panic("sched running");
    800033ce:	00008517          	auipc	a0,0x8
    800033d2:	e7250513          	addi	a0,a0,-398 # 8000b240 <etext+0x240>
    800033d6:	ffffe097          	auipc	ra,0xffffe
    800033da:	8a8080e7          	jalr	-1880(ra) # 80000c7e <panic>
  if(intr_get())
    800033de:	fffff097          	auipc	ra,0xfffff
    800033e2:	210080e7          	jalr	528(ra) # 800025ee <intr_get>
    800033e6:	87aa                	mv	a5,a0
    800033e8:	cb89                	beqz	a5,800033fa <sched+0x96>
    panic("sched interruptible");
    800033ea:	00008517          	auipc	a0,0x8
    800033ee:	e6650513          	addi	a0,a0,-410 # 8000b250 <etext+0x250>
    800033f2:	ffffe097          	auipc	ra,0xffffe
    800033f6:	88c080e7          	jalr	-1908(ra) # 80000c7e <panic>

  intena = mycpu()->intena;
    800033fa:	fffff097          	auipc	ra,0xfffff
    800033fe:	3e0080e7          	jalr	992(ra) # 800027da <mycpu>
    80003402:	87aa                	mv	a5,a0
    80003404:	5ffc                	lw	a5,124(a5)
    80003406:	fcf42a23          	sw	a5,-44(s0)
  swtch(&p->context, &mycpu()->context);
    8000340a:	fd843783          	ld	a5,-40(s0)
    8000340e:	06878493          	addi	s1,a5,104
    80003412:	fffff097          	auipc	ra,0xfffff
    80003416:	3c8080e7          	jalr	968(ra) # 800027da <mycpu>
    8000341a:	87aa                	mv	a5,a0
    8000341c:	07a1                	addi	a5,a5,8
    8000341e:	85be                	mv	a1,a5
    80003420:	8526                	mv	a0,s1
    80003422:	00000097          	auipc	ra,0x0
    80003426:	6f0080e7          	jalr	1776(ra) # 80003b12 <swtch>
  mycpu()->intena = intena;
    8000342a:	fffff097          	auipc	ra,0xfffff
    8000342e:	3b0080e7          	jalr	944(ra) # 800027da <mycpu>
    80003432:	872a                	mv	a4,a0
    80003434:	fd442783          	lw	a5,-44(s0)
    80003438:	df7c                	sw	a5,124(a4)
}
    8000343a:	0001                	nop
    8000343c:	70a2                	ld	ra,40(sp)
    8000343e:	7402                	ld	s0,32(sp)
    80003440:	64e2                	ld	s1,24(sp)
    80003442:	6145                	addi	sp,sp,48
    80003444:	8082                	ret

0000000080003446 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
    80003446:	1101                	addi	sp,sp,-32
    80003448:	ec06                	sd	ra,24(sp)
    8000344a:	e822                	sd	s0,16(sp)
    8000344c:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    8000344e:	fffff097          	auipc	ra,0xfffff
    80003452:	3c6080e7          	jalr	966(ra) # 80002814 <myproc>
    80003456:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    8000345a:	fe843783          	ld	a5,-24(s0)
    8000345e:	853e                	mv	a0,a5
    80003460:	ffffe097          	auipc	ra,0xffffe
    80003464:	e0e080e7          	jalr	-498(ra) # 8000126e <acquire>
  p->state = RUNNABLE;
    80003468:	fe843783          	ld	a5,-24(s0)
    8000346c:	470d                	li	a4,3
    8000346e:	cf98                	sw	a4,24(a5)
  sched();
    80003470:	00000097          	auipc	ra,0x0
    80003474:	ef4080e7          	jalr	-268(ra) # 80003364 <sched>
  release(&p->lock);
    80003478:	fe843783          	ld	a5,-24(s0)
    8000347c:	853e                	mv	a0,a5
    8000347e:	ffffe097          	auipc	ra,0xffffe
    80003482:	e54080e7          	jalr	-428(ra) # 800012d2 <release>
}
    80003486:	0001                	nop
    80003488:	60e2                	ld	ra,24(sp)
    8000348a:	6442                	ld	s0,16(sp)
    8000348c:	6105                	addi	sp,sp,32
    8000348e:	8082                	ret

0000000080003490 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80003490:	1141                	addi	sp,sp,-16
    80003492:	e406                	sd	ra,8(sp)
    80003494:	e022                	sd	s0,0(sp)
    80003496:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80003498:	fffff097          	auipc	ra,0xfffff
    8000349c:	37c080e7          	jalr	892(ra) # 80002814 <myproc>
    800034a0:	87aa                	mv	a5,a0
    800034a2:	853e                	mv	a0,a5
    800034a4:	ffffe097          	auipc	ra,0xffffe
    800034a8:	e2e080e7          	jalr	-466(ra) # 800012d2 <release>

  if (first) {
    800034ac:	00008797          	auipc	a5,0x8
    800034b0:	28878793          	addi	a5,a5,648 # 8000b734 <first.1>
    800034b4:	439c                	lw	a5,0(a5)
    800034b6:	cf81                	beqz	a5,800034ce <forkret+0x3e>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    first = 0;
    800034b8:	00008797          	auipc	a5,0x8
    800034bc:	27c78793          	addi	a5,a5,636 # 8000b734 <first.1>
    800034c0:	0007a023          	sw	zero,0(a5)
    fsinit(ROOTDEV);
    800034c4:	4505                	li	a0,1
    800034c6:	00001097          	auipc	ra,0x1
    800034ca:	7ea080e7          	jalr	2026(ra) # 80004cb0 <fsinit>
  }

  usertrapret();
    800034ce:	00001097          	auipc	ra,0x1
    800034d2:	9e2080e7          	jalr	-1566(ra) # 80003eb0 <usertrapret>
}
    800034d6:	0001                	nop
    800034d8:	60a2                	ld	ra,8(sp)
    800034da:	6402                	ld	s0,0(sp)
    800034dc:	0141                	addi	sp,sp,16
    800034de:	8082                	ret

00000000800034e0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800034e0:	7179                	addi	sp,sp,-48
    800034e2:	f406                	sd	ra,40(sp)
    800034e4:	f022                	sd	s0,32(sp)
    800034e6:	1800                	addi	s0,sp,48
    800034e8:	fca43c23          	sd	a0,-40(s0)
    800034ec:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    800034f0:	fffff097          	auipc	ra,0xfffff
    800034f4:	324080e7          	jalr	804(ra) # 80002814 <myproc>
    800034f8:	fea43423          	sd	a0,-24(s0)
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800034fc:	fe843783          	ld	a5,-24(s0)
    80003500:	853e                	mv	a0,a5
    80003502:	ffffe097          	auipc	ra,0xffffe
    80003506:	d6c080e7          	jalr	-660(ra) # 8000126e <acquire>
  release(lk);
    8000350a:	fd043503          	ld	a0,-48(s0)
    8000350e:	ffffe097          	auipc	ra,0xffffe
    80003512:	dc4080e7          	jalr	-572(ra) # 800012d2 <release>

  // Go to sleep.
  p->chan = chan;
    80003516:	fe843783          	ld	a5,-24(s0)
    8000351a:	fd843703          	ld	a4,-40(s0)
    8000351e:	f398                	sd	a4,32(a5)
  p->state = SLEEPING;
    80003520:	fe843783          	ld	a5,-24(s0)
    80003524:	4709                	li	a4,2
    80003526:	cf98                	sw	a4,24(a5)

  if (p->priority == HIGH_PRIORITY){ //disminuimos número de procesos con alta prioridaad pendientes de ejecutarse
    80003528:	fe843783          	ld	a5,-24(s0)
    8000352c:	5bdc                	lw	a5,52(a5)
    8000352e:	873e                	mv	a4,a5
    80003530:	4789                	li	a5,2
    80003532:	02f71f63          	bne	a4,a5,80003570 <sleep+0x90>
   acquire(&priority_lock);
    80003536:	00011517          	auipc	a0,0x11
    8000353a:	d7250513          	addi	a0,a0,-654 # 800142a8 <priority_lock>
    8000353e:	ffffe097          	auipc	ra,0xffffe
    80003542:	d30080e7          	jalr	-720(ra) # 8000126e <acquire>
    high_priority_procs--;
    80003546:	00009797          	auipc	a5,0x9
    8000354a:	ade78793          	addi	a5,a5,-1314 # 8000c024 <high_priority_procs>
    8000354e:	439c                	lw	a5,0(a5)
    80003550:	37fd                	addiw	a5,a5,-1
    80003552:	0007871b          	sext.w	a4,a5
    80003556:	00009797          	auipc	a5,0x9
    8000355a:	ace78793          	addi	a5,a5,-1330 # 8000c024 <high_priority_procs>
    8000355e:	c398                	sw	a4,0(a5)
    release(&priority_lock);
    80003560:	00011517          	auipc	a0,0x11
    80003564:	d4850513          	addi	a0,a0,-696 # 800142a8 <priority_lock>
    80003568:	ffffe097          	auipc	ra,0xffffe
    8000356c:	d6a080e7          	jalr	-662(ra) # 800012d2 <release>
  }

  sched();
    80003570:	00000097          	auipc	ra,0x0
    80003574:	df4080e7          	jalr	-524(ra) # 80003364 <sched>

  // Tidy up.
  p->chan = 0;
    80003578:	fe843783          	ld	a5,-24(s0)
    8000357c:	0207b023          	sd	zero,32(a5)

  // Reacquire original lock.
  release(&p->lock);
    80003580:	fe843783          	ld	a5,-24(s0)
    80003584:	853e                	mv	a0,a5
    80003586:	ffffe097          	auipc	ra,0xffffe
    8000358a:	d4c080e7          	jalr	-692(ra) # 800012d2 <release>
  acquire(lk);
    8000358e:	fd043503          	ld	a0,-48(s0)
    80003592:	ffffe097          	auipc	ra,0xffffe
    80003596:	cdc080e7          	jalr	-804(ra) # 8000126e <acquire>
}
    8000359a:	0001                	nop
    8000359c:	70a2                	ld	ra,40(sp)
    8000359e:	7402                	ld	s0,32(sp)
    800035a0:	6145                	addi	sp,sp,48
    800035a2:	8082                	ret

00000000800035a4 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800035a4:	7179                	addi	sp,sp,-48
    800035a6:	f406                	sd	ra,40(sp)
    800035a8:	f022                	sd	s0,32(sp)
    800035aa:	1800                	addi	s0,sp,48
    800035ac:	fca43c23          	sd	a0,-40(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800035b0:	00011797          	auipc	a5,0x11
    800035b4:	11078793          	addi	a5,a5,272 # 800146c0 <proc>
    800035b8:	fef43423          	sd	a5,-24(s0)
    800035bc:	a065                	j	80003664 <wakeup+0xc0>
    if(p != myproc()){
    800035be:	fffff097          	auipc	ra,0xfffff
    800035c2:	256080e7          	jalr	598(ra) # 80002814 <myproc>
    800035c6:	872a                	mv	a4,a0
    800035c8:	fe843783          	ld	a5,-24(s0)
    800035cc:	08e78663          	beq	a5,a4,80003658 <wakeup+0xb4>
      acquire(&p->lock);
    800035d0:	fe843783          	ld	a5,-24(s0)
    800035d4:	853e                	mv	a0,a5
    800035d6:	ffffe097          	auipc	ra,0xffffe
    800035da:	c98080e7          	jalr	-872(ra) # 8000126e <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800035de:	fe843783          	ld	a5,-24(s0)
    800035e2:	4f9c                	lw	a5,24(a5)
    800035e4:	873e                	mv	a4,a5
    800035e6:	4789                	li	a5,2
    800035e8:	06f71163          	bne	a4,a5,8000364a <wakeup+0xa6>
    800035ec:	fe843783          	ld	a5,-24(s0)
    800035f0:	739c                	ld	a5,32(a5)
    800035f2:	fd843703          	ld	a4,-40(s0)
    800035f6:	04f71a63          	bne	a4,a5,8000364a <wakeup+0xa6>
        p->state = RUNNABLE;
    800035fa:	fe843783          	ld	a5,-24(s0)
    800035fe:	470d                	li	a4,3
    80003600:	cf98                	sw	a4,24(a5)

        if (p->priority == HIGH_PRIORITY){ //cuando se despierta de nuevo el proceso de alta prioridad, se incrementa la variable.
    80003602:	fe843783          	ld	a5,-24(s0)
    80003606:	5bdc                	lw	a5,52(a5)
    80003608:	873e                	mv	a4,a5
    8000360a:	4789                	li	a5,2
    8000360c:	02f71f63          	bne	a4,a5,8000364a <wakeup+0xa6>
          acquire(&priority_lock);
    80003610:	00011517          	auipc	a0,0x11
    80003614:	c9850513          	addi	a0,a0,-872 # 800142a8 <priority_lock>
    80003618:	ffffe097          	auipc	ra,0xffffe
    8000361c:	c56080e7          	jalr	-938(ra) # 8000126e <acquire>
          high_priority_procs++;
    80003620:	00009797          	auipc	a5,0x9
    80003624:	a0478793          	addi	a5,a5,-1532 # 8000c024 <high_priority_procs>
    80003628:	439c                	lw	a5,0(a5)
    8000362a:	2785                	addiw	a5,a5,1
    8000362c:	0007871b          	sext.w	a4,a5
    80003630:	00009797          	auipc	a5,0x9
    80003634:	9f478793          	addi	a5,a5,-1548 # 8000c024 <high_priority_procs>
    80003638:	c398                	sw	a4,0(a5)
          release(&priority_lock);
    8000363a:	00011517          	auipc	a0,0x11
    8000363e:	c6e50513          	addi	a0,a0,-914 # 800142a8 <priority_lock>
    80003642:	ffffe097          	auipc	ra,0xffffe
    80003646:	c90080e7          	jalr	-880(ra) # 800012d2 <release>
        }

      }
      release(&p->lock);
    8000364a:	fe843783          	ld	a5,-24(s0)
    8000364e:	853e                	mv	a0,a5
    80003650:	ffffe097          	auipc	ra,0xffffe
    80003654:	c82080e7          	jalr	-894(ra) # 800012d2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80003658:	fe843783          	ld	a5,-24(s0)
    8000365c:	17078793          	addi	a5,a5,368
    80003660:	fef43423          	sd	a5,-24(s0)
    80003664:	fe843703          	ld	a4,-24(s0)
    80003668:	00017797          	auipc	a5,0x17
    8000366c:	c5878793          	addi	a5,a5,-936 # 8001a2c0 <pid_lock>
    80003670:	f4f767e3          	bltu	a4,a5,800035be <wakeup+0x1a>
    }
  }
}
    80003674:	0001                	nop
    80003676:	0001                	nop
    80003678:	70a2                	ld	ra,40(sp)
    8000367a:	7402                	ld	s0,32(sp)
    8000367c:	6145                	addi	sp,sp,48
    8000367e:	8082                	ret

0000000080003680 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80003680:	7179                	addi	sp,sp,-48
    80003682:	f406                	sd	ra,40(sp)
    80003684:	f022                	sd	s0,32(sp)
    80003686:	1800                	addi	s0,sp,48
    80003688:	87aa                	mv	a5,a0
    8000368a:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000368e:	00011797          	auipc	a5,0x11
    80003692:	03278793          	addi	a5,a5,50 # 800146c0 <proc>
    80003696:	fef43423          	sd	a5,-24(s0)
    8000369a:	a0ad                	j	80003704 <kill+0x84>
    acquire(&p->lock);
    8000369c:	fe843783          	ld	a5,-24(s0)
    800036a0:	853e                	mv	a0,a5
    800036a2:	ffffe097          	auipc	ra,0xffffe
    800036a6:	bcc080e7          	jalr	-1076(ra) # 8000126e <acquire>
    if(p->pid == pid){
    800036aa:	fe843783          	ld	a5,-24(s0)
    800036ae:	5b98                	lw	a4,48(a5)
    800036b0:	fdc42783          	lw	a5,-36(s0)
    800036b4:	2781                	sext.w	a5,a5
    800036b6:	02e79a63          	bne	a5,a4,800036ea <kill+0x6a>
      p->killed = 1;
    800036ba:	fe843783          	ld	a5,-24(s0)
    800036be:	4705                	li	a4,1
    800036c0:	d798                	sw	a4,40(a5)
      if(p->state == SLEEPING){
    800036c2:	fe843783          	ld	a5,-24(s0)
    800036c6:	4f9c                	lw	a5,24(a5)
    800036c8:	873e                	mv	a4,a5
    800036ca:	4789                	li	a5,2
    800036cc:	00f71663          	bne	a4,a5,800036d8 <kill+0x58>
        // Wake process from sleep().
        p->state = RUNNABLE;
    800036d0:	fe843783          	ld	a5,-24(s0)
    800036d4:	470d                	li	a4,3
    800036d6:	cf98                	sw	a4,24(a5)
      }
      release(&p->lock);
    800036d8:	fe843783          	ld	a5,-24(s0)
    800036dc:	853e                	mv	a0,a5
    800036de:	ffffe097          	auipc	ra,0xffffe
    800036e2:	bf4080e7          	jalr	-1036(ra) # 800012d2 <release>
      return 0;
    800036e6:	4781                	li	a5,0
    800036e8:	a03d                	j	80003716 <kill+0x96>
    }
    release(&p->lock);
    800036ea:	fe843783          	ld	a5,-24(s0)
    800036ee:	853e                	mv	a0,a5
    800036f0:	ffffe097          	auipc	ra,0xffffe
    800036f4:	be2080e7          	jalr	-1054(ra) # 800012d2 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800036f8:	fe843783          	ld	a5,-24(s0)
    800036fc:	17078793          	addi	a5,a5,368
    80003700:	fef43423          	sd	a5,-24(s0)
    80003704:	fe843703          	ld	a4,-24(s0)
    80003708:	00017797          	auipc	a5,0x17
    8000370c:	bb878793          	addi	a5,a5,-1096 # 8001a2c0 <pid_lock>
    80003710:	f8f766e3          	bltu	a4,a5,8000369c <kill+0x1c>
  }
  return -1;
    80003714:	57fd                	li	a5,-1
}
    80003716:	853e                	mv	a0,a5
    80003718:	70a2                	ld	ra,40(sp)
    8000371a:	7402                	ld	s0,32(sp)
    8000371c:	6145                	addi	sp,sp,48
    8000371e:	8082                	ret

0000000080003720 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80003720:	7139                	addi	sp,sp,-64
    80003722:	fc06                	sd	ra,56(sp)
    80003724:	f822                	sd	s0,48(sp)
    80003726:	0080                	addi	s0,sp,64
    80003728:	87aa                	mv	a5,a0
    8000372a:	fcb43823          	sd	a1,-48(s0)
    8000372e:	fcc43423          	sd	a2,-56(s0)
    80003732:	fcd43023          	sd	a3,-64(s0)
    80003736:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    8000373a:	fffff097          	auipc	ra,0xfffff
    8000373e:	0da080e7          	jalr	218(ra) # 80002814 <myproc>
    80003742:	fea43423          	sd	a0,-24(s0)
  if(user_dst){
    80003746:	fdc42783          	lw	a5,-36(s0)
    8000374a:	2781                	sext.w	a5,a5
    8000374c:	c38d                	beqz	a5,8000376e <either_copyout+0x4e>
    return copyout(p->pagetable, dst, src, len);
    8000374e:	fe843783          	ld	a5,-24(s0)
    80003752:	6fbc                	ld	a5,88(a5)
    80003754:	fc043683          	ld	a3,-64(s0)
    80003758:	fc843603          	ld	a2,-56(s0)
    8000375c:	fd043583          	ld	a1,-48(s0)
    80003760:	853e                	mv	a0,a5
    80003762:	fffff097          	auipc	ra,0xfffff
    80003766:	b84080e7          	jalr	-1148(ra) # 800022e6 <copyout>
    8000376a:	87aa                	mv	a5,a0
    8000376c:	a839                	j	8000378a <either_copyout+0x6a>
  } else {
    memmove((char *)dst, src, len);
    8000376e:	fd043783          	ld	a5,-48(s0)
    80003772:	fc043703          	ld	a4,-64(s0)
    80003776:	2701                	sext.w	a4,a4
    80003778:	863a                	mv	a2,a4
    8000377a:	fc843583          	ld	a1,-56(s0)
    8000377e:	853e                	mv	a0,a5
    80003780:	ffffe097          	auipc	ra,0xffffe
    80003784:	da6080e7          	jalr	-602(ra) # 80001526 <memmove>
    return 0;
    80003788:	4781                	li	a5,0
  }
}
    8000378a:	853e                	mv	a0,a5
    8000378c:	70e2                	ld	ra,56(sp)
    8000378e:	7442                	ld	s0,48(sp)
    80003790:	6121                	addi	sp,sp,64
    80003792:	8082                	ret

0000000080003794 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80003794:	7139                	addi	sp,sp,-64
    80003796:	fc06                	sd	ra,56(sp)
    80003798:	f822                	sd	s0,48(sp)
    8000379a:	0080                	addi	s0,sp,64
    8000379c:	fca43c23          	sd	a0,-40(s0)
    800037a0:	87ae                	mv	a5,a1
    800037a2:	fcc43423          	sd	a2,-56(s0)
    800037a6:	fcd43023          	sd	a3,-64(s0)
    800037aa:	fcf42a23          	sw	a5,-44(s0)
  struct proc *p = myproc();
    800037ae:	fffff097          	auipc	ra,0xfffff
    800037b2:	066080e7          	jalr	102(ra) # 80002814 <myproc>
    800037b6:	fea43423          	sd	a0,-24(s0)
  if(user_src){
    800037ba:	fd442783          	lw	a5,-44(s0)
    800037be:	2781                	sext.w	a5,a5
    800037c0:	c38d                	beqz	a5,800037e2 <either_copyin+0x4e>
    return copyin(p->pagetable, dst, src, len);
    800037c2:	fe843783          	ld	a5,-24(s0)
    800037c6:	6fbc                	ld	a5,88(a5)
    800037c8:	fc043683          	ld	a3,-64(s0)
    800037cc:	fc843603          	ld	a2,-56(s0)
    800037d0:	fd843583          	ld	a1,-40(s0)
    800037d4:	853e                	mv	a0,a5
    800037d6:	fffff097          	auipc	ra,0xfffff
    800037da:	bde080e7          	jalr	-1058(ra) # 800023b4 <copyin>
    800037de:	87aa                	mv	a5,a0
    800037e0:	a839                	j	800037fe <either_copyin+0x6a>
  } else {
    memmove(dst, (char*)src, len);
    800037e2:	fc843783          	ld	a5,-56(s0)
    800037e6:	fc043703          	ld	a4,-64(s0)
    800037ea:	2701                	sext.w	a4,a4
    800037ec:	863a                	mv	a2,a4
    800037ee:	85be                	mv	a1,a5
    800037f0:	fd843503          	ld	a0,-40(s0)
    800037f4:	ffffe097          	auipc	ra,0xffffe
    800037f8:	d32080e7          	jalr	-718(ra) # 80001526 <memmove>
    return 0;
    800037fc:	4781                	li	a5,0
  }
}
    800037fe:	853e                	mv	a0,a5
    80003800:	70e2                	ld	ra,56(sp)
    80003802:	7442                	ld	s0,48(sp)
    80003804:	6121                	addi	sp,sp,64
    80003806:	8082                	ret

0000000080003808 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80003808:	1101                	addi	sp,sp,-32
    8000380a:	ec06                	sd	ra,24(sp)
    8000380c:	e822                	sd	s0,16(sp)
    8000380e:	1000                	addi	s0,sp,32
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80003810:	00008517          	auipc	a0,0x8
    80003814:	a5850513          	addi	a0,a0,-1448 # 8000b268 <etext+0x268>
    80003818:	ffffd097          	auipc	ra,0xffffd
    8000381c:	210080e7          	jalr	528(ra) # 80000a28 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80003820:	00011797          	auipc	a5,0x11
    80003824:	ea078793          	addi	a5,a5,-352 # 800146c0 <proc>
    80003828:	fef43423          	sd	a5,-24(s0)
    8000382c:	a04d                	j	800038ce <procdump+0xc6>
    if(p->state == UNUSED)
    8000382e:	fe843783          	ld	a5,-24(s0)
    80003832:	4f9c                	lw	a5,24(a5)
    80003834:	c7d1                	beqz	a5,800038c0 <procdump+0xb8>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80003836:	fe843783          	ld	a5,-24(s0)
    8000383a:	4f9c                	lw	a5,24(a5)
    8000383c:	873e                	mv	a4,a5
    8000383e:	4795                	li	a5,5
    80003840:	02e7ee63          	bltu	a5,a4,8000387c <procdump+0x74>
    80003844:	fe843783          	ld	a5,-24(s0)
    80003848:	4f9c                	lw	a5,24(a5)
    8000384a:	00008717          	auipc	a4,0x8
    8000384e:	f4670713          	addi	a4,a4,-186 # 8000b790 <states.0>
    80003852:	1782                	slli	a5,a5,0x20
    80003854:	9381                	srli	a5,a5,0x20
    80003856:	078e                	slli	a5,a5,0x3
    80003858:	97ba                	add	a5,a5,a4
    8000385a:	639c                	ld	a5,0(a5)
    8000385c:	c385                	beqz	a5,8000387c <procdump+0x74>
      state = states[p->state];
    8000385e:	fe843783          	ld	a5,-24(s0)
    80003862:	4f9c                	lw	a5,24(a5)
    80003864:	00008717          	auipc	a4,0x8
    80003868:	f2c70713          	addi	a4,a4,-212 # 8000b790 <states.0>
    8000386c:	1782                	slli	a5,a5,0x20
    8000386e:	9381                	srli	a5,a5,0x20
    80003870:	078e                	slli	a5,a5,0x3
    80003872:	97ba                	add	a5,a5,a4
    80003874:	639c                	ld	a5,0(a5)
    80003876:	fef43023          	sd	a5,-32(s0)
    8000387a:	a039                	j	80003888 <procdump+0x80>
    else
      state = "???";
    8000387c:	00008797          	auipc	a5,0x8
    80003880:	9f478793          	addi	a5,a5,-1548 # 8000b270 <etext+0x270>
    80003884:	fef43023          	sd	a5,-32(s0)
    printf("%d %s %s", p->pid, state, p->name);
    80003888:	fe843783          	ld	a5,-24(s0)
    8000388c:	5b98                	lw	a4,48(a5)
    8000388e:	fe843783          	ld	a5,-24(s0)
    80003892:	16078793          	addi	a5,a5,352
    80003896:	86be                	mv	a3,a5
    80003898:	fe043603          	ld	a2,-32(s0)
    8000389c:	85ba                	mv	a1,a4
    8000389e:	00008517          	auipc	a0,0x8
    800038a2:	9da50513          	addi	a0,a0,-1574 # 8000b278 <etext+0x278>
    800038a6:	ffffd097          	auipc	ra,0xffffd
    800038aa:	182080e7          	jalr	386(ra) # 80000a28 <printf>
    printf("\n");
    800038ae:	00008517          	auipc	a0,0x8
    800038b2:	9ba50513          	addi	a0,a0,-1606 # 8000b268 <etext+0x268>
    800038b6:	ffffd097          	auipc	ra,0xffffd
    800038ba:	172080e7          	jalr	370(ra) # 80000a28 <printf>
    800038be:	a011                	j	800038c2 <procdump+0xba>
      continue;
    800038c0:	0001                	nop
  for(p = proc; p < &proc[NPROC]; p++){
    800038c2:	fe843783          	ld	a5,-24(s0)
    800038c6:	17078793          	addi	a5,a5,368
    800038ca:	fef43423          	sd	a5,-24(s0)
    800038ce:	fe843703          	ld	a4,-24(s0)
    800038d2:	00017797          	auipc	a5,0x17
    800038d6:	9ee78793          	addi	a5,a5,-1554 # 8001a2c0 <pid_lock>
    800038da:	f4f76ae3          	bltu	a4,a5,8000382e <procdump+0x26>
  }
}
    800038de:	0001                	nop
    800038e0:	0001                	nop
    800038e2:	60e2                	ld	ra,24(sp)
    800038e4:	6442                	ld	s0,16(sp)
    800038e6:	6105                	addi	sp,sp,32
    800038e8:	8082                	ret

00000000800038ea <getpinfo>:


int 
getpinfo (uint64  addr){
    800038ea:	7139                	addi	sp,sp,-64
    800038ec:	fc06                	sd	ra,56(sp)
    800038ee:	f822                	sd	s0,48(sp)
    800038f0:	0080                	addi	s0,sp,64
    800038f2:	81010113          	addi	sp,sp,-2032
    800038f6:	77fd                	lui	a5,0xfffff
    800038f8:	ff040713          	addi	a4,s0,-16
    800038fc:	97ba                	add	a5,a5,a4
    800038fe:	7ea7b423          	sd	a0,2024(a5) # fffffffffffff7e8 <end+0xffffffff7ffd67e8>

  //definición del proceso y estructura pstat
  struct proc *p;
  struct pstat ps;
  uint64 counter = 0;
    80003902:	fe043023          	sd	zero,-32(s0)


  for(p = proc; p < &proc[NPROC]; p++) {
    80003906:	00011797          	auipc	a5,0x11
    8000390a:	dba78793          	addi	a5,a5,-582 # 800146c0 <proc>
    8000390e:	fef43423          	sd	a5,-24(s0)
    80003912:	a0e1                	j	800039da <getpinfo+0xf0>
      acquire(&p->lock);
    80003914:	fe843783          	ld	a5,-24(s0)
    80003918:	853e                	mv	a0,a5
    8000391a:	ffffe097          	auipc	ra,0xffffe
    8000391e:	954080e7          	jalr	-1708(ra) # 8000126e <acquire>
      ps.pid[counter] = p->pid;
    80003922:	fe843783          	ld	a5,-24(s0)
    80003926:	5b9c                	lw	a5,48(a5)
    80003928:	86be                	mv	a3,a5
    8000392a:	77fd                	lui	a5,0xfffff
    8000392c:	ff040713          	addi	a4,s0,-16
    80003930:	973e                	add	a4,a4,a5
    80003932:	fe043783          	ld	a5,-32(s0)
    80003936:	04078793          	addi	a5,a5,64 # fffffffffffff040 <end+0xffffffff7ffd6040>
    8000393a:	078e                	slli	a5,a5,0x3
    8000393c:	97ba                	add	a5,a5,a4
    8000393e:	7ed7b823          	sd	a3,2032(a5)
        ps.hticks[counter] = p->hticks;
    80003942:	fe843783          	ld	a5,-24(s0)
    80003946:	5f9c                	lw	a5,56(a5)
    80003948:	86be                	mv	a3,a5
    8000394a:	77fd                	lui	a5,0xfffff
    8000394c:	ff040713          	addi	a4,s0,-16
    80003950:	973e                	add	a4,a4,a5
    80003952:	fe043783          	ld	a5,-32(s0)
    80003956:	08078793          	addi	a5,a5,128 # fffffffffffff080 <end+0xffffffff7ffd6080>
    8000395a:	078e                	slli	a5,a5,0x3
    8000395c:	97ba                	add	a5,a5,a4
    8000395e:	7ed7b823          	sd	a3,2032(a5)
        ps.lticks[counter] = p->lticks;
    80003962:	fe843783          	ld	a5,-24(s0)
    80003966:	5fdc                	lw	a5,60(a5)
    80003968:	86be                	mv	a3,a5
    8000396a:	77fd                	lui	a5,0xfffff
    8000396c:	ff040713          	addi	a4,s0,-16
    80003970:	973e                	add	a4,a4,a5
    80003972:	fe043783          	ld	a5,-32(s0)
    80003976:	0c078793          	addi	a5,a5,192 # fffffffffffff0c0 <end+0xffffffff7ffd60c0>
    8000397a:	078e                	slli	a5,a5,0x3
    8000397c:	97ba                	add	a5,a5,a4
    8000397e:	7ed7b823          	sd	a3,2032(a5)
      if(p->state != UNUSED) {
    80003982:	fe843783          	ld	a5,-24(s0)
    80003986:	4f9c                	lw	a5,24(a5)
    80003988:	cf89                	beqz	a5,800039a2 <getpinfo+0xb8>
        ps.inuse[counter] = 1;
    8000398a:	77fd                	lui	a5,0xfffff
    8000398c:	ff040713          	addi	a4,s0,-16
    80003990:	973e                	add	a4,a4,a5
    80003992:	fe043783          	ld	a5,-32(s0)
    80003996:	078e                	slli	a5,a5,0x3
    80003998:	97ba                	add	a5,a5,a4
    8000399a:	4705                	li	a4,1
    8000399c:	7ee7b823          	sd	a4,2032(a5) # fffffffffffff7f0 <end+0xffffffff7ffd67f0>
    800039a0:	a819                	j	800039b6 <getpinfo+0xcc>
      } else {
        ps.inuse[counter] = 0;
    800039a2:	77fd                	lui	a5,0xfffff
    800039a4:	ff040713          	addi	a4,s0,-16
    800039a8:	973e                	add	a4,a4,a5
    800039aa:	fe043783          	ld	a5,-32(s0)
    800039ae:	078e                	slli	a5,a5,0x3
    800039b0:	97ba                	add	a5,a5,a4
    800039b2:	7e07b823          	sd	zero,2032(a5) # fffffffffffff7f0 <end+0xffffffff7ffd67f0>
      }
      counter++;
    800039b6:	fe043783          	ld	a5,-32(s0)
    800039ba:	0785                	addi	a5,a5,1
    800039bc:	fef43023          	sd	a5,-32(s0)
      release(&p->lock);
    800039c0:	fe843783          	ld	a5,-24(s0)
    800039c4:	853e                	mv	a0,a5
    800039c6:	ffffe097          	auipc	ra,0xffffe
    800039ca:	90c080e7          	jalr	-1780(ra) # 800012d2 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800039ce:	fe843783          	ld	a5,-24(s0)
    800039d2:	17078793          	addi	a5,a5,368
    800039d6:	fef43423          	sd	a5,-24(s0)
    800039da:	fe843703          	ld	a4,-24(s0)
    800039de:	00017797          	auipc	a5,0x17
    800039e2:	8e278793          	addi	a5,a5,-1822 # 8001a2c0 <pid_lock>
    800039e6:	f2f767e3          	bltu	a4,a5,80003914 <getpinfo+0x2a>
    }

    p = myproc(); //calling process
    800039ea:	fffff097          	auipc	ra,0xfffff
    800039ee:	e2a080e7          	jalr	-470(ra) # 80002814 <myproc>
    800039f2:	fea43423          	sd	a0,-24(s0)

    //la estuctura que hemos completado desde el kernel, 
    //se copiará a la tabla de páginas del proceso
    //concretamente donde se esté su respectiva instancia de la estructura pstat.
    if (copyout (p->pagetable, addr, (char *)&ps, sizeof (ps)) < 0){
    800039f6:	fe843783          	ld	a5,-24(s0)
    800039fa:	6fa8                	ld	a0,88(a5)
    800039fc:	77fd                	lui	a5,0xfffff
    800039fe:	7f078793          	addi	a5,a5,2032 # fffffffffffff7f0 <end+0xffffffff7ffd67f0>
    80003a02:	ff040713          	addi	a4,s0,-16
    80003a06:	00f70633          	add	a2,a4,a5
    80003a0a:	77fd                	lui	a5,0xfffff
    80003a0c:	ff040713          	addi	a4,s0,-16
    80003a10:	97ba                	add	a5,a5,a4
    80003a12:	6705                	lui	a4,0x1
    80003a14:	80070693          	addi	a3,a4,-2048 # 800 <_entry-0x7ffff800>
    80003a18:	7e87b583          	ld	a1,2024(a5) # fffffffffffff7e8 <end+0xffffffff7ffd67e8>
    80003a1c:	fffff097          	auipc	ra,0xfffff
    80003a20:	8ca080e7          	jalr	-1846(ra) # 800022e6 <copyout>
    80003a24:	87aa                	mv	a5,a0
    80003a26:	0007d463          	bgez	a5,80003a2e <getpinfo+0x144>
      return -1;
    80003a2a:	57fd                	li	a5,-1
    80003a2c:	a011                	j	80003a30 <getpinfo+0x146>
    }

  return 0;
    80003a2e:	4781                	li	a5,0
}
    80003a30:	853e                	mv	a0,a5
    80003a32:	7f010113          	addi	sp,sp,2032
    80003a36:	70e2                	ld	ra,56(sp)
    80003a38:	7442                	ld	s0,48(sp)
    80003a3a:	6121                	addi	sp,sp,64
    80003a3c:	8082                	ret

0000000080003a3e <setpri>:


int 
setpri (int num)
{
    80003a3e:	7179                	addi	sp,sp,-48
    80003a40:	f406                	sd	ra,40(sp)
    80003a42:	f022                	sd	s0,32(sp)
    80003a44:	1800                	addi	s0,sp,48
    80003a46:	87aa                	mv	a5,a0
    80003a48:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80003a4c:	fffff097          	auipc	ra,0xfffff
    80003a50:	dc8080e7          	jalr	-568(ra) # 80002814 <myproc>
    80003a54:	fea43423          	sd	a0,-24(s0)
  acquire(&p->lock);
    80003a58:	fe843783          	ld	a5,-24(s0)
    80003a5c:	853e                	mv	a0,a5
    80003a5e:	ffffe097          	auipc	ra,0xffffe
    80003a62:	810080e7          	jalr	-2032(ra) # 8000126e <acquire>
  if (p->priority== LOW_PRIORITY && num == HIGH_PRIORITY){ 
    80003a66:	fe843783          	ld	a5,-24(s0)
    80003a6a:	5bdc                	lw	a5,52(a5)
    80003a6c:	873e                	mv	a4,a5
    80003a6e:	4785                	li	a5,1
    80003a70:	02f71763          	bne	a4,a5,80003a9e <setpri+0x60>
    80003a74:	fdc42783          	lw	a5,-36(s0)
    80003a78:	0007871b          	sext.w	a4,a5
    80003a7c:	4789                	li	a5,2
    80003a7e:	02f71063          	bne	a4,a5,80003a9e <setpri+0x60>
    high_priority_procs++;
    80003a82:	00008797          	auipc	a5,0x8
    80003a86:	5a278793          	addi	a5,a5,1442 # 8000c024 <high_priority_procs>
    80003a8a:	439c                	lw	a5,0(a5)
    80003a8c:	2785                	addiw	a5,a5,1
    80003a8e:	0007871b          	sext.w	a4,a5
    80003a92:	00008797          	auipc	a5,0x8
    80003a96:	59278793          	addi	a5,a5,1426 # 8000c024 <high_priority_procs>
    80003a9a:	c398                	sw	a4,0(a5)
    80003a9c:	a889                	j	80003aee <setpri+0xb0>

  } else if (p->priority == HIGH_PRIORITY && num == LOW_PRIORITY){
    80003a9e:	fe843783          	ld	a5,-24(s0)
    80003aa2:	5bdc                	lw	a5,52(a5)
    80003aa4:	873e                	mv	a4,a5
    80003aa6:	4789                	li	a5,2
    80003aa8:	04f71363          	bne	a4,a5,80003aee <setpri+0xb0>
    80003aac:	fdc42783          	lw	a5,-36(s0)
    80003ab0:	0007871b          	sext.w	a4,a5
    80003ab4:	4785                	li	a5,1
    80003ab6:	02f71c63          	bne	a4,a5,80003aee <setpri+0xb0>
    high_priority_procs--;
    80003aba:	00008797          	auipc	a5,0x8
    80003abe:	56a78793          	addi	a5,a5,1386 # 8000c024 <high_priority_procs>
    80003ac2:	439c                	lw	a5,0(a5)
    80003ac4:	37fd                	addiw	a5,a5,-1
    80003ac6:	0007871b          	sext.w	a4,a5
    80003aca:	00008797          	auipc	a5,0x8
    80003ace:	55a78793          	addi	a5,a5,1370 # 8000c024 <high_priority_procs>
    80003ad2:	c398                	sw	a4,0(a5)
    
    if (high_priority_procs == 0){
    80003ad4:	00008797          	auipc	a5,0x8
    80003ad8:	55078793          	addi	a5,a5,1360 # 8000c024 <high_priority_procs>
    80003adc:	439c                	lw	a5,0(a5)
    80003ade:	eb81                	bnez	a5,80003aee <setpri+0xb0>
      proc_break = true;
    80003ae0:	00008797          	auipc	a5,0x8
    80003ae4:	54078793          	addi	a5,a5,1344 # 8000c020 <proc_break>
    80003ae8:	4705                	li	a4,1
    80003aea:	00e78023          	sb	a4,0(a5)
    }
  }
    p->priority = num;
    80003aee:	fe843783          	ld	a5,-24(s0)
    80003af2:	fdc42703          	lw	a4,-36(s0)
    80003af6:	dbd8                	sw	a4,52(a5)
  
  release(&p->lock);
    80003af8:	fe843783          	ld	a5,-24(s0)
    80003afc:	853e                	mv	a0,a5
    80003afe:	ffffd097          	auipc	ra,0xffffd
    80003b02:	7d4080e7          	jalr	2004(ra) # 800012d2 <release>
  return 0;
    80003b06:	4781                	li	a5,0
}
    80003b08:	853e                	mv	a0,a5
    80003b0a:	70a2                	ld	ra,40(sp)
    80003b0c:	7402                	ld	s0,32(sp)
    80003b0e:	6145                	addi	sp,sp,48
    80003b10:	8082                	ret

0000000080003b12 <swtch>:
    80003b12:	00153023          	sd	ra,0(a0)
    80003b16:	00253423          	sd	sp,8(a0)
    80003b1a:	e900                	sd	s0,16(a0)
    80003b1c:	ed04                	sd	s1,24(a0)
    80003b1e:	03253023          	sd	s2,32(a0)
    80003b22:	03353423          	sd	s3,40(a0)
    80003b26:	03453823          	sd	s4,48(a0)
    80003b2a:	03553c23          	sd	s5,56(a0)
    80003b2e:	05653023          	sd	s6,64(a0)
    80003b32:	05753423          	sd	s7,72(a0)
    80003b36:	05853823          	sd	s8,80(a0)
    80003b3a:	05953c23          	sd	s9,88(a0)
    80003b3e:	07a53023          	sd	s10,96(a0)
    80003b42:	07b53423          	sd	s11,104(a0)
    80003b46:	0005b083          	ld	ra,0(a1)
    80003b4a:	0085b103          	ld	sp,8(a1)
    80003b4e:	6980                	ld	s0,16(a1)
    80003b50:	6d84                	ld	s1,24(a1)
    80003b52:	0205b903          	ld	s2,32(a1)
    80003b56:	0285b983          	ld	s3,40(a1)
    80003b5a:	0305ba03          	ld	s4,48(a1)
    80003b5e:	0385ba83          	ld	s5,56(a1)
    80003b62:	0405bb03          	ld	s6,64(a1)
    80003b66:	0485bb83          	ld	s7,72(a1)
    80003b6a:	0505bc03          	ld	s8,80(a1)
    80003b6e:	0585bc83          	ld	s9,88(a1)
    80003b72:	0605bd03          	ld	s10,96(a1)
    80003b76:	0685bd83          	ld	s11,104(a1)
    80003b7a:	8082                	ret

0000000080003b7c <r_sstatus>:
{
    80003b7c:	1101                	addi	sp,sp,-32
    80003b7e:	ec22                	sd	s0,24(sp)
    80003b80:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80003b82:	100027f3          	csrr	a5,sstatus
    80003b86:	fef43423          	sd	a5,-24(s0)
  return x;
    80003b8a:	fe843783          	ld	a5,-24(s0)
}
    80003b8e:	853e                	mv	a0,a5
    80003b90:	6462                	ld	s0,24(sp)
    80003b92:	6105                	addi	sp,sp,32
    80003b94:	8082                	ret

0000000080003b96 <w_sstatus>:
{
    80003b96:	1101                	addi	sp,sp,-32
    80003b98:	ec22                	sd	s0,24(sp)
    80003b9a:	1000                	addi	s0,sp,32
    80003b9c:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80003ba0:	fe843783          	ld	a5,-24(s0)
    80003ba4:	10079073          	csrw	sstatus,a5
}
    80003ba8:	0001                	nop
    80003baa:	6462                	ld	s0,24(sp)
    80003bac:	6105                	addi	sp,sp,32
    80003bae:	8082                	ret

0000000080003bb0 <r_sip>:
{
    80003bb0:	1101                	addi	sp,sp,-32
    80003bb2:	ec22                	sd	s0,24(sp)
    80003bb4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sip" : "=r" (x) );
    80003bb6:	144027f3          	csrr	a5,sip
    80003bba:	fef43423          	sd	a5,-24(s0)
  return x;
    80003bbe:	fe843783          	ld	a5,-24(s0)
}
    80003bc2:	853e                	mv	a0,a5
    80003bc4:	6462                	ld	s0,24(sp)
    80003bc6:	6105                	addi	sp,sp,32
    80003bc8:	8082                	ret

0000000080003bca <w_sip>:
{
    80003bca:	1101                	addi	sp,sp,-32
    80003bcc:	ec22                	sd	s0,24(sp)
    80003bce:	1000                	addi	s0,sp,32
    80003bd0:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sip, %0" : : "r" (x));
    80003bd4:	fe843783          	ld	a5,-24(s0)
    80003bd8:	14479073          	csrw	sip,a5
}
    80003bdc:	0001                	nop
    80003bde:	6462                	ld	s0,24(sp)
    80003be0:	6105                	addi	sp,sp,32
    80003be2:	8082                	ret

0000000080003be4 <w_sepc>:
{
    80003be4:	1101                	addi	sp,sp,-32
    80003be6:	ec22                	sd	s0,24(sp)
    80003be8:	1000                	addi	s0,sp,32
    80003bea:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80003bee:	fe843783          	ld	a5,-24(s0)
    80003bf2:	14179073          	csrw	sepc,a5
}
    80003bf6:	0001                	nop
    80003bf8:	6462                	ld	s0,24(sp)
    80003bfa:	6105                	addi	sp,sp,32
    80003bfc:	8082                	ret

0000000080003bfe <r_sepc>:
{
    80003bfe:	1101                	addi	sp,sp,-32
    80003c00:	ec22                	sd	s0,24(sp)
    80003c02:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80003c04:	141027f3          	csrr	a5,sepc
    80003c08:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c0c:	fe843783          	ld	a5,-24(s0)
}
    80003c10:	853e                	mv	a0,a5
    80003c12:	6462                	ld	s0,24(sp)
    80003c14:	6105                	addi	sp,sp,32
    80003c16:	8082                	ret

0000000080003c18 <w_stvec>:
{
    80003c18:	1101                	addi	sp,sp,-32
    80003c1a:	ec22                	sd	s0,24(sp)
    80003c1c:	1000                	addi	s0,sp,32
    80003c1e:	fea43423          	sd	a0,-24(s0)
  asm volatile("csrw stvec, %0" : : "r" (x));
    80003c22:	fe843783          	ld	a5,-24(s0)
    80003c26:	10579073          	csrw	stvec,a5
}
    80003c2a:	0001                	nop
    80003c2c:	6462                	ld	s0,24(sp)
    80003c2e:	6105                	addi	sp,sp,32
    80003c30:	8082                	ret

0000000080003c32 <r_satp>:
{
    80003c32:	1101                	addi	sp,sp,-32
    80003c34:	ec22                	sd	s0,24(sp)
    80003c36:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, satp" : "=r" (x) );
    80003c38:	180027f3          	csrr	a5,satp
    80003c3c:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c40:	fe843783          	ld	a5,-24(s0)
}
    80003c44:	853e                	mv	a0,a5
    80003c46:	6462                	ld	s0,24(sp)
    80003c48:	6105                	addi	sp,sp,32
    80003c4a:	8082                	ret

0000000080003c4c <r_scause>:
{
    80003c4c:	1101                	addi	sp,sp,-32
    80003c4e:	ec22                	sd	s0,24(sp)
    80003c50:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80003c52:	142027f3          	csrr	a5,scause
    80003c56:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c5a:	fe843783          	ld	a5,-24(s0)
}
    80003c5e:	853e                	mv	a0,a5
    80003c60:	6462                	ld	s0,24(sp)
    80003c62:	6105                	addi	sp,sp,32
    80003c64:	8082                	ret

0000000080003c66 <r_stval>:
{
    80003c66:	1101                	addi	sp,sp,-32
    80003c68:	ec22                	sd	s0,24(sp)
    80003c6a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, stval" : "=r" (x) );
    80003c6c:	143027f3          	csrr	a5,stval
    80003c70:	fef43423          	sd	a5,-24(s0)
  return x;
    80003c74:	fe843783          	ld	a5,-24(s0)
}
    80003c78:	853e                	mv	a0,a5
    80003c7a:	6462                	ld	s0,24(sp)
    80003c7c:	6105                	addi	sp,sp,32
    80003c7e:	8082                	ret

0000000080003c80 <intr_on>:
{
    80003c80:	1141                	addi	sp,sp,-16
    80003c82:	e406                	sd	ra,8(sp)
    80003c84:	e022                	sd	s0,0(sp)
    80003c86:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80003c88:	00000097          	auipc	ra,0x0
    80003c8c:	ef4080e7          	jalr	-268(ra) # 80003b7c <r_sstatus>
    80003c90:	87aa                	mv	a5,a0
    80003c92:	0027e793          	ori	a5,a5,2
    80003c96:	853e                	mv	a0,a5
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	efe080e7          	jalr	-258(ra) # 80003b96 <w_sstatus>
}
    80003ca0:	0001                	nop
    80003ca2:	60a2                	ld	ra,8(sp)
    80003ca4:	6402                	ld	s0,0(sp)
    80003ca6:	0141                	addi	sp,sp,16
    80003ca8:	8082                	ret

0000000080003caa <intr_off>:
{
    80003caa:	1141                	addi	sp,sp,-16
    80003cac:	e406                	sd	ra,8(sp)
    80003cae:	e022                	sd	s0,0(sp)
    80003cb0:	0800                	addi	s0,sp,16
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80003cb2:	00000097          	auipc	ra,0x0
    80003cb6:	eca080e7          	jalr	-310(ra) # 80003b7c <r_sstatus>
    80003cba:	87aa                	mv	a5,a0
    80003cbc:	9bf5                	andi	a5,a5,-3
    80003cbe:	853e                	mv	a0,a5
    80003cc0:	00000097          	auipc	ra,0x0
    80003cc4:	ed6080e7          	jalr	-298(ra) # 80003b96 <w_sstatus>
}
    80003cc8:	0001                	nop
    80003cca:	60a2                	ld	ra,8(sp)
    80003ccc:	6402                	ld	s0,0(sp)
    80003cce:	0141                	addi	sp,sp,16
    80003cd0:	8082                	ret

0000000080003cd2 <intr_get>:
{
    80003cd2:	1101                	addi	sp,sp,-32
    80003cd4:	ec06                	sd	ra,24(sp)
    80003cd6:	e822                	sd	s0,16(sp)
    80003cd8:	1000                	addi	s0,sp,32
  uint64 x = r_sstatus();
    80003cda:	00000097          	auipc	ra,0x0
    80003cde:	ea2080e7          	jalr	-350(ra) # 80003b7c <r_sstatus>
    80003ce2:	fea43423          	sd	a0,-24(s0)
  return (x & SSTATUS_SIE) != 0;
    80003ce6:	fe843783          	ld	a5,-24(s0)
    80003cea:	8b89                	andi	a5,a5,2
    80003cec:	00f037b3          	snez	a5,a5
    80003cf0:	0ff7f793          	andi	a5,a5,255
    80003cf4:	2781                	sext.w	a5,a5
}
    80003cf6:	853e                	mv	a0,a5
    80003cf8:	60e2                	ld	ra,24(sp)
    80003cfa:	6442                	ld	s0,16(sp)
    80003cfc:	6105                	addi	sp,sp,32
    80003cfe:	8082                	ret

0000000080003d00 <r_tp>:
{
    80003d00:	1101                	addi	sp,sp,-32
    80003d02:	ec22                	sd	s0,24(sp)
    80003d04:	1000                	addi	s0,sp,32
  asm volatile("mv %0, tp" : "=r" (x) );
    80003d06:	8792                	mv	a5,tp
    80003d08:	fef43423          	sd	a5,-24(s0)
  return x;
    80003d0c:	fe843783          	ld	a5,-24(s0)
}
    80003d10:	853e                	mv	a0,a5
    80003d12:	6462                	ld	s0,24(sp)
    80003d14:	6105                	addi	sp,sp,32
    80003d16:	8082                	ret

0000000080003d18 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80003d18:	1141                	addi	sp,sp,-16
    80003d1a:	e406                	sd	ra,8(sp)
    80003d1c:	e022                	sd	s0,0(sp)
    80003d1e:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80003d20:	00007597          	auipc	a1,0x7
    80003d24:	59858593          	addi	a1,a1,1432 # 8000b2b8 <etext+0x2b8>
    80003d28:	00016517          	auipc	a0,0x16
    80003d2c:	5c850513          	addi	a0,a0,1480 # 8001a2f0 <tickslock>
    80003d30:	ffffd097          	auipc	ra,0xffffd
    80003d34:	50e080e7          	jalr	1294(ra) # 8000123e <initlock>
}
    80003d38:	0001                	nop
    80003d3a:	60a2                	ld	ra,8(sp)
    80003d3c:	6402                	ld	s0,0(sp)
    80003d3e:	0141                	addi	sp,sp,16
    80003d40:	8082                	ret

0000000080003d42 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80003d42:	1141                	addi	sp,sp,-16
    80003d44:	e406                	sd	ra,8(sp)
    80003d46:	e022                	sd	s0,0(sp)
    80003d48:	0800                	addi	s0,sp,16
  w_stvec((uint64)kernelvec);
    80003d4a:	00005797          	auipc	a5,0x5
    80003d4e:	dd678793          	addi	a5,a5,-554 # 80008b20 <kernelvec>
    80003d52:	853e                	mv	a0,a5
    80003d54:	00000097          	auipc	ra,0x0
    80003d58:	ec4080e7          	jalr	-316(ra) # 80003c18 <w_stvec>
}
    80003d5c:	0001                	nop
    80003d5e:	60a2                	ld	ra,8(sp)
    80003d60:	6402                	ld	s0,0(sp)
    80003d62:	0141                	addi	sp,sp,16
    80003d64:	8082                	ret

0000000080003d66 <usertrap>:
// handle an interrupt, exception, or system call from user space.
// called from trampoline.S
//
void
usertrap(void)
{
    80003d66:	7179                	addi	sp,sp,-48
    80003d68:	f406                	sd	ra,40(sp)
    80003d6a:	f022                	sd	s0,32(sp)
    80003d6c:	ec26                	sd	s1,24(sp)
    80003d6e:	1800                	addi	s0,sp,48
  int which_dev = 0;
    80003d70:	fc042e23          	sw	zero,-36(s0)

  if((r_sstatus() & SSTATUS_SPP) != 0)
    80003d74:	00000097          	auipc	ra,0x0
    80003d78:	e08080e7          	jalr	-504(ra) # 80003b7c <r_sstatus>
    80003d7c:	87aa                	mv	a5,a0
    80003d7e:	1007f793          	andi	a5,a5,256
    80003d82:	cb89                	beqz	a5,80003d94 <usertrap+0x2e>
    panic("usertrap: not from user mode");
    80003d84:	00007517          	auipc	a0,0x7
    80003d88:	53c50513          	addi	a0,a0,1340 # 8000b2c0 <etext+0x2c0>
    80003d8c:	ffffd097          	auipc	ra,0xffffd
    80003d90:	ef2080e7          	jalr	-270(ra) # 80000c7e <panic>

  // send interrupts and exceptions to kerneltrap(),
  // since we're now in the kernel.
  w_stvec((uint64)kernelvec);
    80003d94:	00005797          	auipc	a5,0x5
    80003d98:	d8c78793          	addi	a5,a5,-628 # 80008b20 <kernelvec>
    80003d9c:	853e                	mv	a0,a5
    80003d9e:	00000097          	auipc	ra,0x0
    80003da2:	e7a080e7          	jalr	-390(ra) # 80003c18 <w_stvec>

  struct proc *p = myproc();
    80003da6:	fffff097          	auipc	ra,0xfffff
    80003daa:	a6e080e7          	jalr	-1426(ra) # 80002814 <myproc>
    80003dae:	fca43823          	sd	a0,-48(s0)
  
  // save user program counter.
  p->trapframe->epc = r_sepc();
    80003db2:	fd043783          	ld	a5,-48(s0)
    80003db6:	73a4                	ld	s1,96(a5)
    80003db8:	00000097          	auipc	ra,0x0
    80003dbc:	e46080e7          	jalr	-442(ra) # 80003bfe <r_sepc>
    80003dc0:	87aa                	mv	a5,a0
    80003dc2:	ec9c                	sd	a5,24(s1)
  
  if(r_scause() == 8){
    80003dc4:	00000097          	auipc	ra,0x0
    80003dc8:	e88080e7          	jalr	-376(ra) # 80003c4c <r_scause>
    80003dcc:	872a                	mv	a4,a0
    80003dce:	47a1                	li	a5,8
    80003dd0:	02f71d63          	bne	a4,a5,80003e0a <usertrap+0xa4>
    // system call

    if(p->killed)
    80003dd4:	fd043783          	ld	a5,-48(s0)
    80003dd8:	579c                	lw	a5,40(a5)
    80003dda:	c791                	beqz	a5,80003de6 <usertrap+0x80>
      exit(-1);
    80003ddc:	557d                	li	a0,-1
    80003dde:	fffff097          	auipc	ra,0xfffff
    80003de2:	152080e7          	jalr	338(ra) # 80002f30 <exit>

    // sepc points to the ecall instruction,
    // but we want to return to the next instruction.
    p->trapframe->epc += 4;
    80003de6:	fd043783          	ld	a5,-48(s0)
    80003dea:	73bc                	ld	a5,96(a5)
    80003dec:	6f98                	ld	a4,24(a5)
    80003dee:	fd043783          	ld	a5,-48(s0)
    80003df2:	73bc                	ld	a5,96(a5)
    80003df4:	0711                	addi	a4,a4,4
    80003df6:	ef98                	sd	a4,24(a5)

    // an interrupt will change sstatus &c registers,
    // so don't enable until done with those registers.
    intr_on();
    80003df8:	00000097          	auipc	ra,0x0
    80003dfc:	e88080e7          	jalr	-376(ra) # 80003c80 <intr_on>

    syscall();
    80003e00:	00000097          	auipc	ra,0x0
    80003e04:	67e080e7          	jalr	1662(ra) # 8000447e <syscall>
    80003e08:	a0b5                	j	80003e74 <usertrap+0x10e>
  } else if((which_dev = devintr()) != 0){
    80003e0a:	00000097          	auipc	ra,0x0
    80003e0e:	346080e7          	jalr	838(ra) # 80004150 <devintr>
    80003e12:	87aa                	mv	a5,a0
    80003e14:	fcf42e23          	sw	a5,-36(s0)
    80003e18:	fdc42783          	lw	a5,-36(s0)
    80003e1c:	2781                	sext.w	a5,a5
    80003e1e:	ebb9                	bnez	a5,80003e74 <usertrap+0x10e>
    // ok
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80003e20:	00000097          	auipc	ra,0x0
    80003e24:	e2c080e7          	jalr	-468(ra) # 80003c4c <r_scause>
    80003e28:	872a                	mv	a4,a0
    80003e2a:	fd043783          	ld	a5,-48(s0)
    80003e2e:	5b9c                	lw	a5,48(a5)
    80003e30:	863e                	mv	a2,a5
    80003e32:	85ba                	mv	a1,a4
    80003e34:	00007517          	auipc	a0,0x7
    80003e38:	4ac50513          	addi	a0,a0,1196 # 8000b2e0 <etext+0x2e0>
    80003e3c:	ffffd097          	auipc	ra,0xffffd
    80003e40:	bec080e7          	jalr	-1044(ra) # 80000a28 <printf>
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80003e44:	00000097          	auipc	ra,0x0
    80003e48:	dba080e7          	jalr	-582(ra) # 80003bfe <r_sepc>
    80003e4c:	84aa                	mv	s1,a0
    80003e4e:	00000097          	auipc	ra,0x0
    80003e52:	e18080e7          	jalr	-488(ra) # 80003c66 <r_stval>
    80003e56:	87aa                	mv	a5,a0
    80003e58:	863e                	mv	a2,a5
    80003e5a:	85a6                	mv	a1,s1
    80003e5c:	00007517          	auipc	a0,0x7
    80003e60:	4b450513          	addi	a0,a0,1204 # 8000b310 <etext+0x310>
    80003e64:	ffffd097          	auipc	ra,0xffffd
    80003e68:	bc4080e7          	jalr	-1084(ra) # 80000a28 <printf>
    p->killed = 1;
    80003e6c:	fd043783          	ld	a5,-48(s0)
    80003e70:	4705                	li	a4,1
    80003e72:	d798                	sw	a4,40(a5)
  }

  if(p->killed)
    80003e74:	fd043783          	ld	a5,-48(s0)
    80003e78:	579c                	lw	a5,40(a5)
    80003e7a:	c791                	beqz	a5,80003e86 <usertrap+0x120>
    exit(-1);
    80003e7c:	557d                	li	a0,-1
    80003e7e:	fffff097          	auipc	ra,0xfffff
    80003e82:	0b2080e7          	jalr	178(ra) # 80002f30 <exit>

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2)
    80003e86:	fdc42783          	lw	a5,-36(s0)
    80003e8a:	0007871b          	sext.w	a4,a5
    80003e8e:	4789                	li	a5,2
    80003e90:	00f71663          	bne	a4,a5,80003e9c <usertrap+0x136>
    yield();
    80003e94:	fffff097          	auipc	ra,0xfffff
    80003e98:	5b2080e7          	jalr	1458(ra) # 80003446 <yield>

  usertrapret();
    80003e9c:	00000097          	auipc	ra,0x0
    80003ea0:	014080e7          	jalr	20(ra) # 80003eb0 <usertrapret>
}
    80003ea4:	0001                	nop
    80003ea6:	70a2                	ld	ra,40(sp)
    80003ea8:	7402                	ld	s0,32(sp)
    80003eaa:	64e2                	ld	s1,24(sp)
    80003eac:	6145                	addi	sp,sp,48
    80003eae:	8082                	ret

0000000080003eb0 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80003eb0:	7139                	addi	sp,sp,-64
    80003eb2:	fc06                	sd	ra,56(sp)
    80003eb4:	f822                	sd	s0,48(sp)
    80003eb6:	f426                	sd	s1,40(sp)
    80003eb8:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80003eba:	fffff097          	auipc	ra,0xfffff
    80003ebe:	95a080e7          	jalr	-1702(ra) # 80002814 <myproc>
    80003ec2:	fca43c23          	sd	a0,-40(s0)

  // we're about to switch the destination of traps from
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();
    80003ec6:	00000097          	auipc	ra,0x0
    80003eca:	de4080e7          	jalr	-540(ra) # 80003caa <intr_off>

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80003ece:	00006717          	auipc	a4,0x6
    80003ed2:	13270713          	addi	a4,a4,306 # 8000a000 <_trampoline>
    80003ed6:	00006797          	auipc	a5,0x6
    80003eda:	12a78793          	addi	a5,a5,298 # 8000a000 <_trampoline>
    80003ede:	8f1d                	sub	a4,a4,a5
    80003ee0:	040007b7          	lui	a5,0x4000
    80003ee4:	17fd                	addi	a5,a5,-1
    80003ee6:	07b2                	slli	a5,a5,0xc
    80003ee8:	97ba                	add	a5,a5,a4
    80003eea:	853e                	mv	a0,a5
    80003eec:	00000097          	auipc	ra,0x0
    80003ef0:	d2c080e7          	jalr	-724(ra) # 80003c18 <w_stvec>

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80003ef4:	fd843783          	ld	a5,-40(s0)
    80003ef8:	73a4                	ld	s1,96(a5)
    80003efa:	00000097          	auipc	ra,0x0
    80003efe:	d38080e7          	jalr	-712(ra) # 80003c32 <r_satp>
    80003f02:	87aa                	mv	a5,a0
    80003f04:	e09c                	sd	a5,0(s1)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80003f06:	fd843783          	ld	a5,-40(s0)
    80003f0a:	67b4                	ld	a3,72(a5)
    80003f0c:	fd843783          	ld	a5,-40(s0)
    80003f10:	73bc                	ld	a5,96(a5)
    80003f12:	6705                	lui	a4,0x1
    80003f14:	9736                	add	a4,a4,a3
    80003f16:	e798                	sd	a4,8(a5)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80003f18:	fd843783          	ld	a5,-40(s0)
    80003f1c:	73bc                	ld	a5,96(a5)
    80003f1e:	00000717          	auipc	a4,0x0
    80003f22:	e4870713          	addi	a4,a4,-440 # 80003d66 <usertrap>
    80003f26:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80003f28:	fd843783          	ld	a5,-40(s0)
    80003f2c:	73a4                	ld	s1,96(a5)
    80003f2e:	00000097          	auipc	ra,0x0
    80003f32:	dd2080e7          	jalr	-558(ra) # 80003d00 <r_tp>
    80003f36:	87aa                	mv	a5,a0
    80003f38:	f09c                	sd	a5,32(s1)

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
    80003f3a:	00000097          	auipc	ra,0x0
    80003f3e:	c42080e7          	jalr	-958(ra) # 80003b7c <r_sstatus>
    80003f42:	fca43823          	sd	a0,-48(s0)
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80003f46:	fd043783          	ld	a5,-48(s0)
    80003f4a:	eff7f793          	andi	a5,a5,-257
    80003f4e:	fcf43823          	sd	a5,-48(s0)
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80003f52:	fd043783          	ld	a5,-48(s0)
    80003f56:	0207e793          	ori	a5,a5,32
    80003f5a:	fcf43823          	sd	a5,-48(s0)
  w_sstatus(x);
    80003f5e:	fd043503          	ld	a0,-48(s0)
    80003f62:	00000097          	auipc	ra,0x0
    80003f66:	c34080e7          	jalr	-972(ra) # 80003b96 <w_sstatus>

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80003f6a:	fd843783          	ld	a5,-40(s0)
    80003f6e:	73bc                	ld	a5,96(a5)
    80003f70:	6f9c                	ld	a5,24(a5)
    80003f72:	853e                	mv	a0,a5
    80003f74:	00000097          	auipc	ra,0x0
    80003f78:	c70080e7          	jalr	-912(ra) # 80003be4 <w_sepc>

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80003f7c:	fd843783          	ld	a5,-40(s0)
    80003f80:	6fbc                	ld	a5,88(a5)
    80003f82:	00c7d713          	srli	a4,a5,0xc
    80003f86:	57fd                	li	a5,-1
    80003f88:	17fe                	slli	a5,a5,0x3f
    80003f8a:	8fd9                	or	a5,a5,a4
    80003f8c:	fcf43423          	sd	a5,-56(s0)

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80003f90:	00006717          	auipc	a4,0x6
    80003f94:	10070713          	addi	a4,a4,256 # 8000a090 <userret>
    80003f98:	00006797          	auipc	a5,0x6
    80003f9c:	06878793          	addi	a5,a5,104 # 8000a000 <_trampoline>
    80003fa0:	8f1d                	sub	a4,a4,a5
    80003fa2:	040007b7          	lui	a5,0x4000
    80003fa6:	17fd                	addi	a5,a5,-1
    80003fa8:	07b2                	slli	a5,a5,0xc
    80003faa:	97ba                	add	a5,a5,a4
    80003fac:	fcf43023          	sd	a5,-64(s0)
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80003fb0:	fc043703          	ld	a4,-64(s0)
    80003fb4:	fc843583          	ld	a1,-56(s0)
    80003fb8:	020007b7          	lui	a5,0x2000
    80003fbc:	17fd                	addi	a5,a5,-1
    80003fbe:	00d79513          	slli	a0,a5,0xd
    80003fc2:	9702                	jalr	a4
}
    80003fc4:	0001                	nop
    80003fc6:	70e2                	ld	ra,56(sp)
    80003fc8:	7442                	ld	s0,48(sp)
    80003fca:	74a2                	ld	s1,40(sp)
    80003fcc:	6121                	addi	sp,sp,64
    80003fce:	8082                	ret

0000000080003fd0 <kerneltrap>:

// interrupts and exceptions from kernel code go here via kernelvec,
// on whatever the current kernel stack is.
void 
kerneltrap()
{
    80003fd0:	7139                	addi	sp,sp,-64
    80003fd2:	fc06                	sd	ra,56(sp)
    80003fd4:	f822                	sd	s0,48(sp)
    80003fd6:	f426                	sd	s1,40(sp)
    80003fd8:	0080                	addi	s0,sp,64
  int which_dev = 0;
    80003fda:	fc042e23          	sw	zero,-36(s0)
  uint64 sepc = r_sepc();
    80003fde:	00000097          	auipc	ra,0x0
    80003fe2:	c20080e7          	jalr	-992(ra) # 80003bfe <r_sepc>
    80003fe6:	fca43823          	sd	a0,-48(s0)
  uint64 sstatus = r_sstatus();
    80003fea:	00000097          	auipc	ra,0x0
    80003fee:	b92080e7          	jalr	-1134(ra) # 80003b7c <r_sstatus>
    80003ff2:	fca43423          	sd	a0,-56(s0)
  uint64 scause = r_scause();
    80003ff6:	00000097          	auipc	ra,0x0
    80003ffa:	c56080e7          	jalr	-938(ra) # 80003c4c <r_scause>
    80003ffe:	fca43023          	sd	a0,-64(s0)
  
  if((sstatus & SSTATUS_SPP) == 0)
    80004002:	fc843783          	ld	a5,-56(s0)
    80004006:	1007f793          	andi	a5,a5,256
    8000400a:	eb89                	bnez	a5,8000401c <kerneltrap+0x4c>
    panic("kerneltrap: not from supervisor mode");
    8000400c:	00007517          	auipc	a0,0x7
    80004010:	32450513          	addi	a0,a0,804 # 8000b330 <etext+0x330>
    80004014:	ffffd097          	auipc	ra,0xffffd
    80004018:	c6a080e7          	jalr	-918(ra) # 80000c7e <panic>
  if(intr_get() != 0)
    8000401c:	00000097          	auipc	ra,0x0
    80004020:	cb6080e7          	jalr	-842(ra) # 80003cd2 <intr_get>
    80004024:	87aa                	mv	a5,a0
    80004026:	cb89                	beqz	a5,80004038 <kerneltrap+0x68>
    panic("kerneltrap: interrupts enabled");
    80004028:	00007517          	auipc	a0,0x7
    8000402c:	33050513          	addi	a0,a0,816 # 8000b358 <etext+0x358>
    80004030:	ffffd097          	auipc	ra,0xffffd
    80004034:	c4e080e7          	jalr	-946(ra) # 80000c7e <panic>

  if((which_dev = devintr()) == 0){
    80004038:	00000097          	auipc	ra,0x0
    8000403c:	118080e7          	jalr	280(ra) # 80004150 <devintr>
    80004040:	87aa                	mv	a5,a0
    80004042:	fcf42e23          	sw	a5,-36(s0)
    80004046:	fdc42783          	lw	a5,-36(s0)
    8000404a:	2781                	sext.w	a5,a5
    8000404c:	e7b9                	bnez	a5,8000409a <kerneltrap+0xca>
    printf("scause %p\n", scause);
    8000404e:	fc043583          	ld	a1,-64(s0)
    80004052:	00007517          	auipc	a0,0x7
    80004056:	32650513          	addi	a0,a0,806 # 8000b378 <etext+0x378>
    8000405a:	ffffd097          	auipc	ra,0xffffd
    8000405e:	9ce080e7          	jalr	-1586(ra) # 80000a28 <printf>
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80004062:	00000097          	auipc	ra,0x0
    80004066:	b9c080e7          	jalr	-1124(ra) # 80003bfe <r_sepc>
    8000406a:	84aa                	mv	s1,a0
    8000406c:	00000097          	auipc	ra,0x0
    80004070:	bfa080e7          	jalr	-1030(ra) # 80003c66 <r_stval>
    80004074:	87aa                	mv	a5,a0
    80004076:	863e                	mv	a2,a5
    80004078:	85a6                	mv	a1,s1
    8000407a:	00007517          	auipc	a0,0x7
    8000407e:	30e50513          	addi	a0,a0,782 # 8000b388 <etext+0x388>
    80004082:	ffffd097          	auipc	ra,0xffffd
    80004086:	9a6080e7          	jalr	-1626(ra) # 80000a28 <printf>
    panic("kerneltrap");
    8000408a:	00007517          	auipc	a0,0x7
    8000408e:	31650513          	addi	a0,a0,790 # 8000b3a0 <etext+0x3a0>
    80004092:	ffffd097          	auipc	ra,0xffffd
    80004096:	bec080e7          	jalr	-1044(ra) # 80000c7e <panic>
  }

  // give up the CPU if this is a timer interrupt.
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000409a:	fdc42783          	lw	a5,-36(s0)
    8000409e:	0007871b          	sext.w	a4,a5
    800040a2:	4789                	li	a5,2
    800040a4:	02f71663          	bne	a4,a5,800040d0 <kerneltrap+0x100>
    800040a8:	ffffe097          	auipc	ra,0xffffe
    800040ac:	76c080e7          	jalr	1900(ra) # 80002814 <myproc>
    800040b0:	87aa                	mv	a5,a0
    800040b2:	cf99                	beqz	a5,800040d0 <kerneltrap+0x100>
    800040b4:	ffffe097          	auipc	ra,0xffffe
    800040b8:	760080e7          	jalr	1888(ra) # 80002814 <myproc>
    800040bc:	87aa                	mv	a5,a0
    800040be:	4f9c                	lw	a5,24(a5)
    800040c0:	873e                	mv	a4,a5
    800040c2:	4791                	li	a5,4
    800040c4:	00f71663          	bne	a4,a5,800040d0 <kerneltrap+0x100>
    yield();
    800040c8:	fffff097          	auipc	ra,0xfffff
    800040cc:	37e080e7          	jalr	894(ra) # 80003446 <yield>

  // the yield() may have caused some traps to occur,
  // so restore trap registers for use by kernelvec.S's sepc instruction.
  w_sepc(sepc);
    800040d0:	fd043503          	ld	a0,-48(s0)
    800040d4:	00000097          	auipc	ra,0x0
    800040d8:	b10080e7          	jalr	-1264(ra) # 80003be4 <w_sepc>
  w_sstatus(sstatus);
    800040dc:	fc843503          	ld	a0,-56(s0)
    800040e0:	00000097          	auipc	ra,0x0
    800040e4:	ab6080e7          	jalr	-1354(ra) # 80003b96 <w_sstatus>
}
    800040e8:	0001                	nop
    800040ea:	70e2                	ld	ra,56(sp)
    800040ec:	7442                	ld	s0,48(sp)
    800040ee:	74a2                	ld	s1,40(sp)
    800040f0:	6121                	addi	sp,sp,64
    800040f2:	8082                	ret

00000000800040f4 <clockintr>:

void
clockintr()
{
    800040f4:	1141                	addi	sp,sp,-16
    800040f6:	e406                	sd	ra,8(sp)
    800040f8:	e022                	sd	s0,0(sp)
    800040fa:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    800040fc:	00016517          	auipc	a0,0x16
    80004100:	1f450513          	addi	a0,a0,500 # 8001a2f0 <tickslock>
    80004104:	ffffd097          	auipc	ra,0xffffd
    80004108:	16a080e7          	jalr	362(ra) # 8000126e <acquire>
  ticks++;
    8000410c:	00008797          	auipc	a5,0x8
    80004110:	f2478793          	addi	a5,a5,-220 # 8000c030 <ticks>
    80004114:	439c                	lw	a5,0(a5)
    80004116:	2785                	addiw	a5,a5,1
    80004118:	0007871b          	sext.w	a4,a5
    8000411c:	00008797          	auipc	a5,0x8
    80004120:	f1478793          	addi	a5,a5,-236 # 8000c030 <ticks>
    80004124:	c398                	sw	a4,0(a5)
  wakeup(&ticks);
    80004126:	00008517          	auipc	a0,0x8
    8000412a:	f0a50513          	addi	a0,a0,-246 # 8000c030 <ticks>
    8000412e:	fffff097          	auipc	ra,0xfffff
    80004132:	476080e7          	jalr	1142(ra) # 800035a4 <wakeup>
  release(&tickslock);
    80004136:	00016517          	auipc	a0,0x16
    8000413a:	1ba50513          	addi	a0,a0,442 # 8001a2f0 <tickslock>
    8000413e:	ffffd097          	auipc	ra,0xffffd
    80004142:	194080e7          	jalr	404(ra) # 800012d2 <release>
}
    80004146:	0001                	nop
    80004148:	60a2                	ld	ra,8(sp)
    8000414a:	6402                	ld	s0,0(sp)
    8000414c:	0141                	addi	sp,sp,16
    8000414e:	8082                	ret

0000000080004150 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80004150:	1101                	addi	sp,sp,-32
    80004152:	ec06                	sd	ra,24(sp)
    80004154:	e822                	sd	s0,16(sp)
    80004156:	1000                	addi	s0,sp,32
  uint64 scause = r_scause();
    80004158:	00000097          	auipc	ra,0x0
    8000415c:	af4080e7          	jalr	-1292(ra) # 80003c4c <r_scause>
    80004160:	fea43423          	sd	a0,-24(s0)

  if((scause & 0x8000000000000000L) &&
    80004164:	fe843783          	ld	a5,-24(s0)
    80004168:	0807d463          	bgez	a5,800041f0 <devintr+0xa0>
     (scause & 0xff) == 9){
    8000416c:	fe843783          	ld	a5,-24(s0)
    80004170:	0ff7f713          	andi	a4,a5,255
  if((scause & 0x8000000000000000L) &&
    80004174:	47a5                	li	a5,9
    80004176:	06f71d63          	bne	a4,a5,800041f0 <devintr+0xa0>
    // this is a supervisor external interrupt, via PLIC.

    // irq indicates which device interrupted.
    int irq = plic_claim();
    8000417a:	00005097          	auipc	ra,0x5
    8000417e:	ad8080e7          	jalr	-1320(ra) # 80008c52 <plic_claim>
    80004182:	87aa                	mv	a5,a0
    80004184:	fef42223          	sw	a5,-28(s0)

    if(irq == UART0_IRQ){
    80004188:	fe442783          	lw	a5,-28(s0)
    8000418c:	0007871b          	sext.w	a4,a5
    80004190:	47a9                	li	a5,10
    80004192:	00f71763          	bne	a4,a5,800041a0 <devintr+0x50>
      uartintr();
    80004196:	ffffd097          	auipc	ra,0xffffd
    8000419a:	de0080e7          	jalr	-544(ra) # 80000f76 <uartintr>
    8000419e:	a825                	j	800041d6 <devintr+0x86>
    } else if(irq == VIRTIO0_IRQ){
    800041a0:	fe442783          	lw	a5,-28(s0)
    800041a4:	0007871b          	sext.w	a4,a5
    800041a8:	4785                	li	a5,1
    800041aa:	00f71763          	bne	a4,a5,800041b8 <devintr+0x68>
      virtio_disk_intr();
    800041ae:	00005097          	auipc	ra,0x5
    800041b2:	3b8080e7          	jalr	952(ra) # 80009566 <virtio_disk_intr>
    800041b6:	a005                	j	800041d6 <devintr+0x86>
    } else if(irq){
    800041b8:	fe442783          	lw	a5,-28(s0)
    800041bc:	2781                	sext.w	a5,a5
    800041be:	cf81                	beqz	a5,800041d6 <devintr+0x86>
      printf("unexpected interrupt irq=%d\n", irq);
    800041c0:	fe442783          	lw	a5,-28(s0)
    800041c4:	85be                	mv	a1,a5
    800041c6:	00007517          	auipc	a0,0x7
    800041ca:	1ea50513          	addi	a0,a0,490 # 8000b3b0 <etext+0x3b0>
    800041ce:	ffffd097          	auipc	ra,0xffffd
    800041d2:	85a080e7          	jalr	-1958(ra) # 80000a28 <printf>
    }

    // the PLIC allows each device to raise at most one
    // interrupt at a time; tell the PLIC the device is
    // now allowed to interrupt again.
    if(irq)
    800041d6:	fe442783          	lw	a5,-28(s0)
    800041da:	2781                	sext.w	a5,a5
    800041dc:	cb81                	beqz	a5,800041ec <devintr+0x9c>
      plic_complete(irq);
    800041de:	fe442783          	lw	a5,-28(s0)
    800041e2:	853e                	mv	a0,a5
    800041e4:	00005097          	auipc	ra,0x5
    800041e8:	aac080e7          	jalr	-1364(ra) # 80008c90 <plic_complete>

    return 1;
    800041ec:	4785                	li	a5,1
    800041ee:	a081                	j	8000422e <devintr+0xde>
  } else if(scause == 0x8000000000000001L){
    800041f0:	fe843703          	ld	a4,-24(s0)
    800041f4:	57fd                	li	a5,-1
    800041f6:	17fe                	slli	a5,a5,0x3f
    800041f8:	0785                	addi	a5,a5,1
    800041fa:	02f71963          	bne	a4,a5,8000422c <devintr+0xdc>
    // software interrupt from a machine-mode timer interrupt,
    // forwarded by timervec in kernelvec.S.

    if(cpuid() == 0){
    800041fe:	ffffe097          	auipc	ra,0xffffe
    80004202:	5b8080e7          	jalr	1464(ra) # 800027b6 <cpuid>
    80004206:	87aa                	mv	a5,a0
    80004208:	e789                	bnez	a5,80004212 <devintr+0xc2>
      clockintr();
    8000420a:	00000097          	auipc	ra,0x0
    8000420e:	eea080e7          	jalr	-278(ra) # 800040f4 <clockintr>
    }
    
    // acknowledge the software interrupt by clearing
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);
    80004212:	00000097          	auipc	ra,0x0
    80004216:	99e080e7          	jalr	-1634(ra) # 80003bb0 <r_sip>
    8000421a:	87aa                	mv	a5,a0
    8000421c:	9bf5                	andi	a5,a5,-3
    8000421e:	853e                	mv	a0,a5
    80004220:	00000097          	auipc	ra,0x0
    80004224:	9aa080e7          	jalr	-1622(ra) # 80003bca <w_sip>

    return 2;
    80004228:	4789                	li	a5,2
    8000422a:	a011                	j	8000422e <devintr+0xde>
  } else {
    return 0;
    8000422c:	4781                	li	a5,0
  }
}
    8000422e:	853e                	mv	a0,a5
    80004230:	60e2                	ld	ra,24(sp)
    80004232:	6442                	ld	s0,16(sp)
    80004234:	6105                	addi	sp,sp,32
    80004236:	8082                	ret

0000000080004238 <fetchaddr>:
#include "defs.h"

// Fetch the uint64 at addr from the current process.
int
fetchaddr(uint64 addr, uint64 *ip)
{
    80004238:	7179                	addi	sp,sp,-48
    8000423a:	f406                	sd	ra,40(sp)
    8000423c:	f022                	sd	s0,32(sp)
    8000423e:	1800                	addi	s0,sp,48
    80004240:	fca43c23          	sd	a0,-40(s0)
    80004244:	fcb43823          	sd	a1,-48(s0)
  struct proc *p = myproc();
    80004248:	ffffe097          	auipc	ra,0xffffe
    8000424c:	5cc080e7          	jalr	1484(ra) # 80002814 <myproc>
    80004250:	fea43423          	sd	a0,-24(s0)
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80004254:	fe843783          	ld	a5,-24(s0)
    80004258:	6bbc                	ld	a5,80(a5)
    8000425a:	fd843703          	ld	a4,-40(s0)
    8000425e:	00f77b63          	bgeu	a4,a5,80004274 <fetchaddr+0x3c>
    80004262:	fd843783          	ld	a5,-40(s0)
    80004266:	00878713          	addi	a4,a5,8
    8000426a:	fe843783          	ld	a5,-24(s0)
    8000426e:	6bbc                	ld	a5,80(a5)
    80004270:	00e7f463          	bgeu	a5,a4,80004278 <fetchaddr+0x40>
    return -1;
    80004274:	57fd                	li	a5,-1
    80004276:	a01d                	j	8000429c <fetchaddr+0x64>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80004278:	fe843783          	ld	a5,-24(s0)
    8000427c:	6fbc                	ld	a5,88(a5)
    8000427e:	46a1                	li	a3,8
    80004280:	fd843603          	ld	a2,-40(s0)
    80004284:	fd043583          	ld	a1,-48(s0)
    80004288:	853e                	mv	a0,a5
    8000428a:	ffffe097          	auipc	ra,0xffffe
    8000428e:	12a080e7          	jalr	298(ra) # 800023b4 <copyin>
    80004292:	87aa                	mv	a5,a0
    80004294:	c399                	beqz	a5,8000429a <fetchaddr+0x62>
    return -1;
    80004296:	57fd                	li	a5,-1
    80004298:	a011                	j	8000429c <fetchaddr+0x64>
  return 0;
    8000429a:	4781                	li	a5,0
}
    8000429c:	853e                	mv	a0,a5
    8000429e:	70a2                	ld	ra,40(sp)
    800042a0:	7402                	ld	s0,32(sp)
    800042a2:	6145                	addi	sp,sp,48
    800042a4:	8082                	ret

00000000800042a6 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Returns length of string, not including nul, or -1 for error.
int
fetchstr(uint64 addr, char *buf, int max)
{
    800042a6:	7139                	addi	sp,sp,-64
    800042a8:	fc06                	sd	ra,56(sp)
    800042aa:	f822                	sd	s0,48(sp)
    800042ac:	0080                	addi	s0,sp,64
    800042ae:	fca43c23          	sd	a0,-40(s0)
    800042b2:	fcb43823          	sd	a1,-48(s0)
    800042b6:	87b2                	mv	a5,a2
    800042b8:	fcf42623          	sw	a5,-52(s0)
  struct proc *p = myproc();
    800042bc:	ffffe097          	auipc	ra,0xffffe
    800042c0:	558080e7          	jalr	1368(ra) # 80002814 <myproc>
    800042c4:	fea43423          	sd	a0,-24(s0)
  int err = copyinstr(p->pagetable, buf, addr, max);
    800042c8:	fe843783          	ld	a5,-24(s0)
    800042cc:	6fbc                	ld	a5,88(a5)
    800042ce:	fcc42703          	lw	a4,-52(s0)
    800042d2:	86ba                	mv	a3,a4
    800042d4:	fd843603          	ld	a2,-40(s0)
    800042d8:	fd043583          	ld	a1,-48(s0)
    800042dc:	853e                	mv	a0,a5
    800042de:	ffffe097          	auipc	ra,0xffffe
    800042e2:	1a4080e7          	jalr	420(ra) # 80002482 <copyinstr>
    800042e6:	87aa                	mv	a5,a0
    800042e8:	fef42223          	sw	a5,-28(s0)
  if(err < 0)
    800042ec:	fe442783          	lw	a5,-28(s0)
    800042f0:	2781                	sext.w	a5,a5
    800042f2:	0007d563          	bgez	a5,800042fc <fetchstr+0x56>
    return err;
    800042f6:	fe442783          	lw	a5,-28(s0)
    800042fa:	a801                	j	8000430a <fetchstr+0x64>
  return strlen(buf);
    800042fc:	fd043503          	ld	a0,-48(s0)
    80004300:	ffffd097          	auipc	ra,0xffffd
    80004304:	4c0080e7          	jalr	1216(ra) # 800017c0 <strlen>
    80004308:	87aa                	mv	a5,a0
}
    8000430a:	853e                	mv	a0,a5
    8000430c:	70e2                	ld	ra,56(sp)
    8000430e:	7442                	ld	s0,48(sp)
    80004310:	6121                	addi	sp,sp,64
    80004312:	8082                	ret

0000000080004314 <argraw>:

static uint64
argraw(int n)
{
    80004314:	7179                	addi	sp,sp,-48
    80004316:	f406                	sd	ra,40(sp)
    80004318:	f022                	sd	s0,32(sp)
    8000431a:	1800                	addi	s0,sp,48
    8000431c:	87aa                	mv	a5,a0
    8000431e:	fcf42e23          	sw	a5,-36(s0)
  struct proc *p = myproc();
    80004322:	ffffe097          	auipc	ra,0xffffe
    80004326:	4f2080e7          	jalr	1266(ra) # 80002814 <myproc>
    8000432a:	fea43423          	sd	a0,-24(s0)
    8000432e:	fdc42783          	lw	a5,-36(s0)
    80004332:	0007871b          	sext.w	a4,a5
    80004336:	4795                	li	a5,5
    80004338:	06e7e263          	bltu	a5,a4,8000439c <argraw+0x88>
    8000433c:	fdc46783          	lwu	a5,-36(s0)
    80004340:	00279713          	slli	a4,a5,0x2
    80004344:	00007797          	auipc	a5,0x7
    80004348:	09478793          	addi	a5,a5,148 # 8000b3d8 <etext+0x3d8>
    8000434c:	97ba                	add	a5,a5,a4
    8000434e:	439c                	lw	a5,0(a5)
    80004350:	0007871b          	sext.w	a4,a5
    80004354:	00007797          	auipc	a5,0x7
    80004358:	08478793          	addi	a5,a5,132 # 8000b3d8 <etext+0x3d8>
    8000435c:	97ba                	add	a5,a5,a4
    8000435e:	8782                	jr	a5
  switch (n) {
  case 0:
    return p->trapframe->a0;
    80004360:	fe843783          	ld	a5,-24(s0)
    80004364:	73bc                	ld	a5,96(a5)
    80004366:	7bbc                	ld	a5,112(a5)
    80004368:	a091                	j	800043ac <argraw+0x98>
  case 1:
    return p->trapframe->a1;
    8000436a:	fe843783          	ld	a5,-24(s0)
    8000436e:	73bc                	ld	a5,96(a5)
    80004370:	7fbc                	ld	a5,120(a5)
    80004372:	a82d                	j	800043ac <argraw+0x98>
  case 2:
    return p->trapframe->a2;
    80004374:	fe843783          	ld	a5,-24(s0)
    80004378:	73bc                	ld	a5,96(a5)
    8000437a:	63dc                	ld	a5,128(a5)
    8000437c:	a805                	j	800043ac <argraw+0x98>
  case 3:
    return p->trapframe->a3;
    8000437e:	fe843783          	ld	a5,-24(s0)
    80004382:	73bc                	ld	a5,96(a5)
    80004384:	67dc                	ld	a5,136(a5)
    80004386:	a01d                	j	800043ac <argraw+0x98>
  case 4:
    return p->trapframe->a4;
    80004388:	fe843783          	ld	a5,-24(s0)
    8000438c:	73bc                	ld	a5,96(a5)
    8000438e:	6bdc                	ld	a5,144(a5)
    80004390:	a831                	j	800043ac <argraw+0x98>
  case 5:
    return p->trapframe->a5;
    80004392:	fe843783          	ld	a5,-24(s0)
    80004396:	73bc                	ld	a5,96(a5)
    80004398:	6fdc                	ld	a5,152(a5)
    8000439a:	a809                	j	800043ac <argraw+0x98>
  }
  panic("argraw");
    8000439c:	00007517          	auipc	a0,0x7
    800043a0:	03450513          	addi	a0,a0,52 # 8000b3d0 <etext+0x3d0>
    800043a4:	ffffd097          	auipc	ra,0xffffd
    800043a8:	8da080e7          	jalr	-1830(ra) # 80000c7e <panic>
  return -1;
}
    800043ac:	853e                	mv	a0,a5
    800043ae:	70a2                	ld	ra,40(sp)
    800043b0:	7402                	ld	s0,32(sp)
    800043b2:	6145                	addi	sp,sp,48
    800043b4:	8082                	ret

00000000800043b6 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    800043b6:	1101                	addi	sp,sp,-32
    800043b8:	ec06                	sd	ra,24(sp)
    800043ba:	e822                	sd	s0,16(sp)
    800043bc:	1000                	addi	s0,sp,32
    800043be:	87aa                	mv	a5,a0
    800043c0:	feb43023          	sd	a1,-32(s0)
    800043c4:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    800043c8:	fec42783          	lw	a5,-20(s0)
    800043cc:	853e                	mv	a0,a5
    800043ce:	00000097          	auipc	ra,0x0
    800043d2:	f46080e7          	jalr	-186(ra) # 80004314 <argraw>
    800043d6:	87aa                	mv	a5,a0
    800043d8:	0007871b          	sext.w	a4,a5
    800043dc:	fe043783          	ld	a5,-32(s0)
    800043e0:	c398                	sw	a4,0(a5)
  return 0;
    800043e2:	4781                	li	a5,0
}
    800043e4:	853e                	mv	a0,a5
    800043e6:	60e2                	ld	ra,24(sp)
    800043e8:	6442                	ld	s0,16(sp)
    800043ea:	6105                	addi	sp,sp,32
    800043ec:	8082                	ret

00000000800043ee <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    800043ee:	1101                	addi	sp,sp,-32
    800043f0:	ec06                	sd	ra,24(sp)
    800043f2:	e822                	sd	s0,16(sp)
    800043f4:	1000                	addi	s0,sp,32
    800043f6:	87aa                	mv	a5,a0
    800043f8:	feb43023          	sd	a1,-32(s0)
    800043fc:	fef42623          	sw	a5,-20(s0)
  *ip = argraw(n);
    80004400:	fec42783          	lw	a5,-20(s0)
    80004404:	853e                	mv	a0,a5
    80004406:	00000097          	auipc	ra,0x0
    8000440a:	f0e080e7          	jalr	-242(ra) # 80004314 <argraw>
    8000440e:	872a                	mv	a4,a0
    80004410:	fe043783          	ld	a5,-32(s0)
    80004414:	e398                	sd	a4,0(a5)
  return 0;
    80004416:	4781                	li	a5,0
}
    80004418:	853e                	mv	a0,a5
    8000441a:	60e2                	ld	ra,24(sp)
    8000441c:	6442                	ld	s0,16(sp)
    8000441e:	6105                	addi	sp,sp,32
    80004420:	8082                	ret

0000000080004422 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80004422:	7179                	addi	sp,sp,-48
    80004424:	f406                	sd	ra,40(sp)
    80004426:	f022                	sd	s0,32(sp)
    80004428:	1800                	addi	s0,sp,48
    8000442a:	87aa                	mv	a5,a0
    8000442c:	fcb43823          	sd	a1,-48(s0)
    80004430:	8732                	mv	a4,a2
    80004432:	fcf42e23          	sw	a5,-36(s0)
    80004436:	87ba                	mv	a5,a4
    80004438:	fcf42c23          	sw	a5,-40(s0)
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    8000443c:	fe840713          	addi	a4,s0,-24
    80004440:	fdc42783          	lw	a5,-36(s0)
    80004444:	85ba                	mv	a1,a4
    80004446:	853e                	mv	a0,a5
    80004448:	00000097          	auipc	ra,0x0
    8000444c:	fa6080e7          	jalr	-90(ra) # 800043ee <argaddr>
    80004450:	87aa                	mv	a5,a0
    80004452:	0007d463          	bgez	a5,8000445a <argstr+0x38>
    return -1;
    80004456:	57fd                	li	a5,-1
    80004458:	a831                	j	80004474 <argstr+0x52>
  return fetchstr(addr, buf, max);
    8000445a:	fe843783          	ld	a5,-24(s0)
    8000445e:	fd842703          	lw	a4,-40(s0)
    80004462:	863a                	mv	a2,a4
    80004464:	fd043583          	ld	a1,-48(s0)
    80004468:	853e                	mv	a0,a5
    8000446a:	00000097          	auipc	ra,0x0
    8000446e:	e3c080e7          	jalr	-452(ra) # 800042a6 <fetchstr>
    80004472:	87aa                	mv	a5,a0
}
    80004474:	853e                	mv	a0,a5
    80004476:	70a2                	ld	ra,40(sp)
    80004478:	7402                	ld	s0,32(sp)
    8000447a:	6145                	addi	sp,sp,48
    8000447c:	8082                	ret

000000008000447e <syscall>:
[SYS_setpri]  sys_setpri
};

void
syscall(void)
{
    8000447e:	7179                	addi	sp,sp,-48
    80004480:	f406                	sd	ra,40(sp)
    80004482:	f022                	sd	s0,32(sp)
    80004484:	ec26                	sd	s1,24(sp)
    80004486:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80004488:	ffffe097          	auipc	ra,0xffffe
    8000448c:	38c080e7          	jalr	908(ra) # 80002814 <myproc>
    80004490:	fca43c23          	sd	a0,-40(s0)

  num = p->trapframe->a7;
    80004494:	fd843783          	ld	a5,-40(s0)
    80004498:	73bc                	ld	a5,96(a5)
    8000449a:	77dc                	ld	a5,168(a5)
    8000449c:	fcf42a23          	sw	a5,-44(s0)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    800044a0:	fd442783          	lw	a5,-44(s0)
    800044a4:	2781                	sext.w	a5,a5
    800044a6:	04f05263          	blez	a5,800044ea <syscall+0x6c>
    800044aa:	fd442783          	lw	a5,-44(s0)
    800044ae:	873e                	mv	a4,a5
    800044b0:	47dd                	li	a5,23
    800044b2:	02e7ec63          	bltu	a5,a4,800044ea <syscall+0x6c>
    800044b6:	00007717          	auipc	a4,0x7
    800044ba:	30a70713          	addi	a4,a4,778 # 8000b7c0 <syscalls>
    800044be:	fd442783          	lw	a5,-44(s0)
    800044c2:	078e                	slli	a5,a5,0x3
    800044c4:	97ba                	add	a5,a5,a4
    800044c6:	639c                	ld	a5,0(a5)
    800044c8:	c38d                	beqz	a5,800044ea <syscall+0x6c>
    p->trapframe->a0 = syscalls[num]();
    800044ca:	00007717          	auipc	a4,0x7
    800044ce:	2f670713          	addi	a4,a4,758 # 8000b7c0 <syscalls>
    800044d2:	fd442783          	lw	a5,-44(s0)
    800044d6:	078e                	slli	a5,a5,0x3
    800044d8:	97ba                	add	a5,a5,a4
    800044da:	6398                	ld	a4,0(a5)
    800044dc:	fd843783          	ld	a5,-40(s0)
    800044e0:	73a4                	ld	s1,96(a5)
    800044e2:	9702                	jalr	a4
    800044e4:	87aa                	mv	a5,a0
    800044e6:	f8bc                	sd	a5,112(s1)
    800044e8:	a815                	j	8000451c <syscall+0x9e>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800044ea:	fd843783          	ld	a5,-40(s0)
    800044ee:	5b98                	lw	a4,48(a5)
            p->pid, p->name, num);
    800044f0:	fd843783          	ld	a5,-40(s0)
    800044f4:	16078793          	addi	a5,a5,352
    printf("%d %s: unknown sys call %d\n",
    800044f8:	fd442683          	lw	a3,-44(s0)
    800044fc:	863e                	mv	a2,a5
    800044fe:	85ba                	mv	a1,a4
    80004500:	00007517          	auipc	a0,0x7
    80004504:	ef050513          	addi	a0,a0,-272 # 8000b3f0 <etext+0x3f0>
    80004508:	ffffc097          	auipc	ra,0xffffc
    8000450c:	520080e7          	jalr	1312(ra) # 80000a28 <printf>
    p->trapframe->a0 = -1;
    80004510:	fd843783          	ld	a5,-40(s0)
    80004514:	73bc                	ld	a5,96(a5)
    80004516:	577d                	li	a4,-1
    80004518:	fbb8                	sd	a4,112(a5)
  }
}
    8000451a:	0001                	nop
    8000451c:	0001                	nop
    8000451e:	70a2                	ld	ra,40(sp)
    80004520:	7402                	ld	s0,32(sp)
    80004522:	64e2                	ld	s1,24(sp)
    80004524:	6145                	addi	sp,sp,48
    80004526:	8082                	ret

0000000080004528 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80004528:	1101                	addi	sp,sp,-32
    8000452a:	ec06                	sd	ra,24(sp)
    8000452c:	e822                	sd	s0,16(sp)
    8000452e:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80004530:	fec40793          	addi	a5,s0,-20
    80004534:	85be                	mv	a1,a5
    80004536:	4501                	li	a0,0
    80004538:	00000097          	auipc	ra,0x0
    8000453c:	e7e080e7          	jalr	-386(ra) # 800043b6 <argint>
    80004540:	87aa                	mv	a5,a0
    80004542:	0007d463          	bgez	a5,8000454a <sys_exit+0x22>
    return -1;
    80004546:	57fd                	li	a5,-1
    80004548:	a809                	j	8000455a <sys_exit+0x32>
  exit(n);
    8000454a:	fec42783          	lw	a5,-20(s0)
    8000454e:	853e                	mv	a0,a5
    80004550:	fffff097          	auipc	ra,0xfffff
    80004554:	9e0080e7          	jalr	-1568(ra) # 80002f30 <exit>
  return 0;  // not reached
    80004558:	4781                	li	a5,0
}
    8000455a:	853e                	mv	a0,a5
    8000455c:	60e2                	ld	ra,24(sp)
    8000455e:	6442                	ld	s0,16(sp)
    80004560:	6105                	addi	sp,sp,32
    80004562:	8082                	ret

0000000080004564 <sys_getpinfo>:


uint64
sys_getpinfo(void)
{
    80004564:	1101                	addi	sp,sp,-32
    80004566:	ec06                	sd	ra,24(sp)
    80004568:	e822                	sd	s0,16(sp)
    8000456a:	1000                	addi	s0,sp,32
  uint64 ps;

  //obtenemos puntero
  if (argaddr(0, &ps) < 0){
    8000456c:	fe840793          	addi	a5,s0,-24
    80004570:	85be                	mv	a1,a5
    80004572:	4501                	li	a0,0
    80004574:	00000097          	auipc	ra,0x0
    80004578:	e7a080e7          	jalr	-390(ra) # 800043ee <argaddr>
    8000457c:	87aa                	mv	a5,a0
    8000457e:	0007d463          	bgez	a5,80004586 <sys_getpinfo+0x22>
    return -1;
    80004582:	57fd                	li	a5,-1
    80004584:	a831                	j	800045a0 <sys_getpinfo+0x3c>
  }

  if (ps == (uint64)null){ 
    80004586:	fe843783          	ld	a5,-24(s0)
    8000458a:	e399                	bnez	a5,80004590 <sys_getpinfo+0x2c>
    return -1;
    8000458c:	57fd                	li	a5,-1
    8000458e:	a809                	j	800045a0 <sys_getpinfo+0x3c>
  }

  return  getpinfo (ps);
    80004590:	fe843783          	ld	a5,-24(s0)
    80004594:	853e                	mv	a0,a5
    80004596:	fffff097          	auipc	ra,0xfffff
    8000459a:	354080e7          	jalr	852(ra) # 800038ea <getpinfo>
    8000459e:	87aa                	mv	a5,a0
}
    800045a0:	853e                	mv	a0,a5
    800045a2:	60e2                	ld	ra,24(sp)
    800045a4:	6442                	ld	s0,16(sp)
    800045a6:	6105                	addi	sp,sp,32
    800045a8:	8082                	ret

00000000800045aa <sys_setpri>:


uint64
sys_setpri(void)
{
    800045aa:	1101                	addi	sp,sp,-32
    800045ac:	ec06                	sd	ra,24(sp)
    800045ae:	e822                	sd	s0,16(sp)
    800045b0:	1000                	addi	s0,sp,32
  int num;

  //obtenemos entero
  if(argint(0, &num) < 0){
    800045b2:	fec40793          	addi	a5,s0,-20
    800045b6:	85be                	mv	a1,a5
    800045b8:	4501                	li	a0,0
    800045ba:	00000097          	auipc	ra,0x0
    800045be:	dfc080e7          	jalr	-516(ra) # 800043b6 <argint>
    800045c2:	87aa                	mv	a5,a0
    800045c4:	0007d463          	bgez	a5,800045cc <sys_setpri+0x22>
    return -1;
    800045c8:	57fd                	li	a5,-1
    800045ca:	a02d                	j	800045f4 <sys_setpri+0x4a>
  }

  if (num < 1 || num > 2){
    800045cc:	fec42783          	lw	a5,-20(s0)
    800045d0:	00f05863          	blez	a5,800045e0 <sys_setpri+0x36>
    800045d4:	fec42783          	lw	a5,-20(s0)
    800045d8:	873e                	mv	a4,a5
    800045da:	4789                	li	a5,2
    800045dc:	00e7d463          	bge	a5,a4,800045e4 <sys_setpri+0x3a>
    return -1;
    800045e0:	57fd                	li	a5,-1
    800045e2:	a809                	j	800045f4 <sys_setpri+0x4a>
  }

  return setpri(num); 
    800045e4:	fec42783          	lw	a5,-20(s0)
    800045e8:	853e                	mv	a0,a5
    800045ea:	fffff097          	auipc	ra,0xfffff
    800045ee:	454080e7          	jalr	1108(ra) # 80003a3e <setpri>
    800045f2:	87aa                	mv	a5,a0
}
    800045f4:	853e                	mv	a0,a5
    800045f6:	60e2                	ld	ra,24(sp)
    800045f8:	6442                	ld	s0,16(sp)
    800045fa:	6105                	addi	sp,sp,32
    800045fc:	8082                	ret

00000000800045fe <sys_getpid>:


uint64
sys_getpid(void)
{
    800045fe:	1141                	addi	sp,sp,-16
    80004600:	e406                	sd	ra,8(sp)
    80004602:	e022                	sd	s0,0(sp)
    80004604:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80004606:	ffffe097          	auipc	ra,0xffffe
    8000460a:	20e080e7          	jalr	526(ra) # 80002814 <myproc>
    8000460e:	87aa                	mv	a5,a0
    80004610:	5b9c                	lw	a5,48(a5)
}
    80004612:	853e                	mv	a0,a5
    80004614:	60a2                	ld	ra,8(sp)
    80004616:	6402                	ld	s0,0(sp)
    80004618:	0141                	addi	sp,sp,16
    8000461a:	8082                	ret

000000008000461c <sys_fork>:

uint64
sys_fork(void)
{
    8000461c:	1141                	addi	sp,sp,-16
    8000461e:	e406                	sd	ra,8(sp)
    80004620:	e022                	sd	s0,0(sp)
    80004622:	0800                	addi	s0,sp,16
  return fork();
    80004624:	ffffe097          	auipc	ra,0xffffe
    80004628:	6ea080e7          	jalr	1770(ra) # 80002d0e <fork>
    8000462c:	87aa                	mv	a5,a0
}
    8000462e:	853e                	mv	a0,a5
    80004630:	60a2                	ld	ra,8(sp)
    80004632:	6402                	ld	s0,0(sp)
    80004634:	0141                	addi	sp,sp,16
    80004636:	8082                	ret

0000000080004638 <sys_wait>:

uint64
sys_wait(void)
{
    80004638:	1101                	addi	sp,sp,-32
    8000463a:	ec06                	sd	ra,24(sp)
    8000463c:	e822                	sd	s0,16(sp)
    8000463e:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80004640:	fe840793          	addi	a5,s0,-24
    80004644:	85be                	mv	a1,a5
    80004646:	4501                	li	a0,0
    80004648:	00000097          	auipc	ra,0x0
    8000464c:	da6080e7          	jalr	-602(ra) # 800043ee <argaddr>
    80004650:	87aa                	mv	a5,a0
    80004652:	0007d463          	bgez	a5,8000465a <sys_wait+0x22>
    return -1;
    80004656:	57fd                	li	a5,-1
    80004658:	a809                	j	8000466a <sys_wait+0x32>
  return wait(p);
    8000465a:	fe843783          	ld	a5,-24(s0)
    8000465e:	853e                	mv	a0,a5
    80004660:	fffff097          	auipc	ra,0xfffff
    80004664:	a6e080e7          	jalr	-1426(ra) # 800030ce <wait>
    80004668:	87aa                	mv	a5,a0
}
    8000466a:	853e                	mv	a0,a5
    8000466c:	60e2                	ld	ra,24(sp)
    8000466e:	6442                	ld	s0,16(sp)
    80004670:	6105                	addi	sp,sp,32
    80004672:	8082                	ret

0000000080004674 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80004674:	1101                	addi	sp,sp,-32
    80004676:	ec06                	sd	ra,24(sp)
    80004678:	e822                	sd	s0,16(sp)
    8000467a:	1000                	addi	s0,sp,32
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8000467c:	fe840793          	addi	a5,s0,-24
    80004680:	85be                	mv	a1,a5
    80004682:	4501                	li	a0,0
    80004684:	00000097          	auipc	ra,0x0
    80004688:	d32080e7          	jalr	-718(ra) # 800043b6 <argint>
    8000468c:	87aa                	mv	a5,a0
    8000468e:	0007d463          	bgez	a5,80004696 <sys_sbrk+0x22>
    return -1;
    80004692:	57fd                	li	a5,-1
    80004694:	a03d                	j	800046c2 <sys_sbrk+0x4e>
  addr = myproc()->sz;
    80004696:	ffffe097          	auipc	ra,0xffffe
    8000469a:	17e080e7          	jalr	382(ra) # 80002814 <myproc>
    8000469e:	87aa                	mv	a5,a0
    800046a0:	6bbc                	ld	a5,80(a5)
    800046a2:	fef42623          	sw	a5,-20(s0)
  if(growproc(n) < 0)
    800046a6:	fe842783          	lw	a5,-24(s0)
    800046aa:	853e                	mv	a0,a5
    800046ac:	ffffe097          	auipc	ra,0xffffe
    800046b0:	5b0080e7          	jalr	1456(ra) # 80002c5c <growproc>
    800046b4:	87aa                	mv	a5,a0
    800046b6:	0007d463          	bgez	a5,800046be <sys_sbrk+0x4a>
    return -1;
    800046ba:	57fd                	li	a5,-1
    800046bc:	a019                	j	800046c2 <sys_sbrk+0x4e>
  return addr;
    800046be:	fec42783          	lw	a5,-20(s0)
}
    800046c2:	853e                	mv	a0,a5
    800046c4:	60e2                	ld	ra,24(sp)
    800046c6:	6442                	ld	s0,16(sp)
    800046c8:	6105                	addi	sp,sp,32
    800046ca:	8082                	ret

00000000800046cc <sys_sleep>:

uint64
sys_sleep(void)
{
    800046cc:	1101                	addi	sp,sp,-32
    800046ce:	ec06                	sd	ra,24(sp)
    800046d0:	e822                	sd	s0,16(sp)
    800046d2:	1000                	addi	s0,sp,32
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800046d4:	fe840793          	addi	a5,s0,-24
    800046d8:	85be                	mv	a1,a5
    800046da:	4501                	li	a0,0
    800046dc:	00000097          	auipc	ra,0x0
    800046e0:	cda080e7          	jalr	-806(ra) # 800043b6 <argint>
    800046e4:	87aa                	mv	a5,a0
    800046e6:	0007d463          	bgez	a5,800046ee <sys_sleep+0x22>
    return -1;
    800046ea:	57fd                	li	a5,-1
    800046ec:	a079                	j	8000477a <sys_sleep+0xae>
  acquire(&tickslock);
    800046ee:	00016517          	auipc	a0,0x16
    800046f2:	c0250513          	addi	a0,a0,-1022 # 8001a2f0 <tickslock>
    800046f6:	ffffd097          	auipc	ra,0xffffd
    800046fa:	b78080e7          	jalr	-1160(ra) # 8000126e <acquire>
  ticks0 = ticks;
    800046fe:	00008797          	auipc	a5,0x8
    80004702:	93278793          	addi	a5,a5,-1742 # 8000c030 <ticks>
    80004706:	439c                	lw	a5,0(a5)
    80004708:	fef42623          	sw	a5,-20(s0)
  while(ticks - ticks0 < n){
    8000470c:	a835                	j	80004748 <sys_sleep+0x7c>
    if(myproc()->killed){
    8000470e:	ffffe097          	auipc	ra,0xffffe
    80004712:	106080e7          	jalr	262(ra) # 80002814 <myproc>
    80004716:	87aa                	mv	a5,a0
    80004718:	579c                	lw	a5,40(a5)
    8000471a:	cb99                	beqz	a5,80004730 <sys_sleep+0x64>
      release(&tickslock);
    8000471c:	00016517          	auipc	a0,0x16
    80004720:	bd450513          	addi	a0,a0,-1068 # 8001a2f0 <tickslock>
    80004724:	ffffd097          	auipc	ra,0xffffd
    80004728:	bae080e7          	jalr	-1106(ra) # 800012d2 <release>
      return -1;
    8000472c:	57fd                	li	a5,-1
    8000472e:	a0b1                	j	8000477a <sys_sleep+0xae>
    }
    sleep(&ticks, &tickslock);
    80004730:	00016597          	auipc	a1,0x16
    80004734:	bc058593          	addi	a1,a1,-1088 # 8001a2f0 <tickslock>
    80004738:	00008517          	auipc	a0,0x8
    8000473c:	8f850513          	addi	a0,a0,-1800 # 8000c030 <ticks>
    80004740:	fffff097          	auipc	ra,0xfffff
    80004744:	da0080e7          	jalr	-608(ra) # 800034e0 <sleep>
  while(ticks - ticks0 < n){
    80004748:	00008797          	auipc	a5,0x8
    8000474c:	8e878793          	addi	a5,a5,-1816 # 8000c030 <ticks>
    80004750:	4398                	lw	a4,0(a5)
    80004752:	fec42783          	lw	a5,-20(s0)
    80004756:	40f707bb          	subw	a5,a4,a5
    8000475a:	0007871b          	sext.w	a4,a5
    8000475e:	fe842783          	lw	a5,-24(s0)
    80004762:	2781                	sext.w	a5,a5
    80004764:	faf765e3          	bltu	a4,a5,8000470e <sys_sleep+0x42>
  }
  release(&tickslock);
    80004768:	00016517          	auipc	a0,0x16
    8000476c:	b8850513          	addi	a0,a0,-1144 # 8001a2f0 <tickslock>
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	b62080e7          	jalr	-1182(ra) # 800012d2 <release>
  return 0;
    80004778:	4781                	li	a5,0
}
    8000477a:	853e                	mv	a0,a5
    8000477c:	60e2                	ld	ra,24(sp)
    8000477e:	6442                	ld	s0,16(sp)
    80004780:	6105                	addi	sp,sp,32
    80004782:	8082                	ret

0000000080004784 <sys_kill>:

uint64
sys_kill(void)
{
    80004784:	1101                	addi	sp,sp,-32
    80004786:	ec06                	sd	ra,24(sp)
    80004788:	e822                	sd	s0,16(sp)
    8000478a:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    8000478c:	fec40793          	addi	a5,s0,-20
    80004790:	85be                	mv	a1,a5
    80004792:	4501                	li	a0,0
    80004794:	00000097          	auipc	ra,0x0
    80004798:	c22080e7          	jalr	-990(ra) # 800043b6 <argint>
    8000479c:	87aa                	mv	a5,a0
    8000479e:	0007d463          	bgez	a5,800047a6 <sys_kill+0x22>
    return -1;
    800047a2:	57fd                	li	a5,-1
    800047a4:	a809                	j	800047b6 <sys_kill+0x32>
  return kill(pid);
    800047a6:	fec42783          	lw	a5,-20(s0)
    800047aa:	853e                	mv	a0,a5
    800047ac:	fffff097          	auipc	ra,0xfffff
    800047b0:	ed4080e7          	jalr	-300(ra) # 80003680 <kill>
    800047b4:	87aa                	mv	a5,a0
}
    800047b6:	853e                	mv	a0,a5
    800047b8:	60e2                	ld	ra,24(sp)
    800047ba:	6442                	ld	s0,16(sp)
    800047bc:	6105                	addi	sp,sp,32
    800047be:	8082                	ret

00000000800047c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800047c0:	1101                	addi	sp,sp,-32
    800047c2:	ec06                	sd	ra,24(sp)
    800047c4:	e822                	sd	s0,16(sp)
    800047c6:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800047c8:	00016517          	auipc	a0,0x16
    800047cc:	b2850513          	addi	a0,a0,-1240 # 8001a2f0 <tickslock>
    800047d0:	ffffd097          	auipc	ra,0xffffd
    800047d4:	a9e080e7          	jalr	-1378(ra) # 8000126e <acquire>
  xticks = ticks;
    800047d8:	00008797          	auipc	a5,0x8
    800047dc:	85878793          	addi	a5,a5,-1960 # 8000c030 <ticks>
    800047e0:	439c                	lw	a5,0(a5)
    800047e2:	fef42623          	sw	a5,-20(s0)
  release(&tickslock);
    800047e6:	00016517          	auipc	a0,0x16
    800047ea:	b0a50513          	addi	a0,a0,-1270 # 8001a2f0 <tickslock>
    800047ee:	ffffd097          	auipc	ra,0xffffd
    800047f2:	ae4080e7          	jalr	-1308(ra) # 800012d2 <release>
  return xticks;
    800047f6:	fec46783          	lwu	a5,-20(s0)
}
    800047fa:	853e                	mv	a0,a5
    800047fc:	60e2                	ld	ra,24(sp)
    800047fe:	6442                	ld	s0,16(sp)
    80004800:	6105                	addi	sp,sp,32
    80004802:	8082                	ret

0000000080004804 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80004804:	1101                	addi	sp,sp,-32
    80004806:	ec06                	sd	ra,24(sp)
    80004808:	e822                	sd	s0,16(sp)
    8000480a:	1000                	addi	s0,sp,32
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000480c:	00007597          	auipc	a1,0x7
    80004810:	c0458593          	addi	a1,a1,-1020 # 8000b410 <etext+0x410>
    80004814:	00016517          	auipc	a0,0x16
    80004818:	af450513          	addi	a0,a0,-1292 # 8001a308 <bcache>
    8000481c:	ffffd097          	auipc	ra,0xffffd
    80004820:	a22080e7          	jalr	-1502(ra) # 8000123e <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80004824:	00016717          	auipc	a4,0x16
    80004828:	ae470713          	addi	a4,a4,-1308 # 8001a308 <bcache>
    8000482c:	67a1                	lui	a5,0x8
    8000482e:	97ba                	add	a5,a5,a4
    80004830:	0001e717          	auipc	a4,0x1e
    80004834:	d4070713          	addi	a4,a4,-704 # 80022570 <bcache+0x8268>
    80004838:	2ae7b823          	sd	a4,688(a5) # 82b0 <_entry-0x7fff7d50>
  bcache.head.next = &bcache.head;
    8000483c:	00016717          	auipc	a4,0x16
    80004840:	acc70713          	addi	a4,a4,-1332 # 8001a308 <bcache>
    80004844:	67a1                	lui	a5,0x8
    80004846:	97ba                	add	a5,a5,a4
    80004848:	0001e717          	auipc	a4,0x1e
    8000484c:	d2870713          	addi	a4,a4,-728 # 80022570 <bcache+0x8268>
    80004850:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80004854:	00016797          	auipc	a5,0x16
    80004858:	acc78793          	addi	a5,a5,-1332 # 8001a320 <bcache+0x18>
    8000485c:	fef43423          	sd	a5,-24(s0)
    80004860:	a895                	j	800048d4 <binit+0xd0>
    b->next = bcache.head.next;
    80004862:	00016717          	auipc	a4,0x16
    80004866:	aa670713          	addi	a4,a4,-1370 # 8001a308 <bcache>
    8000486a:	67a1                	lui	a5,0x8
    8000486c:	97ba                	add	a5,a5,a4
    8000486e:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004872:	fe843783          	ld	a5,-24(s0)
    80004876:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004878:	fe843783          	ld	a5,-24(s0)
    8000487c:	0001e717          	auipc	a4,0x1e
    80004880:	cf470713          	addi	a4,a4,-780 # 80022570 <bcache+0x8268>
    80004884:	e7b8                	sd	a4,72(a5)
    initsleeplock(&b->lock, "buffer");
    80004886:	fe843783          	ld	a5,-24(s0)
    8000488a:	07c1                	addi	a5,a5,16
    8000488c:	00007597          	auipc	a1,0x7
    80004890:	b8c58593          	addi	a1,a1,-1140 # 8000b418 <etext+0x418>
    80004894:	853e                	mv	a0,a5
    80004896:	00002097          	auipc	ra,0x2
    8000489a:	ff8080e7          	jalr	-8(ra) # 8000688e <initsleeplock>
    bcache.head.next->prev = b;
    8000489e:	00016717          	auipc	a4,0x16
    800048a2:	a6a70713          	addi	a4,a4,-1430 # 8001a308 <bcache>
    800048a6:	67a1                	lui	a5,0x8
    800048a8:	97ba                	add	a5,a5,a4
    800048aa:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    800048ae:	fe843703          	ld	a4,-24(s0)
    800048b2:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    800048b4:	00016717          	auipc	a4,0x16
    800048b8:	a5470713          	addi	a4,a4,-1452 # 8001a308 <bcache>
    800048bc:	67a1                	lui	a5,0x8
    800048be:	97ba                	add	a5,a5,a4
    800048c0:	fe843703          	ld	a4,-24(s0)
    800048c4:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800048c8:	fe843783          	ld	a5,-24(s0)
    800048cc:	45878793          	addi	a5,a5,1112
    800048d0:	fef43423          	sd	a5,-24(s0)
    800048d4:	0001e797          	auipc	a5,0x1e
    800048d8:	c9c78793          	addi	a5,a5,-868 # 80022570 <bcache+0x8268>
    800048dc:	fe843703          	ld	a4,-24(s0)
    800048e0:	f8f761e3          	bltu	a4,a5,80004862 <binit+0x5e>
  }
}
    800048e4:	0001                	nop
    800048e6:	0001                	nop
    800048e8:	60e2                	ld	ra,24(sp)
    800048ea:	6442                	ld	s0,16(sp)
    800048ec:	6105                	addi	sp,sp,32
    800048ee:	8082                	ret

00000000800048f0 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    800048f0:	7179                	addi	sp,sp,-48
    800048f2:	f406                	sd	ra,40(sp)
    800048f4:	f022                	sd	s0,32(sp)
    800048f6:	1800                	addi	s0,sp,48
    800048f8:	87aa                	mv	a5,a0
    800048fa:	872e                	mv	a4,a1
    800048fc:	fcf42e23          	sw	a5,-36(s0)
    80004900:	87ba                	mv	a5,a4
    80004902:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  acquire(&bcache.lock);
    80004906:	00016517          	auipc	a0,0x16
    8000490a:	a0250513          	addi	a0,a0,-1534 # 8001a308 <bcache>
    8000490e:	ffffd097          	auipc	ra,0xffffd
    80004912:	960080e7          	jalr	-1696(ra) # 8000126e <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004916:	00016717          	auipc	a4,0x16
    8000491a:	9f270713          	addi	a4,a4,-1550 # 8001a308 <bcache>
    8000491e:	67a1                	lui	a5,0x8
    80004920:	97ba                	add	a5,a5,a4
    80004922:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004926:	fef43423          	sd	a5,-24(s0)
    8000492a:	a095                	j	8000498e <bget+0x9e>
    if(b->dev == dev && b->blockno == blockno){
    8000492c:	fe843783          	ld	a5,-24(s0)
    80004930:	4798                	lw	a4,8(a5)
    80004932:	fdc42783          	lw	a5,-36(s0)
    80004936:	2781                	sext.w	a5,a5
    80004938:	04e79663          	bne	a5,a4,80004984 <bget+0x94>
    8000493c:	fe843783          	ld	a5,-24(s0)
    80004940:	47d8                	lw	a4,12(a5)
    80004942:	fd842783          	lw	a5,-40(s0)
    80004946:	2781                	sext.w	a5,a5
    80004948:	02e79e63          	bne	a5,a4,80004984 <bget+0x94>
      b->refcnt++;
    8000494c:	fe843783          	ld	a5,-24(s0)
    80004950:	43bc                	lw	a5,64(a5)
    80004952:	2785                	addiw	a5,a5,1
    80004954:	0007871b          	sext.w	a4,a5
    80004958:	fe843783          	ld	a5,-24(s0)
    8000495c:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    8000495e:	00016517          	auipc	a0,0x16
    80004962:	9aa50513          	addi	a0,a0,-1622 # 8001a308 <bcache>
    80004966:	ffffd097          	auipc	ra,0xffffd
    8000496a:	96c080e7          	jalr	-1684(ra) # 800012d2 <release>
      acquiresleep(&b->lock);
    8000496e:	fe843783          	ld	a5,-24(s0)
    80004972:	07c1                	addi	a5,a5,16
    80004974:	853e                	mv	a0,a5
    80004976:	00002097          	auipc	ra,0x2
    8000497a:	f64080e7          	jalr	-156(ra) # 800068da <acquiresleep>
      return b;
    8000497e:	fe843783          	ld	a5,-24(s0)
    80004982:	a07d                	j	80004a30 <bget+0x140>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80004984:	fe843783          	ld	a5,-24(s0)
    80004988:	6bbc                	ld	a5,80(a5)
    8000498a:	fef43423          	sd	a5,-24(s0)
    8000498e:	fe843703          	ld	a4,-24(s0)
    80004992:	0001e797          	auipc	a5,0x1e
    80004996:	bde78793          	addi	a5,a5,-1058 # 80022570 <bcache+0x8268>
    8000499a:	f8f719e3          	bne	a4,a5,8000492c <bget+0x3c>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000499e:	00016717          	auipc	a4,0x16
    800049a2:	96a70713          	addi	a4,a4,-1686 # 8001a308 <bcache>
    800049a6:	67a1                	lui	a5,0x8
    800049a8:	97ba                	add	a5,a5,a4
    800049aa:	2b07b783          	ld	a5,688(a5) # 82b0 <_entry-0x7fff7d50>
    800049ae:	fef43423          	sd	a5,-24(s0)
    800049b2:	a8b9                	j	80004a10 <bget+0x120>
    if(b->refcnt == 0) {
    800049b4:	fe843783          	ld	a5,-24(s0)
    800049b8:	43bc                	lw	a5,64(a5)
    800049ba:	e7b1                	bnez	a5,80004a06 <bget+0x116>
      b->dev = dev;
    800049bc:	fe843783          	ld	a5,-24(s0)
    800049c0:	fdc42703          	lw	a4,-36(s0)
    800049c4:	c798                	sw	a4,8(a5)
      b->blockno = blockno;
    800049c6:	fe843783          	ld	a5,-24(s0)
    800049ca:	fd842703          	lw	a4,-40(s0)
    800049ce:	c7d8                	sw	a4,12(a5)
      b->valid = 0;
    800049d0:	fe843783          	ld	a5,-24(s0)
    800049d4:	0007a023          	sw	zero,0(a5)
      b->refcnt = 1;
    800049d8:	fe843783          	ld	a5,-24(s0)
    800049dc:	4705                	li	a4,1
    800049de:	c3b8                	sw	a4,64(a5)
      release(&bcache.lock);
    800049e0:	00016517          	auipc	a0,0x16
    800049e4:	92850513          	addi	a0,a0,-1752 # 8001a308 <bcache>
    800049e8:	ffffd097          	auipc	ra,0xffffd
    800049ec:	8ea080e7          	jalr	-1814(ra) # 800012d2 <release>
      acquiresleep(&b->lock);
    800049f0:	fe843783          	ld	a5,-24(s0)
    800049f4:	07c1                	addi	a5,a5,16
    800049f6:	853e                	mv	a0,a5
    800049f8:	00002097          	auipc	ra,0x2
    800049fc:	ee2080e7          	jalr	-286(ra) # 800068da <acquiresleep>
      return b;
    80004a00:	fe843783          	ld	a5,-24(s0)
    80004a04:	a035                	j	80004a30 <bget+0x140>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80004a06:	fe843783          	ld	a5,-24(s0)
    80004a0a:	67bc                	ld	a5,72(a5)
    80004a0c:	fef43423          	sd	a5,-24(s0)
    80004a10:	fe843703          	ld	a4,-24(s0)
    80004a14:	0001e797          	auipc	a5,0x1e
    80004a18:	b5c78793          	addi	a5,a5,-1188 # 80022570 <bcache+0x8268>
    80004a1c:	f8f71ce3          	bne	a4,a5,800049b4 <bget+0xc4>
    }
  }
  panic("bget: no buffers");
    80004a20:	00007517          	auipc	a0,0x7
    80004a24:	a0050513          	addi	a0,a0,-1536 # 8000b420 <etext+0x420>
    80004a28:	ffffc097          	auipc	ra,0xffffc
    80004a2c:	256080e7          	jalr	598(ra) # 80000c7e <panic>
}
    80004a30:	853e                	mv	a0,a5
    80004a32:	70a2                	ld	ra,40(sp)
    80004a34:	7402                	ld	s0,32(sp)
    80004a36:	6145                	addi	sp,sp,48
    80004a38:	8082                	ret

0000000080004a3a <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80004a3a:	7179                	addi	sp,sp,-48
    80004a3c:	f406                	sd	ra,40(sp)
    80004a3e:	f022                	sd	s0,32(sp)
    80004a40:	1800                	addi	s0,sp,48
    80004a42:	87aa                	mv	a5,a0
    80004a44:	872e                	mv	a4,a1
    80004a46:	fcf42e23          	sw	a5,-36(s0)
    80004a4a:	87ba                	mv	a5,a4
    80004a4c:	fcf42c23          	sw	a5,-40(s0)
  struct buf *b;

  b = bget(dev, blockno);
    80004a50:	fd842703          	lw	a4,-40(s0)
    80004a54:	fdc42783          	lw	a5,-36(s0)
    80004a58:	85ba                	mv	a1,a4
    80004a5a:	853e                	mv	a0,a5
    80004a5c:	00000097          	auipc	ra,0x0
    80004a60:	e94080e7          	jalr	-364(ra) # 800048f0 <bget>
    80004a64:	fea43423          	sd	a0,-24(s0)
  if(!b->valid) {
    80004a68:	fe843783          	ld	a5,-24(s0)
    80004a6c:	439c                	lw	a5,0(a5)
    80004a6e:	ef81                	bnez	a5,80004a86 <bread+0x4c>
    virtio_disk_rw(b, 0);
    80004a70:	4581                	li	a1,0
    80004a72:	fe843503          	ld	a0,-24(s0)
    80004a76:	00004097          	auipc	ra,0x4
    80004a7a:	754080e7          	jalr	1876(ra) # 800091ca <virtio_disk_rw>
    b->valid = 1;
    80004a7e:	fe843783          	ld	a5,-24(s0)
    80004a82:	4705                	li	a4,1
    80004a84:	c398                	sw	a4,0(a5)
  }
  return b;
    80004a86:	fe843783          	ld	a5,-24(s0)
}
    80004a8a:	853e                	mv	a0,a5
    80004a8c:	70a2                	ld	ra,40(sp)
    80004a8e:	7402                	ld	s0,32(sp)
    80004a90:	6145                	addi	sp,sp,48
    80004a92:	8082                	ret

0000000080004a94 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80004a94:	1101                	addi	sp,sp,-32
    80004a96:	ec06                	sd	ra,24(sp)
    80004a98:	e822                	sd	s0,16(sp)
    80004a9a:	1000                	addi	s0,sp,32
    80004a9c:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004aa0:	fe843783          	ld	a5,-24(s0)
    80004aa4:	07c1                	addi	a5,a5,16
    80004aa6:	853e                	mv	a0,a5
    80004aa8:	00002097          	auipc	ra,0x2
    80004aac:	ef2080e7          	jalr	-270(ra) # 8000699a <holdingsleep>
    80004ab0:	87aa                	mv	a5,a0
    80004ab2:	eb89                	bnez	a5,80004ac4 <bwrite+0x30>
    panic("bwrite");
    80004ab4:	00007517          	auipc	a0,0x7
    80004ab8:	98450513          	addi	a0,a0,-1660 # 8000b438 <etext+0x438>
    80004abc:	ffffc097          	auipc	ra,0xffffc
    80004ac0:	1c2080e7          	jalr	450(ra) # 80000c7e <panic>
  virtio_disk_rw(b, 1);
    80004ac4:	4585                	li	a1,1
    80004ac6:	fe843503          	ld	a0,-24(s0)
    80004aca:	00004097          	auipc	ra,0x4
    80004ace:	700080e7          	jalr	1792(ra) # 800091ca <virtio_disk_rw>
}
    80004ad2:	0001                	nop
    80004ad4:	60e2                	ld	ra,24(sp)
    80004ad6:	6442                	ld	s0,16(sp)
    80004ad8:	6105                	addi	sp,sp,32
    80004ada:	8082                	ret

0000000080004adc <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80004adc:	1101                	addi	sp,sp,-32
    80004ade:	ec06                	sd	ra,24(sp)
    80004ae0:	e822                	sd	s0,16(sp)
    80004ae2:	1000                	addi	s0,sp,32
    80004ae4:	fea43423          	sd	a0,-24(s0)
  if(!holdingsleep(&b->lock))
    80004ae8:	fe843783          	ld	a5,-24(s0)
    80004aec:	07c1                	addi	a5,a5,16
    80004aee:	853e                	mv	a0,a5
    80004af0:	00002097          	auipc	ra,0x2
    80004af4:	eaa080e7          	jalr	-342(ra) # 8000699a <holdingsleep>
    80004af8:	87aa                	mv	a5,a0
    80004afa:	eb89                	bnez	a5,80004b0c <brelse+0x30>
    panic("brelse");
    80004afc:	00007517          	auipc	a0,0x7
    80004b00:	94450513          	addi	a0,a0,-1724 # 8000b440 <etext+0x440>
    80004b04:	ffffc097          	auipc	ra,0xffffc
    80004b08:	17a080e7          	jalr	378(ra) # 80000c7e <panic>

  releasesleep(&b->lock);
    80004b0c:	fe843783          	ld	a5,-24(s0)
    80004b10:	07c1                	addi	a5,a5,16
    80004b12:	853e                	mv	a0,a5
    80004b14:	00002097          	auipc	ra,0x2
    80004b18:	e34080e7          	jalr	-460(ra) # 80006948 <releasesleep>

  acquire(&bcache.lock);
    80004b1c:	00015517          	auipc	a0,0x15
    80004b20:	7ec50513          	addi	a0,a0,2028 # 8001a308 <bcache>
    80004b24:	ffffc097          	auipc	ra,0xffffc
    80004b28:	74a080e7          	jalr	1866(ra) # 8000126e <acquire>
  b->refcnt--;
    80004b2c:	fe843783          	ld	a5,-24(s0)
    80004b30:	43bc                	lw	a5,64(a5)
    80004b32:	37fd                	addiw	a5,a5,-1
    80004b34:	0007871b          	sext.w	a4,a5
    80004b38:	fe843783          	ld	a5,-24(s0)
    80004b3c:	c3b8                	sw	a4,64(a5)
  if (b->refcnt == 0) {
    80004b3e:	fe843783          	ld	a5,-24(s0)
    80004b42:	43bc                	lw	a5,64(a5)
    80004b44:	e7b5                	bnez	a5,80004bb0 <brelse+0xd4>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80004b46:	fe843783          	ld	a5,-24(s0)
    80004b4a:	6bbc                	ld	a5,80(a5)
    80004b4c:	fe843703          	ld	a4,-24(s0)
    80004b50:	6738                	ld	a4,72(a4)
    80004b52:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80004b54:	fe843783          	ld	a5,-24(s0)
    80004b58:	67bc                	ld	a5,72(a5)
    80004b5a:	fe843703          	ld	a4,-24(s0)
    80004b5e:	6b38                	ld	a4,80(a4)
    80004b60:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80004b62:	00015717          	auipc	a4,0x15
    80004b66:	7a670713          	addi	a4,a4,1958 # 8001a308 <bcache>
    80004b6a:	67a1                	lui	a5,0x8
    80004b6c:	97ba                	add	a5,a5,a4
    80004b6e:	2b87b703          	ld	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004b72:	fe843783          	ld	a5,-24(s0)
    80004b76:	ebb8                	sd	a4,80(a5)
    b->prev = &bcache.head;
    80004b78:	fe843783          	ld	a5,-24(s0)
    80004b7c:	0001e717          	auipc	a4,0x1e
    80004b80:	9f470713          	addi	a4,a4,-1548 # 80022570 <bcache+0x8268>
    80004b84:	e7b8                	sd	a4,72(a5)
    bcache.head.next->prev = b;
    80004b86:	00015717          	auipc	a4,0x15
    80004b8a:	78270713          	addi	a4,a4,1922 # 8001a308 <bcache>
    80004b8e:	67a1                	lui	a5,0x8
    80004b90:	97ba                	add	a5,a5,a4
    80004b92:	2b87b783          	ld	a5,696(a5) # 82b8 <_entry-0x7fff7d48>
    80004b96:	fe843703          	ld	a4,-24(s0)
    80004b9a:	e7b8                	sd	a4,72(a5)
    bcache.head.next = b;
    80004b9c:	00015717          	auipc	a4,0x15
    80004ba0:	76c70713          	addi	a4,a4,1900 # 8001a308 <bcache>
    80004ba4:	67a1                	lui	a5,0x8
    80004ba6:	97ba                	add	a5,a5,a4
    80004ba8:	fe843703          	ld	a4,-24(s0)
    80004bac:	2ae7bc23          	sd	a4,696(a5) # 82b8 <_entry-0x7fff7d48>
  }
  
  release(&bcache.lock);
    80004bb0:	00015517          	auipc	a0,0x15
    80004bb4:	75850513          	addi	a0,a0,1880 # 8001a308 <bcache>
    80004bb8:	ffffc097          	auipc	ra,0xffffc
    80004bbc:	71a080e7          	jalr	1818(ra) # 800012d2 <release>
}
    80004bc0:	0001                	nop
    80004bc2:	60e2                	ld	ra,24(sp)
    80004bc4:	6442                	ld	s0,16(sp)
    80004bc6:	6105                	addi	sp,sp,32
    80004bc8:	8082                	ret

0000000080004bca <bpin>:

void
bpin(struct buf *b) {
    80004bca:	1101                	addi	sp,sp,-32
    80004bcc:	ec06                	sd	ra,24(sp)
    80004bce:	e822                	sd	s0,16(sp)
    80004bd0:	1000                	addi	s0,sp,32
    80004bd2:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004bd6:	00015517          	auipc	a0,0x15
    80004bda:	73250513          	addi	a0,a0,1842 # 8001a308 <bcache>
    80004bde:	ffffc097          	auipc	ra,0xffffc
    80004be2:	690080e7          	jalr	1680(ra) # 8000126e <acquire>
  b->refcnt++;
    80004be6:	fe843783          	ld	a5,-24(s0)
    80004bea:	43bc                	lw	a5,64(a5)
    80004bec:	2785                	addiw	a5,a5,1
    80004bee:	0007871b          	sext.w	a4,a5
    80004bf2:	fe843783          	ld	a5,-24(s0)
    80004bf6:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004bf8:	00015517          	auipc	a0,0x15
    80004bfc:	71050513          	addi	a0,a0,1808 # 8001a308 <bcache>
    80004c00:	ffffc097          	auipc	ra,0xffffc
    80004c04:	6d2080e7          	jalr	1746(ra) # 800012d2 <release>
}
    80004c08:	0001                	nop
    80004c0a:	60e2                	ld	ra,24(sp)
    80004c0c:	6442                	ld	s0,16(sp)
    80004c0e:	6105                	addi	sp,sp,32
    80004c10:	8082                	ret

0000000080004c12 <bunpin>:

void
bunpin(struct buf *b) {
    80004c12:	1101                	addi	sp,sp,-32
    80004c14:	ec06                	sd	ra,24(sp)
    80004c16:	e822                	sd	s0,16(sp)
    80004c18:	1000                	addi	s0,sp,32
    80004c1a:	fea43423          	sd	a0,-24(s0)
  acquire(&bcache.lock);
    80004c1e:	00015517          	auipc	a0,0x15
    80004c22:	6ea50513          	addi	a0,a0,1770 # 8001a308 <bcache>
    80004c26:	ffffc097          	auipc	ra,0xffffc
    80004c2a:	648080e7          	jalr	1608(ra) # 8000126e <acquire>
  b->refcnt--;
    80004c2e:	fe843783          	ld	a5,-24(s0)
    80004c32:	43bc                	lw	a5,64(a5)
    80004c34:	37fd                	addiw	a5,a5,-1
    80004c36:	0007871b          	sext.w	a4,a5
    80004c3a:	fe843783          	ld	a5,-24(s0)
    80004c3e:	c3b8                	sw	a4,64(a5)
  release(&bcache.lock);
    80004c40:	00015517          	auipc	a0,0x15
    80004c44:	6c850513          	addi	a0,a0,1736 # 8001a308 <bcache>
    80004c48:	ffffc097          	auipc	ra,0xffffc
    80004c4c:	68a080e7          	jalr	1674(ra) # 800012d2 <release>
}
    80004c50:	0001                	nop
    80004c52:	60e2                	ld	ra,24(sp)
    80004c54:	6442                	ld	s0,16(sp)
    80004c56:	6105                	addi	sp,sp,32
    80004c58:	8082                	ret

0000000080004c5a <readsb>:
struct superblock sb; 

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
    80004c5a:	7179                	addi	sp,sp,-48
    80004c5c:	f406                	sd	ra,40(sp)
    80004c5e:	f022                	sd	s0,32(sp)
    80004c60:	1800                	addi	s0,sp,48
    80004c62:	87aa                	mv	a5,a0
    80004c64:	fcb43823          	sd	a1,-48(s0)
    80004c68:	fcf42e23          	sw	a5,-36(s0)
  struct buf *bp;

  bp = bread(dev, 1);
    80004c6c:	fdc42783          	lw	a5,-36(s0)
    80004c70:	4585                	li	a1,1
    80004c72:	853e                	mv	a0,a5
    80004c74:	00000097          	auipc	ra,0x0
    80004c78:	dc6080e7          	jalr	-570(ra) # 80004a3a <bread>
    80004c7c:	fea43423          	sd	a0,-24(s0)
  memmove(sb, bp->data, sizeof(*sb));
    80004c80:	fe843783          	ld	a5,-24(s0)
    80004c84:	05878793          	addi	a5,a5,88
    80004c88:	02000613          	li	a2,32
    80004c8c:	85be                	mv	a1,a5
    80004c8e:	fd043503          	ld	a0,-48(s0)
    80004c92:	ffffd097          	auipc	ra,0xffffd
    80004c96:	894080e7          	jalr	-1900(ra) # 80001526 <memmove>
  brelse(bp);
    80004c9a:	fe843503          	ld	a0,-24(s0)
    80004c9e:	00000097          	auipc	ra,0x0
    80004ca2:	e3e080e7          	jalr	-450(ra) # 80004adc <brelse>
}
    80004ca6:	0001                	nop
    80004ca8:	70a2                	ld	ra,40(sp)
    80004caa:	7402                	ld	s0,32(sp)
    80004cac:	6145                	addi	sp,sp,48
    80004cae:	8082                	ret

0000000080004cb0 <fsinit>:

// Init fs
void
fsinit(int dev) {
    80004cb0:	1101                	addi	sp,sp,-32
    80004cb2:	ec06                	sd	ra,24(sp)
    80004cb4:	e822                	sd	s0,16(sp)
    80004cb6:	1000                	addi	s0,sp,32
    80004cb8:	87aa                	mv	a5,a0
    80004cba:	fef42623          	sw	a5,-20(s0)
  readsb(dev, &sb);
    80004cbe:	fec42783          	lw	a5,-20(s0)
    80004cc2:	0001e597          	auipc	a1,0x1e
    80004cc6:	d0658593          	addi	a1,a1,-762 # 800229c8 <sb>
    80004cca:	853e                	mv	a0,a5
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	f8e080e7          	jalr	-114(ra) # 80004c5a <readsb>
  if(sb.magic != FSMAGIC)
    80004cd4:	0001e797          	auipc	a5,0x1e
    80004cd8:	cf478793          	addi	a5,a5,-780 # 800229c8 <sb>
    80004cdc:	439c                	lw	a5,0(a5)
    80004cde:	873e                	mv	a4,a5
    80004ce0:	102037b7          	lui	a5,0x10203
    80004ce4:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80004ce8:	00f70a63          	beq	a4,a5,80004cfc <fsinit+0x4c>
    panic("invalid file system");
    80004cec:	00006517          	auipc	a0,0x6
    80004cf0:	75c50513          	addi	a0,a0,1884 # 8000b448 <etext+0x448>
    80004cf4:	ffffc097          	auipc	ra,0xffffc
    80004cf8:	f8a080e7          	jalr	-118(ra) # 80000c7e <panic>
  initlog(dev, &sb);
    80004cfc:	fec42783          	lw	a5,-20(s0)
    80004d00:	0001e597          	auipc	a1,0x1e
    80004d04:	cc858593          	addi	a1,a1,-824 # 800229c8 <sb>
    80004d08:	853e                	mv	a0,a5
    80004d0a:	00001097          	auipc	ra,0x1
    80004d0e:	468080e7          	jalr	1128(ra) # 80006172 <initlog>
}
    80004d12:	0001                	nop
    80004d14:	60e2                	ld	ra,24(sp)
    80004d16:	6442                	ld	s0,16(sp)
    80004d18:	6105                	addi	sp,sp,32
    80004d1a:	8082                	ret

0000000080004d1c <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
    80004d1c:	7179                	addi	sp,sp,-48
    80004d1e:	f406                	sd	ra,40(sp)
    80004d20:	f022                	sd	s0,32(sp)
    80004d22:	1800                	addi	s0,sp,48
    80004d24:	87aa                	mv	a5,a0
    80004d26:	872e                	mv	a4,a1
    80004d28:	fcf42e23          	sw	a5,-36(s0)
    80004d2c:	87ba                	mv	a5,a4
    80004d2e:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;

  bp = bread(dev, bno);
    80004d32:	fdc42783          	lw	a5,-36(s0)
    80004d36:	fd842703          	lw	a4,-40(s0)
    80004d3a:	85ba                	mv	a1,a4
    80004d3c:	853e                	mv	a0,a5
    80004d3e:	00000097          	auipc	ra,0x0
    80004d42:	cfc080e7          	jalr	-772(ra) # 80004a3a <bread>
    80004d46:	fea43423          	sd	a0,-24(s0)
  memset(bp->data, 0, BSIZE);
    80004d4a:	fe843783          	ld	a5,-24(s0)
    80004d4e:	05878793          	addi	a5,a5,88
    80004d52:	40000613          	li	a2,1024
    80004d56:	4581                	li	a1,0
    80004d58:	853e                	mv	a0,a5
    80004d5a:	ffffc097          	auipc	ra,0xffffc
    80004d5e:	6e8080e7          	jalr	1768(ra) # 80001442 <memset>
  log_write(bp);
    80004d62:	fe843503          	ld	a0,-24(s0)
    80004d66:	00002097          	auipc	ra,0x2
    80004d6a:	9f4080e7          	jalr	-1548(ra) # 8000675a <log_write>
  brelse(bp);
    80004d6e:	fe843503          	ld	a0,-24(s0)
    80004d72:	00000097          	auipc	ra,0x0
    80004d76:	d6a080e7          	jalr	-662(ra) # 80004adc <brelse>
}
    80004d7a:	0001                	nop
    80004d7c:	70a2                	ld	ra,40(sp)
    80004d7e:	7402                	ld	s0,32(sp)
    80004d80:	6145                	addi	sp,sp,48
    80004d82:	8082                	ret

0000000080004d84 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
    80004d84:	7139                	addi	sp,sp,-64
    80004d86:	fc06                	sd	ra,56(sp)
    80004d88:	f822                	sd	s0,48(sp)
    80004d8a:	0080                	addi	s0,sp,64
    80004d8c:	87aa                	mv	a5,a0
    80004d8e:	fcf42623          	sw	a5,-52(s0)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
    80004d92:	fe043023          	sd	zero,-32(s0)
  for(b = 0; b < sb.size; b += BPB){
    80004d96:	fe042623          	sw	zero,-20(s0)
    80004d9a:	a2b5                	j	80004f06 <balloc+0x182>
    bp = bread(dev, BBLOCK(b, sb));
    80004d9c:	fec42783          	lw	a5,-20(s0)
    80004da0:	41f7d71b          	sraiw	a4,a5,0x1f
    80004da4:	0137571b          	srliw	a4,a4,0x13
    80004da8:	9fb9                	addw	a5,a5,a4
    80004daa:	40d7d79b          	sraiw	a5,a5,0xd
    80004dae:	2781                	sext.w	a5,a5
    80004db0:	0007871b          	sext.w	a4,a5
    80004db4:	0001e797          	auipc	a5,0x1e
    80004db8:	c1478793          	addi	a5,a5,-1004 # 800229c8 <sb>
    80004dbc:	4fdc                	lw	a5,28(a5)
    80004dbe:	9fb9                	addw	a5,a5,a4
    80004dc0:	0007871b          	sext.w	a4,a5
    80004dc4:	fcc42783          	lw	a5,-52(s0)
    80004dc8:	85ba                	mv	a1,a4
    80004dca:	853e                	mv	a0,a5
    80004dcc:	00000097          	auipc	ra,0x0
    80004dd0:	c6e080e7          	jalr	-914(ra) # 80004a3a <bread>
    80004dd4:	fea43023          	sd	a0,-32(s0)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004dd8:	fe042423          	sw	zero,-24(s0)
    80004ddc:	a0dd                	j	80004ec2 <balloc+0x13e>
      m = 1 << (bi % 8);
    80004dde:	fe842703          	lw	a4,-24(s0)
    80004de2:	41f7579b          	sraiw	a5,a4,0x1f
    80004de6:	01d7d79b          	srliw	a5,a5,0x1d
    80004dea:	9f3d                	addw	a4,a4,a5
    80004dec:	8b1d                	andi	a4,a4,7
    80004dee:	40f707bb          	subw	a5,a4,a5
    80004df2:	2781                	sext.w	a5,a5
    80004df4:	4705                	li	a4,1
    80004df6:	00f717bb          	sllw	a5,a4,a5
    80004dfa:	fcf42e23          	sw	a5,-36(s0)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80004dfe:	fe842783          	lw	a5,-24(s0)
    80004e02:	41f7d71b          	sraiw	a4,a5,0x1f
    80004e06:	01d7571b          	srliw	a4,a4,0x1d
    80004e0a:	9fb9                	addw	a5,a5,a4
    80004e0c:	4037d79b          	sraiw	a5,a5,0x3
    80004e10:	2781                	sext.w	a5,a5
    80004e12:	fe043703          	ld	a4,-32(s0)
    80004e16:	97ba                	add	a5,a5,a4
    80004e18:	0587c783          	lbu	a5,88(a5)
    80004e1c:	0007871b          	sext.w	a4,a5
    80004e20:	fdc42783          	lw	a5,-36(s0)
    80004e24:	8ff9                	and	a5,a5,a4
    80004e26:	2781                	sext.w	a5,a5
    80004e28:	ebc1                	bnez	a5,80004eb8 <balloc+0x134>
        bp->data[bi/8] |= m;  // Mark block in use.
    80004e2a:	fe842783          	lw	a5,-24(s0)
    80004e2e:	41f7d71b          	sraiw	a4,a5,0x1f
    80004e32:	01d7571b          	srliw	a4,a4,0x1d
    80004e36:	9fb9                	addw	a5,a5,a4
    80004e38:	4037d79b          	sraiw	a5,a5,0x3
    80004e3c:	2781                	sext.w	a5,a5
    80004e3e:	fe043703          	ld	a4,-32(s0)
    80004e42:	973e                	add	a4,a4,a5
    80004e44:	05874703          	lbu	a4,88(a4)
    80004e48:	0187169b          	slliw	a3,a4,0x18
    80004e4c:	4186d69b          	sraiw	a3,a3,0x18
    80004e50:	fdc42703          	lw	a4,-36(s0)
    80004e54:	0187171b          	slliw	a4,a4,0x18
    80004e58:	4187571b          	sraiw	a4,a4,0x18
    80004e5c:	8f55                	or	a4,a4,a3
    80004e5e:	0187171b          	slliw	a4,a4,0x18
    80004e62:	4187571b          	sraiw	a4,a4,0x18
    80004e66:	0ff77713          	andi	a4,a4,255
    80004e6a:	fe043683          	ld	a3,-32(s0)
    80004e6e:	97b6                	add	a5,a5,a3
    80004e70:	04e78c23          	sb	a4,88(a5)
        log_write(bp);
    80004e74:	fe043503          	ld	a0,-32(s0)
    80004e78:	00002097          	auipc	ra,0x2
    80004e7c:	8e2080e7          	jalr	-1822(ra) # 8000675a <log_write>
        brelse(bp);
    80004e80:	fe043503          	ld	a0,-32(s0)
    80004e84:	00000097          	auipc	ra,0x0
    80004e88:	c58080e7          	jalr	-936(ra) # 80004adc <brelse>
        bzero(dev, b + bi);
    80004e8c:	fcc42683          	lw	a3,-52(s0)
    80004e90:	fec42703          	lw	a4,-20(s0)
    80004e94:	fe842783          	lw	a5,-24(s0)
    80004e98:	9fb9                	addw	a5,a5,a4
    80004e9a:	2781                	sext.w	a5,a5
    80004e9c:	85be                	mv	a1,a5
    80004e9e:	8536                	mv	a0,a3
    80004ea0:	00000097          	auipc	ra,0x0
    80004ea4:	e7c080e7          	jalr	-388(ra) # 80004d1c <bzero>
        return b + bi;
    80004ea8:	fec42703          	lw	a4,-20(s0)
    80004eac:	fe842783          	lw	a5,-24(s0)
    80004eb0:	9fb9                	addw	a5,a5,a4
    80004eb2:	2781                	sext.w	a5,a5
    80004eb4:	2781                	sext.w	a5,a5
    80004eb6:	a88d                	j	80004f28 <balloc+0x1a4>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80004eb8:	fe842783          	lw	a5,-24(s0)
    80004ebc:	2785                	addiw	a5,a5,1
    80004ebe:	fef42423          	sw	a5,-24(s0)
    80004ec2:	fe842783          	lw	a5,-24(s0)
    80004ec6:	0007871b          	sext.w	a4,a5
    80004eca:	6789                	lui	a5,0x2
    80004ecc:	02f75163          	bge	a4,a5,80004eee <balloc+0x16a>
    80004ed0:	fec42703          	lw	a4,-20(s0)
    80004ed4:	fe842783          	lw	a5,-24(s0)
    80004ed8:	9fb9                	addw	a5,a5,a4
    80004eda:	2781                	sext.w	a5,a5
    80004edc:	0007871b          	sext.w	a4,a5
    80004ee0:	0001e797          	auipc	a5,0x1e
    80004ee4:	ae878793          	addi	a5,a5,-1304 # 800229c8 <sb>
    80004ee8:	43dc                	lw	a5,4(a5)
    80004eea:	eef76ae3          	bltu	a4,a5,80004dde <balloc+0x5a>
      }
    }
    brelse(bp);
    80004eee:	fe043503          	ld	a0,-32(s0)
    80004ef2:	00000097          	auipc	ra,0x0
    80004ef6:	bea080e7          	jalr	-1046(ra) # 80004adc <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80004efa:	fec42703          	lw	a4,-20(s0)
    80004efe:	6789                	lui	a5,0x2
    80004f00:	9fb9                	addw	a5,a5,a4
    80004f02:	fef42623          	sw	a5,-20(s0)
    80004f06:	0001e797          	auipc	a5,0x1e
    80004f0a:	ac278793          	addi	a5,a5,-1342 # 800229c8 <sb>
    80004f0e:	43d8                	lw	a4,4(a5)
    80004f10:	fec42783          	lw	a5,-20(s0)
    80004f14:	e8e7e4e3          	bltu	a5,a4,80004d9c <balloc+0x18>
  }
  panic("balloc: out of blocks");
    80004f18:	00006517          	auipc	a0,0x6
    80004f1c:	54850513          	addi	a0,a0,1352 # 8000b460 <etext+0x460>
    80004f20:	ffffc097          	auipc	ra,0xffffc
    80004f24:	d5e080e7          	jalr	-674(ra) # 80000c7e <panic>
}
    80004f28:	853e                	mv	a0,a5
    80004f2a:	70e2                	ld	ra,56(sp)
    80004f2c:	7442                	ld	s0,48(sp)
    80004f2e:	6121                	addi	sp,sp,64
    80004f30:	8082                	ret

0000000080004f32 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80004f32:	7179                	addi	sp,sp,-48
    80004f34:	f406                	sd	ra,40(sp)
    80004f36:	f022                	sd	s0,32(sp)
    80004f38:	1800                	addi	s0,sp,48
    80004f3a:	87aa                	mv	a5,a0
    80004f3c:	872e                	mv	a4,a1
    80004f3e:	fcf42e23          	sw	a5,-36(s0)
    80004f42:	87ba                	mv	a5,a4
    80004f44:	fcf42c23          	sw	a5,-40(s0)
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80004f48:	fdc42683          	lw	a3,-36(s0)
    80004f4c:	fd842783          	lw	a5,-40(s0)
    80004f50:	00d7d79b          	srliw	a5,a5,0xd
    80004f54:	0007871b          	sext.w	a4,a5
    80004f58:	0001e797          	auipc	a5,0x1e
    80004f5c:	a7078793          	addi	a5,a5,-1424 # 800229c8 <sb>
    80004f60:	4fdc                	lw	a5,28(a5)
    80004f62:	9fb9                	addw	a5,a5,a4
    80004f64:	2781                	sext.w	a5,a5
    80004f66:	85be                	mv	a1,a5
    80004f68:	8536                	mv	a0,a3
    80004f6a:	00000097          	auipc	ra,0x0
    80004f6e:	ad0080e7          	jalr	-1328(ra) # 80004a3a <bread>
    80004f72:	fea43423          	sd	a0,-24(s0)
  bi = b % BPB;
    80004f76:	fd842703          	lw	a4,-40(s0)
    80004f7a:	6789                	lui	a5,0x2
    80004f7c:	17fd                	addi	a5,a5,-1
    80004f7e:	8ff9                	and	a5,a5,a4
    80004f80:	fef42223          	sw	a5,-28(s0)
  m = 1 << (bi % 8);
    80004f84:	fe442703          	lw	a4,-28(s0)
    80004f88:	41f7579b          	sraiw	a5,a4,0x1f
    80004f8c:	01d7d79b          	srliw	a5,a5,0x1d
    80004f90:	9f3d                	addw	a4,a4,a5
    80004f92:	8b1d                	andi	a4,a4,7
    80004f94:	40f707bb          	subw	a5,a4,a5
    80004f98:	2781                	sext.w	a5,a5
    80004f9a:	4705                	li	a4,1
    80004f9c:	00f717bb          	sllw	a5,a4,a5
    80004fa0:	fef42023          	sw	a5,-32(s0)
  if((bp->data[bi/8] & m) == 0)
    80004fa4:	fe442783          	lw	a5,-28(s0)
    80004fa8:	41f7d71b          	sraiw	a4,a5,0x1f
    80004fac:	01d7571b          	srliw	a4,a4,0x1d
    80004fb0:	9fb9                	addw	a5,a5,a4
    80004fb2:	4037d79b          	sraiw	a5,a5,0x3
    80004fb6:	2781                	sext.w	a5,a5
    80004fb8:	fe843703          	ld	a4,-24(s0)
    80004fbc:	97ba                	add	a5,a5,a4
    80004fbe:	0587c783          	lbu	a5,88(a5) # 2058 <_entry-0x7fffdfa8>
    80004fc2:	0007871b          	sext.w	a4,a5
    80004fc6:	fe042783          	lw	a5,-32(s0)
    80004fca:	8ff9                	and	a5,a5,a4
    80004fcc:	2781                	sext.w	a5,a5
    80004fce:	eb89                	bnez	a5,80004fe0 <bfree+0xae>
    panic("freeing free block");
    80004fd0:	00006517          	auipc	a0,0x6
    80004fd4:	4a850513          	addi	a0,a0,1192 # 8000b478 <etext+0x478>
    80004fd8:	ffffc097          	auipc	ra,0xffffc
    80004fdc:	ca6080e7          	jalr	-858(ra) # 80000c7e <panic>
  bp->data[bi/8] &= ~m;
    80004fe0:	fe442783          	lw	a5,-28(s0)
    80004fe4:	41f7d71b          	sraiw	a4,a5,0x1f
    80004fe8:	01d7571b          	srliw	a4,a4,0x1d
    80004fec:	9fb9                	addw	a5,a5,a4
    80004fee:	4037d79b          	sraiw	a5,a5,0x3
    80004ff2:	2781                	sext.w	a5,a5
    80004ff4:	fe843703          	ld	a4,-24(s0)
    80004ff8:	973e                	add	a4,a4,a5
    80004ffa:	05874703          	lbu	a4,88(a4)
    80004ffe:	0187169b          	slliw	a3,a4,0x18
    80005002:	4186d69b          	sraiw	a3,a3,0x18
    80005006:	fe042703          	lw	a4,-32(s0)
    8000500a:	0187171b          	slliw	a4,a4,0x18
    8000500e:	4187571b          	sraiw	a4,a4,0x18
    80005012:	fff74713          	not	a4,a4
    80005016:	0187171b          	slliw	a4,a4,0x18
    8000501a:	4187571b          	sraiw	a4,a4,0x18
    8000501e:	8f75                	and	a4,a4,a3
    80005020:	0187171b          	slliw	a4,a4,0x18
    80005024:	4187571b          	sraiw	a4,a4,0x18
    80005028:	0ff77713          	andi	a4,a4,255
    8000502c:	fe843683          	ld	a3,-24(s0)
    80005030:	97b6                	add	a5,a5,a3
    80005032:	04e78c23          	sb	a4,88(a5)
  log_write(bp);
    80005036:	fe843503          	ld	a0,-24(s0)
    8000503a:	00001097          	auipc	ra,0x1
    8000503e:	720080e7          	jalr	1824(ra) # 8000675a <log_write>
  brelse(bp);
    80005042:	fe843503          	ld	a0,-24(s0)
    80005046:	00000097          	auipc	ra,0x0
    8000504a:	a96080e7          	jalr	-1386(ra) # 80004adc <brelse>
}
    8000504e:	0001                	nop
    80005050:	70a2                	ld	ra,40(sp)
    80005052:	7402                	ld	s0,32(sp)
    80005054:	6145                	addi	sp,sp,48
    80005056:	8082                	ret

0000000080005058 <iinit>:
  struct inode inode[NINODE];
} itable;

void
iinit()
{
    80005058:	1101                	addi	sp,sp,-32
    8000505a:	ec06                	sd	ra,24(sp)
    8000505c:	e822                	sd	s0,16(sp)
    8000505e:	1000                	addi	s0,sp,32
  int i = 0;
    80005060:	fe042623          	sw	zero,-20(s0)
  
  initlock(&itable.lock, "itable");
    80005064:	00006597          	auipc	a1,0x6
    80005068:	42c58593          	addi	a1,a1,1068 # 8000b490 <etext+0x490>
    8000506c:	0001e517          	auipc	a0,0x1e
    80005070:	97c50513          	addi	a0,a0,-1668 # 800229e8 <itable>
    80005074:	ffffc097          	auipc	ra,0xffffc
    80005078:	1ca080e7          	jalr	458(ra) # 8000123e <initlock>
  for(i = 0; i < NINODE; i++) {
    8000507c:	fe042623          	sw	zero,-20(s0)
    80005080:	a82d                	j	800050ba <iinit+0x62>
    initsleeplock(&itable.inode[i].lock, "inode");
    80005082:	fec42703          	lw	a4,-20(s0)
    80005086:	87ba                	mv	a5,a4
    80005088:	0792                	slli	a5,a5,0x4
    8000508a:	97ba                	add	a5,a5,a4
    8000508c:	078e                	slli	a5,a5,0x3
    8000508e:	02078713          	addi	a4,a5,32
    80005092:	0001e797          	auipc	a5,0x1e
    80005096:	95678793          	addi	a5,a5,-1706 # 800229e8 <itable>
    8000509a:	97ba                	add	a5,a5,a4
    8000509c:	07a1                	addi	a5,a5,8
    8000509e:	00006597          	auipc	a1,0x6
    800050a2:	3fa58593          	addi	a1,a1,1018 # 8000b498 <etext+0x498>
    800050a6:	853e                	mv	a0,a5
    800050a8:	00001097          	auipc	ra,0x1
    800050ac:	7e6080e7          	jalr	2022(ra) # 8000688e <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800050b0:	fec42783          	lw	a5,-20(s0)
    800050b4:	2785                	addiw	a5,a5,1
    800050b6:	fef42623          	sw	a5,-20(s0)
    800050ba:	fec42783          	lw	a5,-20(s0)
    800050be:	0007871b          	sext.w	a4,a5
    800050c2:	03100793          	li	a5,49
    800050c6:	fae7dee3          	bge	a5,a4,80005082 <iinit+0x2a>
  }
}
    800050ca:	0001                	nop
    800050cc:	0001                	nop
    800050ce:	60e2                	ld	ra,24(sp)
    800050d0:	6442                	ld	s0,16(sp)
    800050d2:	6105                	addi	sp,sp,32
    800050d4:	8082                	ret

00000000800050d6 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
    800050d6:	7139                	addi	sp,sp,-64
    800050d8:	fc06                	sd	ra,56(sp)
    800050da:	f822                	sd	s0,48(sp)
    800050dc:	0080                	addi	s0,sp,64
    800050de:	87aa                	mv	a5,a0
    800050e0:	872e                	mv	a4,a1
    800050e2:	fcf42623          	sw	a5,-52(s0)
    800050e6:	87ba                	mv	a5,a4
    800050e8:	fcf41523          	sh	a5,-54(s0)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    800050ec:	4785                	li	a5,1
    800050ee:	fef42623          	sw	a5,-20(s0)
    800050f2:	a855                	j	800051a6 <ialloc+0xd0>
    bp = bread(dev, IBLOCK(inum, sb));
    800050f4:	fec42783          	lw	a5,-20(s0)
    800050f8:	8391                	srli	a5,a5,0x4
    800050fa:	0007871b          	sext.w	a4,a5
    800050fe:	0001e797          	auipc	a5,0x1e
    80005102:	8ca78793          	addi	a5,a5,-1846 # 800229c8 <sb>
    80005106:	4f9c                	lw	a5,24(a5)
    80005108:	9fb9                	addw	a5,a5,a4
    8000510a:	0007871b          	sext.w	a4,a5
    8000510e:	fcc42783          	lw	a5,-52(s0)
    80005112:	85ba                	mv	a1,a4
    80005114:	853e                	mv	a0,a5
    80005116:	00000097          	auipc	ra,0x0
    8000511a:	924080e7          	jalr	-1756(ra) # 80004a3a <bread>
    8000511e:	fea43023          	sd	a0,-32(s0)
    dip = (struct dinode*)bp->data + inum%IPB;
    80005122:	fe043783          	ld	a5,-32(s0)
    80005126:	05878713          	addi	a4,a5,88
    8000512a:	fec42783          	lw	a5,-20(s0)
    8000512e:	8bbd                	andi	a5,a5,15
    80005130:	079a                	slli	a5,a5,0x6
    80005132:	97ba                	add	a5,a5,a4
    80005134:	fcf43c23          	sd	a5,-40(s0)
    if(dip->type == 0){  // a free inode
    80005138:	fd843783          	ld	a5,-40(s0)
    8000513c:	00079783          	lh	a5,0(a5)
    80005140:	eba1                	bnez	a5,80005190 <ialloc+0xba>
      memset(dip, 0, sizeof(*dip));
    80005142:	04000613          	li	a2,64
    80005146:	4581                	li	a1,0
    80005148:	fd843503          	ld	a0,-40(s0)
    8000514c:	ffffc097          	auipc	ra,0xffffc
    80005150:	2f6080e7          	jalr	758(ra) # 80001442 <memset>
      dip->type = type;
    80005154:	fd843783          	ld	a5,-40(s0)
    80005158:	fca45703          	lhu	a4,-54(s0)
    8000515c:	00e79023          	sh	a4,0(a5)
      log_write(bp);   // mark it allocated on the disk
    80005160:	fe043503          	ld	a0,-32(s0)
    80005164:	00001097          	auipc	ra,0x1
    80005168:	5f6080e7          	jalr	1526(ra) # 8000675a <log_write>
      brelse(bp);
    8000516c:	fe043503          	ld	a0,-32(s0)
    80005170:	00000097          	auipc	ra,0x0
    80005174:	96c080e7          	jalr	-1684(ra) # 80004adc <brelse>
      return iget(dev, inum);
    80005178:	fec42703          	lw	a4,-20(s0)
    8000517c:	fcc42783          	lw	a5,-52(s0)
    80005180:	85ba                	mv	a1,a4
    80005182:	853e                	mv	a0,a5
    80005184:	00000097          	auipc	ra,0x0
    80005188:	136080e7          	jalr	310(ra) # 800052ba <iget>
    8000518c:	87aa                	mv	a5,a0
    8000518e:	a82d                	j	800051c8 <ialloc+0xf2>
    }
    brelse(bp);
    80005190:	fe043503          	ld	a0,-32(s0)
    80005194:	00000097          	auipc	ra,0x0
    80005198:	948080e7          	jalr	-1720(ra) # 80004adc <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000519c:	fec42783          	lw	a5,-20(s0)
    800051a0:	2785                	addiw	a5,a5,1
    800051a2:	fef42623          	sw	a5,-20(s0)
    800051a6:	0001e797          	auipc	a5,0x1e
    800051aa:	82278793          	addi	a5,a5,-2014 # 800229c8 <sb>
    800051ae:	47d8                	lw	a4,12(a5)
    800051b0:	fec42783          	lw	a5,-20(s0)
    800051b4:	f4e7e0e3          	bltu	a5,a4,800050f4 <ialloc+0x1e>
  }
  panic("ialloc: no inodes");
    800051b8:	00006517          	auipc	a0,0x6
    800051bc:	2e850513          	addi	a0,a0,744 # 8000b4a0 <etext+0x4a0>
    800051c0:	ffffc097          	auipc	ra,0xffffc
    800051c4:	abe080e7          	jalr	-1346(ra) # 80000c7e <panic>
}
    800051c8:	853e                	mv	a0,a5
    800051ca:	70e2                	ld	ra,56(sp)
    800051cc:	7442                	ld	s0,48(sp)
    800051ce:	6121                	addi	sp,sp,64
    800051d0:	8082                	ret

00000000800051d2 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
    800051d2:	7179                	addi	sp,sp,-48
    800051d4:	f406                	sd	ra,40(sp)
    800051d6:	f022                	sd	s0,32(sp)
    800051d8:	1800                	addi	s0,sp,48
    800051da:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800051de:	fd843783          	ld	a5,-40(s0)
    800051e2:	4394                	lw	a3,0(a5)
    800051e4:	fd843783          	ld	a5,-40(s0)
    800051e8:	43dc                	lw	a5,4(a5)
    800051ea:	0047d79b          	srliw	a5,a5,0x4
    800051ee:	0007871b          	sext.w	a4,a5
    800051f2:	0001d797          	auipc	a5,0x1d
    800051f6:	7d678793          	addi	a5,a5,2006 # 800229c8 <sb>
    800051fa:	4f9c                	lw	a5,24(a5)
    800051fc:	9fb9                	addw	a5,a5,a4
    800051fe:	2781                	sext.w	a5,a5
    80005200:	85be                	mv	a1,a5
    80005202:	8536                	mv	a0,a3
    80005204:	00000097          	auipc	ra,0x0
    80005208:	836080e7          	jalr	-1994(ra) # 80004a3a <bread>
    8000520c:	fea43423          	sd	a0,-24(s0)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005210:	fe843783          	ld	a5,-24(s0)
    80005214:	05878713          	addi	a4,a5,88
    80005218:	fd843783          	ld	a5,-40(s0)
    8000521c:	43dc                	lw	a5,4(a5)
    8000521e:	1782                	slli	a5,a5,0x20
    80005220:	9381                	srli	a5,a5,0x20
    80005222:	8bbd                	andi	a5,a5,15
    80005224:	079a                	slli	a5,a5,0x6
    80005226:	97ba                	add	a5,a5,a4
    80005228:	fef43023          	sd	a5,-32(s0)
  dip->type = ip->type;
    8000522c:	fd843783          	ld	a5,-40(s0)
    80005230:	04479703          	lh	a4,68(a5)
    80005234:	fe043783          	ld	a5,-32(s0)
    80005238:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    8000523c:	fd843783          	ld	a5,-40(s0)
    80005240:	04679703          	lh	a4,70(a5)
    80005244:	fe043783          	ld	a5,-32(s0)
    80005248:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    8000524c:	fd843783          	ld	a5,-40(s0)
    80005250:	04879703          	lh	a4,72(a5)
    80005254:	fe043783          	ld	a5,-32(s0)
    80005258:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    8000525c:	fd843783          	ld	a5,-40(s0)
    80005260:	04a79703          	lh	a4,74(a5)
    80005264:	fe043783          	ld	a5,-32(s0)
    80005268:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    8000526c:	fd843783          	ld	a5,-40(s0)
    80005270:	47f8                	lw	a4,76(a5)
    80005272:	fe043783          	ld	a5,-32(s0)
    80005276:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80005278:	fe043783          	ld	a5,-32(s0)
    8000527c:	00c78713          	addi	a4,a5,12
    80005280:	fd843783          	ld	a5,-40(s0)
    80005284:	05078793          	addi	a5,a5,80
    80005288:	03400613          	li	a2,52
    8000528c:	85be                	mv	a1,a5
    8000528e:	853a                	mv	a0,a4
    80005290:	ffffc097          	auipc	ra,0xffffc
    80005294:	296080e7          	jalr	662(ra) # 80001526 <memmove>
  log_write(bp);
    80005298:	fe843503          	ld	a0,-24(s0)
    8000529c:	00001097          	auipc	ra,0x1
    800052a0:	4be080e7          	jalr	1214(ra) # 8000675a <log_write>
  brelse(bp);
    800052a4:	fe843503          	ld	a0,-24(s0)
    800052a8:	00000097          	auipc	ra,0x0
    800052ac:	834080e7          	jalr	-1996(ra) # 80004adc <brelse>
}
    800052b0:	0001                	nop
    800052b2:	70a2                	ld	ra,40(sp)
    800052b4:	7402                	ld	s0,32(sp)
    800052b6:	6145                	addi	sp,sp,48
    800052b8:	8082                	ret

00000000800052ba <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
    800052ba:	7179                	addi	sp,sp,-48
    800052bc:	f406                	sd	ra,40(sp)
    800052be:	f022                	sd	s0,32(sp)
    800052c0:	1800                	addi	s0,sp,48
    800052c2:	87aa                	mv	a5,a0
    800052c4:	872e                	mv	a4,a1
    800052c6:	fcf42e23          	sw	a5,-36(s0)
    800052ca:	87ba                	mv	a5,a4
    800052cc:	fcf42c23          	sw	a5,-40(s0)
  struct inode *ip, *empty;

  acquire(&itable.lock);
    800052d0:	0001d517          	auipc	a0,0x1d
    800052d4:	71850513          	addi	a0,a0,1816 # 800229e8 <itable>
    800052d8:	ffffc097          	auipc	ra,0xffffc
    800052dc:	f96080e7          	jalr	-106(ra) # 8000126e <acquire>

  // Is the inode already in the table?
  empty = 0;
    800052e0:	fe043023          	sd	zero,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800052e4:	0001d797          	auipc	a5,0x1d
    800052e8:	71c78793          	addi	a5,a5,1820 # 80022a00 <itable+0x18>
    800052ec:	fef43423          	sd	a5,-24(s0)
    800052f0:	a89d                	j	80005366 <iget+0xac>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800052f2:	fe843783          	ld	a5,-24(s0)
    800052f6:	479c                	lw	a5,8(a5)
    800052f8:	04f05663          	blez	a5,80005344 <iget+0x8a>
    800052fc:	fe843783          	ld	a5,-24(s0)
    80005300:	4398                	lw	a4,0(a5)
    80005302:	fdc42783          	lw	a5,-36(s0)
    80005306:	2781                	sext.w	a5,a5
    80005308:	02e79e63          	bne	a5,a4,80005344 <iget+0x8a>
    8000530c:	fe843783          	ld	a5,-24(s0)
    80005310:	43d8                	lw	a4,4(a5)
    80005312:	fd842783          	lw	a5,-40(s0)
    80005316:	2781                	sext.w	a5,a5
    80005318:	02e79663          	bne	a5,a4,80005344 <iget+0x8a>
      ip->ref++;
    8000531c:	fe843783          	ld	a5,-24(s0)
    80005320:	479c                	lw	a5,8(a5)
    80005322:	2785                	addiw	a5,a5,1
    80005324:	0007871b          	sext.w	a4,a5
    80005328:	fe843783          	ld	a5,-24(s0)
    8000532c:	c798                	sw	a4,8(a5)
      release(&itable.lock);
    8000532e:	0001d517          	auipc	a0,0x1d
    80005332:	6ba50513          	addi	a0,a0,1722 # 800229e8 <itable>
    80005336:	ffffc097          	auipc	ra,0xffffc
    8000533a:	f9c080e7          	jalr	-100(ra) # 800012d2 <release>
      return ip;
    8000533e:	fe843783          	ld	a5,-24(s0)
    80005342:	a069                	j	800053cc <iget+0x112>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80005344:	fe043783          	ld	a5,-32(s0)
    80005348:	eb89                	bnez	a5,8000535a <iget+0xa0>
    8000534a:	fe843783          	ld	a5,-24(s0)
    8000534e:	479c                	lw	a5,8(a5)
    80005350:	e789                	bnez	a5,8000535a <iget+0xa0>
      empty = ip;
    80005352:	fe843783          	ld	a5,-24(s0)
    80005356:	fef43023          	sd	a5,-32(s0)
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000535a:	fe843783          	ld	a5,-24(s0)
    8000535e:	08878793          	addi	a5,a5,136
    80005362:	fef43423          	sd	a5,-24(s0)
    80005366:	fe843703          	ld	a4,-24(s0)
    8000536a:	0001f797          	auipc	a5,0x1f
    8000536e:	12678793          	addi	a5,a5,294 # 80024490 <log>
    80005372:	f8f760e3          	bltu	a4,a5,800052f2 <iget+0x38>
  }

  // Recycle an inode entry.
  if(empty == 0)
    80005376:	fe043783          	ld	a5,-32(s0)
    8000537a:	eb89                	bnez	a5,8000538c <iget+0xd2>
    panic("iget: no inodes");
    8000537c:	00006517          	auipc	a0,0x6
    80005380:	13c50513          	addi	a0,a0,316 # 8000b4b8 <etext+0x4b8>
    80005384:	ffffc097          	auipc	ra,0xffffc
    80005388:	8fa080e7          	jalr	-1798(ra) # 80000c7e <panic>

  ip = empty;
    8000538c:	fe043783          	ld	a5,-32(s0)
    80005390:	fef43423          	sd	a5,-24(s0)
  ip->dev = dev;
    80005394:	fe843783          	ld	a5,-24(s0)
    80005398:	fdc42703          	lw	a4,-36(s0)
    8000539c:	c398                	sw	a4,0(a5)
  ip->inum = inum;
    8000539e:	fe843783          	ld	a5,-24(s0)
    800053a2:	fd842703          	lw	a4,-40(s0)
    800053a6:	c3d8                	sw	a4,4(a5)
  ip->ref = 1;
    800053a8:	fe843783          	ld	a5,-24(s0)
    800053ac:	4705                	li	a4,1
    800053ae:	c798                	sw	a4,8(a5)
  ip->valid = 0;
    800053b0:	fe843783          	ld	a5,-24(s0)
    800053b4:	0407a023          	sw	zero,64(a5)
  release(&itable.lock);
    800053b8:	0001d517          	auipc	a0,0x1d
    800053bc:	63050513          	addi	a0,a0,1584 # 800229e8 <itable>
    800053c0:	ffffc097          	auipc	ra,0xffffc
    800053c4:	f12080e7          	jalr	-238(ra) # 800012d2 <release>

  return ip;
    800053c8:	fe843783          	ld	a5,-24(s0)
}
    800053cc:	853e                	mv	a0,a5
    800053ce:	70a2                	ld	ra,40(sp)
    800053d0:	7402                	ld	s0,32(sp)
    800053d2:	6145                	addi	sp,sp,48
    800053d4:	8082                	ret

00000000800053d6 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
    800053d6:	1101                	addi	sp,sp,-32
    800053d8:	ec06                	sd	ra,24(sp)
    800053da:	e822                	sd	s0,16(sp)
    800053dc:	1000                	addi	s0,sp,32
    800053de:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    800053e2:	0001d517          	auipc	a0,0x1d
    800053e6:	60650513          	addi	a0,a0,1542 # 800229e8 <itable>
    800053ea:	ffffc097          	auipc	ra,0xffffc
    800053ee:	e84080e7          	jalr	-380(ra) # 8000126e <acquire>
  ip->ref++;
    800053f2:	fe843783          	ld	a5,-24(s0)
    800053f6:	479c                	lw	a5,8(a5)
    800053f8:	2785                	addiw	a5,a5,1
    800053fa:	0007871b          	sext.w	a4,a5
    800053fe:	fe843783          	ld	a5,-24(s0)
    80005402:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005404:	0001d517          	auipc	a0,0x1d
    80005408:	5e450513          	addi	a0,a0,1508 # 800229e8 <itable>
    8000540c:	ffffc097          	auipc	ra,0xffffc
    80005410:	ec6080e7          	jalr	-314(ra) # 800012d2 <release>
  return ip;
    80005414:	fe843783          	ld	a5,-24(s0)
}
    80005418:	853e                	mv	a0,a5
    8000541a:	60e2                	ld	ra,24(sp)
    8000541c:	6442                	ld	s0,16(sp)
    8000541e:	6105                	addi	sp,sp,32
    80005420:	8082                	ret

0000000080005422 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
    80005422:	7179                	addi	sp,sp,-48
    80005424:	f406                	sd	ra,40(sp)
    80005426:	f022                	sd	s0,32(sp)
    80005428:	1800                	addi	s0,sp,48
    8000542a:	fca43c23          	sd	a0,-40(s0)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    8000542e:	fd843783          	ld	a5,-40(s0)
    80005432:	c791                	beqz	a5,8000543e <ilock+0x1c>
    80005434:	fd843783          	ld	a5,-40(s0)
    80005438:	479c                	lw	a5,8(a5)
    8000543a:	00f04a63          	bgtz	a5,8000544e <ilock+0x2c>
    panic("ilock");
    8000543e:	00006517          	auipc	a0,0x6
    80005442:	08a50513          	addi	a0,a0,138 # 8000b4c8 <etext+0x4c8>
    80005446:	ffffc097          	auipc	ra,0xffffc
    8000544a:	838080e7          	jalr	-1992(ra) # 80000c7e <panic>

  acquiresleep(&ip->lock);
    8000544e:	fd843783          	ld	a5,-40(s0)
    80005452:	07c1                	addi	a5,a5,16
    80005454:	853e                	mv	a0,a5
    80005456:	00001097          	auipc	ra,0x1
    8000545a:	484080e7          	jalr	1156(ra) # 800068da <acquiresleep>

  if(ip->valid == 0){
    8000545e:	fd843783          	ld	a5,-40(s0)
    80005462:	43bc                	lw	a5,64(a5)
    80005464:	e7e5                	bnez	a5,8000554c <ilock+0x12a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80005466:	fd843783          	ld	a5,-40(s0)
    8000546a:	4394                	lw	a3,0(a5)
    8000546c:	fd843783          	ld	a5,-40(s0)
    80005470:	43dc                	lw	a5,4(a5)
    80005472:	0047d79b          	srliw	a5,a5,0x4
    80005476:	0007871b          	sext.w	a4,a5
    8000547a:	0001d797          	auipc	a5,0x1d
    8000547e:	54e78793          	addi	a5,a5,1358 # 800229c8 <sb>
    80005482:	4f9c                	lw	a5,24(a5)
    80005484:	9fb9                	addw	a5,a5,a4
    80005486:	2781                	sext.w	a5,a5
    80005488:	85be                	mv	a1,a5
    8000548a:	8536                	mv	a0,a3
    8000548c:	fffff097          	auipc	ra,0xfffff
    80005490:	5ae080e7          	jalr	1454(ra) # 80004a3a <bread>
    80005494:	fea43423          	sd	a0,-24(s0)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80005498:	fe843783          	ld	a5,-24(s0)
    8000549c:	05878713          	addi	a4,a5,88
    800054a0:	fd843783          	ld	a5,-40(s0)
    800054a4:	43dc                	lw	a5,4(a5)
    800054a6:	1782                	slli	a5,a5,0x20
    800054a8:	9381                	srli	a5,a5,0x20
    800054aa:	8bbd                	andi	a5,a5,15
    800054ac:	079a                	slli	a5,a5,0x6
    800054ae:	97ba                	add	a5,a5,a4
    800054b0:	fef43023          	sd	a5,-32(s0)
    ip->type = dip->type;
    800054b4:	fe043783          	ld	a5,-32(s0)
    800054b8:	00079703          	lh	a4,0(a5)
    800054bc:	fd843783          	ld	a5,-40(s0)
    800054c0:	04e79223          	sh	a4,68(a5)
    ip->major = dip->major;
    800054c4:	fe043783          	ld	a5,-32(s0)
    800054c8:	00279703          	lh	a4,2(a5)
    800054cc:	fd843783          	ld	a5,-40(s0)
    800054d0:	04e79323          	sh	a4,70(a5)
    ip->minor = dip->minor;
    800054d4:	fe043783          	ld	a5,-32(s0)
    800054d8:	00479703          	lh	a4,4(a5)
    800054dc:	fd843783          	ld	a5,-40(s0)
    800054e0:	04e79423          	sh	a4,72(a5)
    ip->nlink = dip->nlink;
    800054e4:	fe043783          	ld	a5,-32(s0)
    800054e8:	00679703          	lh	a4,6(a5)
    800054ec:	fd843783          	ld	a5,-40(s0)
    800054f0:	04e79523          	sh	a4,74(a5)
    ip->size = dip->size;
    800054f4:	fe043783          	ld	a5,-32(s0)
    800054f8:	4798                	lw	a4,8(a5)
    800054fa:	fd843783          	ld	a5,-40(s0)
    800054fe:	c7f8                	sw	a4,76(a5)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80005500:	fd843783          	ld	a5,-40(s0)
    80005504:	05078713          	addi	a4,a5,80
    80005508:	fe043783          	ld	a5,-32(s0)
    8000550c:	07b1                	addi	a5,a5,12
    8000550e:	03400613          	li	a2,52
    80005512:	85be                	mv	a1,a5
    80005514:	853a                	mv	a0,a4
    80005516:	ffffc097          	auipc	ra,0xffffc
    8000551a:	010080e7          	jalr	16(ra) # 80001526 <memmove>
    brelse(bp);
    8000551e:	fe843503          	ld	a0,-24(s0)
    80005522:	fffff097          	auipc	ra,0xfffff
    80005526:	5ba080e7          	jalr	1466(ra) # 80004adc <brelse>
    ip->valid = 1;
    8000552a:	fd843783          	ld	a5,-40(s0)
    8000552e:	4705                	li	a4,1
    80005530:	c3b8                	sw	a4,64(a5)
    if(ip->type == 0)
    80005532:	fd843783          	ld	a5,-40(s0)
    80005536:	04479783          	lh	a5,68(a5)
    8000553a:	eb89                	bnez	a5,8000554c <ilock+0x12a>
      panic("ilock: no type");
    8000553c:	00006517          	auipc	a0,0x6
    80005540:	f9450513          	addi	a0,a0,-108 # 8000b4d0 <etext+0x4d0>
    80005544:	ffffb097          	auipc	ra,0xffffb
    80005548:	73a080e7          	jalr	1850(ra) # 80000c7e <panic>
  }
}
    8000554c:	0001                	nop
    8000554e:	70a2                	ld	ra,40(sp)
    80005550:	7402                	ld	s0,32(sp)
    80005552:	6145                	addi	sp,sp,48
    80005554:	8082                	ret

0000000080005556 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
    80005556:	1101                	addi	sp,sp,-32
    80005558:	ec06                	sd	ra,24(sp)
    8000555a:	e822                	sd	s0,16(sp)
    8000555c:	1000                	addi	s0,sp,32
    8000555e:	fea43423          	sd	a0,-24(s0)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80005562:	fe843783          	ld	a5,-24(s0)
    80005566:	c385                	beqz	a5,80005586 <iunlock+0x30>
    80005568:	fe843783          	ld	a5,-24(s0)
    8000556c:	07c1                	addi	a5,a5,16
    8000556e:	853e                	mv	a0,a5
    80005570:	00001097          	auipc	ra,0x1
    80005574:	42a080e7          	jalr	1066(ra) # 8000699a <holdingsleep>
    80005578:	87aa                	mv	a5,a0
    8000557a:	c791                	beqz	a5,80005586 <iunlock+0x30>
    8000557c:	fe843783          	ld	a5,-24(s0)
    80005580:	479c                	lw	a5,8(a5)
    80005582:	00f04a63          	bgtz	a5,80005596 <iunlock+0x40>
    panic("iunlock");
    80005586:	00006517          	auipc	a0,0x6
    8000558a:	f5a50513          	addi	a0,a0,-166 # 8000b4e0 <etext+0x4e0>
    8000558e:	ffffb097          	auipc	ra,0xffffb
    80005592:	6f0080e7          	jalr	1776(ra) # 80000c7e <panic>

  releasesleep(&ip->lock);
    80005596:	fe843783          	ld	a5,-24(s0)
    8000559a:	07c1                	addi	a5,a5,16
    8000559c:	853e                	mv	a0,a5
    8000559e:	00001097          	auipc	ra,0x1
    800055a2:	3aa080e7          	jalr	938(ra) # 80006948 <releasesleep>
}
    800055a6:	0001                	nop
    800055a8:	60e2                	ld	ra,24(sp)
    800055aa:	6442                	ld	s0,16(sp)
    800055ac:	6105                	addi	sp,sp,32
    800055ae:	8082                	ret

00000000800055b0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
    800055b0:	1101                	addi	sp,sp,-32
    800055b2:	ec06                	sd	ra,24(sp)
    800055b4:	e822                	sd	s0,16(sp)
    800055b6:	1000                	addi	s0,sp,32
    800055b8:	fea43423          	sd	a0,-24(s0)
  acquire(&itable.lock);
    800055bc:	0001d517          	auipc	a0,0x1d
    800055c0:	42c50513          	addi	a0,a0,1068 # 800229e8 <itable>
    800055c4:	ffffc097          	auipc	ra,0xffffc
    800055c8:	caa080e7          	jalr	-854(ra) # 8000126e <acquire>

  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800055cc:	fe843783          	ld	a5,-24(s0)
    800055d0:	479c                	lw	a5,8(a5)
    800055d2:	873e                	mv	a4,a5
    800055d4:	4785                	li	a5,1
    800055d6:	06f71f63          	bne	a4,a5,80005654 <iput+0xa4>
    800055da:	fe843783          	ld	a5,-24(s0)
    800055de:	43bc                	lw	a5,64(a5)
    800055e0:	cbb5                	beqz	a5,80005654 <iput+0xa4>
    800055e2:	fe843783          	ld	a5,-24(s0)
    800055e6:	04a79783          	lh	a5,74(a5)
    800055ea:	e7ad                	bnez	a5,80005654 <iput+0xa4>
    // inode has no links and no other references: truncate and free.

    // ip->ref == 1 means no other process can have ip locked,
    // so this acquiresleep() won't block (or deadlock).
    acquiresleep(&ip->lock);
    800055ec:	fe843783          	ld	a5,-24(s0)
    800055f0:	07c1                	addi	a5,a5,16
    800055f2:	853e                	mv	a0,a5
    800055f4:	00001097          	auipc	ra,0x1
    800055f8:	2e6080e7          	jalr	742(ra) # 800068da <acquiresleep>

    release(&itable.lock);
    800055fc:	0001d517          	auipc	a0,0x1d
    80005600:	3ec50513          	addi	a0,a0,1004 # 800229e8 <itable>
    80005604:	ffffc097          	auipc	ra,0xffffc
    80005608:	cce080e7          	jalr	-818(ra) # 800012d2 <release>

    itrunc(ip);
    8000560c:	fe843503          	ld	a0,-24(s0)
    80005610:	00000097          	auipc	ra,0x0
    80005614:	1fa080e7          	jalr	506(ra) # 8000580a <itrunc>
    ip->type = 0;
    80005618:	fe843783          	ld	a5,-24(s0)
    8000561c:	04079223          	sh	zero,68(a5)
    iupdate(ip);
    80005620:	fe843503          	ld	a0,-24(s0)
    80005624:	00000097          	auipc	ra,0x0
    80005628:	bae080e7          	jalr	-1106(ra) # 800051d2 <iupdate>
    ip->valid = 0;
    8000562c:	fe843783          	ld	a5,-24(s0)
    80005630:	0407a023          	sw	zero,64(a5)

    releasesleep(&ip->lock);
    80005634:	fe843783          	ld	a5,-24(s0)
    80005638:	07c1                	addi	a5,a5,16
    8000563a:	853e                	mv	a0,a5
    8000563c:	00001097          	auipc	ra,0x1
    80005640:	30c080e7          	jalr	780(ra) # 80006948 <releasesleep>

    acquire(&itable.lock);
    80005644:	0001d517          	auipc	a0,0x1d
    80005648:	3a450513          	addi	a0,a0,932 # 800229e8 <itable>
    8000564c:	ffffc097          	auipc	ra,0xffffc
    80005650:	c22080e7          	jalr	-990(ra) # 8000126e <acquire>
  }

  ip->ref--;
    80005654:	fe843783          	ld	a5,-24(s0)
    80005658:	479c                	lw	a5,8(a5)
    8000565a:	37fd                	addiw	a5,a5,-1
    8000565c:	0007871b          	sext.w	a4,a5
    80005660:	fe843783          	ld	a5,-24(s0)
    80005664:	c798                	sw	a4,8(a5)
  release(&itable.lock);
    80005666:	0001d517          	auipc	a0,0x1d
    8000566a:	38250513          	addi	a0,a0,898 # 800229e8 <itable>
    8000566e:	ffffc097          	auipc	ra,0xffffc
    80005672:	c64080e7          	jalr	-924(ra) # 800012d2 <release>
}
    80005676:	0001                	nop
    80005678:	60e2                	ld	ra,24(sp)
    8000567a:	6442                	ld	s0,16(sp)
    8000567c:	6105                	addi	sp,sp,32
    8000567e:	8082                	ret

0000000080005680 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
    80005680:	1101                	addi	sp,sp,-32
    80005682:	ec06                	sd	ra,24(sp)
    80005684:	e822                	sd	s0,16(sp)
    80005686:	1000                	addi	s0,sp,32
    80005688:	fea43423          	sd	a0,-24(s0)
  iunlock(ip);
    8000568c:	fe843503          	ld	a0,-24(s0)
    80005690:	00000097          	auipc	ra,0x0
    80005694:	ec6080e7          	jalr	-314(ra) # 80005556 <iunlock>
  iput(ip);
    80005698:	fe843503          	ld	a0,-24(s0)
    8000569c:	00000097          	auipc	ra,0x0
    800056a0:	f14080e7          	jalr	-236(ra) # 800055b0 <iput>
}
    800056a4:	0001                	nop
    800056a6:	60e2                	ld	ra,24(sp)
    800056a8:	6442                	ld	s0,16(sp)
    800056aa:	6105                	addi	sp,sp,32
    800056ac:	8082                	ret

00000000800056ae <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    800056ae:	7139                	addi	sp,sp,-64
    800056b0:	fc06                	sd	ra,56(sp)
    800056b2:	f822                	sd	s0,48(sp)
    800056b4:	0080                	addi	s0,sp,64
    800056b6:	fca43423          	sd	a0,-56(s0)
    800056ba:	87ae                	mv	a5,a1
    800056bc:	fcf42223          	sw	a5,-60(s0)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800056c0:	fc442783          	lw	a5,-60(s0)
    800056c4:	0007871b          	sext.w	a4,a5
    800056c8:	47ad                	li	a5,11
    800056ca:	04e7e863          	bltu	a5,a4,8000571a <bmap+0x6c>
    if((addr = ip->addrs[bn]) == 0)
    800056ce:	fc843703          	ld	a4,-56(s0)
    800056d2:	fc446783          	lwu	a5,-60(s0)
    800056d6:	07d1                	addi	a5,a5,20
    800056d8:	078a                	slli	a5,a5,0x2
    800056da:	97ba                	add	a5,a5,a4
    800056dc:	439c                	lw	a5,0(a5)
    800056de:	fef42623          	sw	a5,-20(s0)
    800056e2:	fec42783          	lw	a5,-20(s0)
    800056e6:	2781                	sext.w	a5,a5
    800056e8:	e795                	bnez	a5,80005714 <bmap+0x66>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800056ea:	fc843783          	ld	a5,-56(s0)
    800056ee:	439c                	lw	a5,0(a5)
    800056f0:	853e                	mv	a0,a5
    800056f2:	fffff097          	auipc	ra,0xfffff
    800056f6:	692080e7          	jalr	1682(ra) # 80004d84 <balloc>
    800056fa:	87aa                	mv	a5,a0
    800056fc:	fef42623          	sw	a5,-20(s0)
    80005700:	fc843703          	ld	a4,-56(s0)
    80005704:	fc446783          	lwu	a5,-60(s0)
    80005708:	07d1                	addi	a5,a5,20
    8000570a:	078a                	slli	a5,a5,0x2
    8000570c:	97ba                	add	a5,a5,a4
    8000570e:	fec42703          	lw	a4,-20(s0)
    80005712:	c398                	sw	a4,0(a5)
    return addr;
    80005714:	fec42783          	lw	a5,-20(s0)
    80005718:	a0e5                	j	80005800 <bmap+0x152>
  }
  bn -= NDIRECT;
    8000571a:	fc442783          	lw	a5,-60(s0)
    8000571e:	37d1                	addiw	a5,a5,-12
    80005720:	fcf42223          	sw	a5,-60(s0)

  if(bn < NINDIRECT){
    80005724:	fc442783          	lw	a5,-60(s0)
    80005728:	0007871b          	sext.w	a4,a5
    8000572c:	0ff00793          	li	a5,255
    80005730:	0ce7e063          	bltu	a5,a4,800057f0 <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80005734:	fc843783          	ld	a5,-56(s0)
    80005738:	0807a783          	lw	a5,128(a5)
    8000573c:	fef42623          	sw	a5,-20(s0)
    80005740:	fec42783          	lw	a5,-20(s0)
    80005744:	2781                	sext.w	a5,a5
    80005746:	e395                	bnez	a5,8000576a <bmap+0xbc>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80005748:	fc843783          	ld	a5,-56(s0)
    8000574c:	439c                	lw	a5,0(a5)
    8000574e:	853e                	mv	a0,a5
    80005750:	fffff097          	auipc	ra,0xfffff
    80005754:	634080e7          	jalr	1588(ra) # 80004d84 <balloc>
    80005758:	87aa                	mv	a5,a0
    8000575a:	fef42623          	sw	a5,-20(s0)
    8000575e:	fc843783          	ld	a5,-56(s0)
    80005762:	fec42703          	lw	a4,-20(s0)
    80005766:	08e7a023          	sw	a4,128(a5)
    bp = bread(ip->dev, addr);
    8000576a:	fc843783          	ld	a5,-56(s0)
    8000576e:	439c                	lw	a5,0(a5)
    80005770:	fec42703          	lw	a4,-20(s0)
    80005774:	85ba                	mv	a1,a4
    80005776:	853e                	mv	a0,a5
    80005778:	fffff097          	auipc	ra,0xfffff
    8000577c:	2c2080e7          	jalr	706(ra) # 80004a3a <bread>
    80005780:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    80005784:	fe043783          	ld	a5,-32(s0)
    80005788:	05878793          	addi	a5,a5,88
    8000578c:	fcf43c23          	sd	a5,-40(s0)
    if((addr = a[bn]) == 0){
    80005790:	fc446783          	lwu	a5,-60(s0)
    80005794:	078a                	slli	a5,a5,0x2
    80005796:	fd843703          	ld	a4,-40(s0)
    8000579a:	97ba                	add	a5,a5,a4
    8000579c:	439c                	lw	a5,0(a5)
    8000579e:	fef42623          	sw	a5,-20(s0)
    800057a2:	fec42783          	lw	a5,-20(s0)
    800057a6:	2781                	sext.w	a5,a5
    800057a8:	eb9d                	bnez	a5,800057de <bmap+0x130>
      a[bn] = addr = balloc(ip->dev);
    800057aa:	fc843783          	ld	a5,-56(s0)
    800057ae:	439c                	lw	a5,0(a5)
    800057b0:	853e                	mv	a0,a5
    800057b2:	fffff097          	auipc	ra,0xfffff
    800057b6:	5d2080e7          	jalr	1490(ra) # 80004d84 <balloc>
    800057ba:	87aa                	mv	a5,a0
    800057bc:	fef42623          	sw	a5,-20(s0)
    800057c0:	fc446783          	lwu	a5,-60(s0)
    800057c4:	078a                	slli	a5,a5,0x2
    800057c6:	fd843703          	ld	a4,-40(s0)
    800057ca:	97ba                	add	a5,a5,a4
    800057cc:	fec42703          	lw	a4,-20(s0)
    800057d0:	c398                	sw	a4,0(a5)
      log_write(bp);
    800057d2:	fe043503          	ld	a0,-32(s0)
    800057d6:	00001097          	auipc	ra,0x1
    800057da:	f84080e7          	jalr	-124(ra) # 8000675a <log_write>
    }
    brelse(bp);
    800057de:	fe043503          	ld	a0,-32(s0)
    800057e2:	fffff097          	auipc	ra,0xfffff
    800057e6:	2fa080e7          	jalr	762(ra) # 80004adc <brelse>
    return addr;
    800057ea:	fec42783          	lw	a5,-20(s0)
    800057ee:	a809                	j	80005800 <bmap+0x152>
  }

  panic("bmap: out of range");
    800057f0:	00006517          	auipc	a0,0x6
    800057f4:	cf850513          	addi	a0,a0,-776 # 8000b4e8 <etext+0x4e8>
    800057f8:	ffffb097          	auipc	ra,0xffffb
    800057fc:	486080e7          	jalr	1158(ra) # 80000c7e <panic>
}
    80005800:	853e                	mv	a0,a5
    80005802:	70e2                	ld	ra,56(sp)
    80005804:	7442                	ld	s0,48(sp)
    80005806:	6121                	addi	sp,sp,64
    80005808:	8082                	ret

000000008000580a <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    8000580a:	7139                	addi	sp,sp,-64
    8000580c:	fc06                	sd	ra,56(sp)
    8000580e:	f822                	sd	s0,48(sp)
    80005810:	0080                	addi	s0,sp,64
    80005812:	fca43423          	sd	a0,-56(s0)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80005816:	fe042623          	sw	zero,-20(s0)
    8000581a:	a899                	j	80005870 <itrunc+0x66>
    if(ip->addrs[i]){
    8000581c:	fc843703          	ld	a4,-56(s0)
    80005820:	fec42783          	lw	a5,-20(s0)
    80005824:	07d1                	addi	a5,a5,20
    80005826:	078a                	slli	a5,a5,0x2
    80005828:	97ba                	add	a5,a5,a4
    8000582a:	439c                	lw	a5,0(a5)
    8000582c:	cf8d                	beqz	a5,80005866 <itrunc+0x5c>
      bfree(ip->dev, ip->addrs[i]);
    8000582e:	fc843783          	ld	a5,-56(s0)
    80005832:	439c                	lw	a5,0(a5)
    80005834:	0007869b          	sext.w	a3,a5
    80005838:	fc843703          	ld	a4,-56(s0)
    8000583c:	fec42783          	lw	a5,-20(s0)
    80005840:	07d1                	addi	a5,a5,20
    80005842:	078a                	slli	a5,a5,0x2
    80005844:	97ba                	add	a5,a5,a4
    80005846:	439c                	lw	a5,0(a5)
    80005848:	85be                	mv	a1,a5
    8000584a:	8536                	mv	a0,a3
    8000584c:	fffff097          	auipc	ra,0xfffff
    80005850:	6e6080e7          	jalr	1766(ra) # 80004f32 <bfree>
      ip->addrs[i] = 0;
    80005854:	fc843703          	ld	a4,-56(s0)
    80005858:	fec42783          	lw	a5,-20(s0)
    8000585c:	07d1                	addi	a5,a5,20
    8000585e:	078a                	slli	a5,a5,0x2
    80005860:	97ba                	add	a5,a5,a4
    80005862:	0007a023          	sw	zero,0(a5)
  for(i = 0; i < NDIRECT; i++){
    80005866:	fec42783          	lw	a5,-20(s0)
    8000586a:	2785                	addiw	a5,a5,1
    8000586c:	fef42623          	sw	a5,-20(s0)
    80005870:	fec42783          	lw	a5,-20(s0)
    80005874:	0007871b          	sext.w	a4,a5
    80005878:	47ad                	li	a5,11
    8000587a:	fae7d1e3          	bge	a5,a4,8000581c <itrunc+0x12>
    }
  }

  if(ip->addrs[NDIRECT]){
    8000587e:	fc843783          	ld	a5,-56(s0)
    80005882:	0807a783          	lw	a5,128(a5)
    80005886:	cbc5                	beqz	a5,80005936 <itrunc+0x12c>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80005888:	fc843783          	ld	a5,-56(s0)
    8000588c:	4398                	lw	a4,0(a5)
    8000588e:	fc843783          	ld	a5,-56(s0)
    80005892:	0807a783          	lw	a5,128(a5)
    80005896:	85be                	mv	a1,a5
    80005898:	853a                	mv	a0,a4
    8000589a:	fffff097          	auipc	ra,0xfffff
    8000589e:	1a0080e7          	jalr	416(ra) # 80004a3a <bread>
    800058a2:	fea43023          	sd	a0,-32(s0)
    a = (uint*)bp->data;
    800058a6:	fe043783          	ld	a5,-32(s0)
    800058aa:	05878793          	addi	a5,a5,88
    800058ae:	fcf43c23          	sd	a5,-40(s0)
    for(j = 0; j < NINDIRECT; j++){
    800058b2:	fe042423          	sw	zero,-24(s0)
    800058b6:	a081                	j	800058f6 <itrunc+0xec>
      if(a[j])
    800058b8:	fe842783          	lw	a5,-24(s0)
    800058bc:	078a                	slli	a5,a5,0x2
    800058be:	fd843703          	ld	a4,-40(s0)
    800058c2:	97ba                	add	a5,a5,a4
    800058c4:	439c                	lw	a5,0(a5)
    800058c6:	c39d                	beqz	a5,800058ec <itrunc+0xe2>
        bfree(ip->dev, a[j]);
    800058c8:	fc843783          	ld	a5,-56(s0)
    800058cc:	439c                	lw	a5,0(a5)
    800058ce:	0007869b          	sext.w	a3,a5
    800058d2:	fe842783          	lw	a5,-24(s0)
    800058d6:	078a                	slli	a5,a5,0x2
    800058d8:	fd843703          	ld	a4,-40(s0)
    800058dc:	97ba                	add	a5,a5,a4
    800058de:	439c                	lw	a5,0(a5)
    800058e0:	85be                	mv	a1,a5
    800058e2:	8536                	mv	a0,a3
    800058e4:	fffff097          	auipc	ra,0xfffff
    800058e8:	64e080e7          	jalr	1614(ra) # 80004f32 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    800058ec:	fe842783          	lw	a5,-24(s0)
    800058f0:	2785                	addiw	a5,a5,1
    800058f2:	fef42423          	sw	a5,-24(s0)
    800058f6:	fe842783          	lw	a5,-24(s0)
    800058fa:	873e                	mv	a4,a5
    800058fc:	0ff00793          	li	a5,255
    80005900:	fae7fce3          	bgeu	a5,a4,800058b8 <itrunc+0xae>
    }
    brelse(bp);
    80005904:	fe043503          	ld	a0,-32(s0)
    80005908:	fffff097          	auipc	ra,0xfffff
    8000590c:	1d4080e7          	jalr	468(ra) # 80004adc <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80005910:	fc843783          	ld	a5,-56(s0)
    80005914:	439c                	lw	a5,0(a5)
    80005916:	0007871b          	sext.w	a4,a5
    8000591a:	fc843783          	ld	a5,-56(s0)
    8000591e:	0807a783          	lw	a5,128(a5)
    80005922:	85be                	mv	a1,a5
    80005924:	853a                	mv	a0,a4
    80005926:	fffff097          	auipc	ra,0xfffff
    8000592a:	60c080e7          	jalr	1548(ra) # 80004f32 <bfree>
    ip->addrs[NDIRECT] = 0;
    8000592e:	fc843783          	ld	a5,-56(s0)
    80005932:	0807a023          	sw	zero,128(a5)
  }

  ip->size = 0;
    80005936:	fc843783          	ld	a5,-56(s0)
    8000593a:	0407a623          	sw	zero,76(a5)
  iupdate(ip);
    8000593e:	fc843503          	ld	a0,-56(s0)
    80005942:	00000097          	auipc	ra,0x0
    80005946:	890080e7          	jalr	-1904(ra) # 800051d2 <iupdate>
}
    8000594a:	0001                	nop
    8000594c:	70e2                	ld	ra,56(sp)
    8000594e:	7442                	ld	s0,48(sp)
    80005950:	6121                	addi	sp,sp,64
    80005952:	8082                	ret

0000000080005954 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80005954:	1101                	addi	sp,sp,-32
    80005956:	ec22                	sd	s0,24(sp)
    80005958:	1000                	addi	s0,sp,32
    8000595a:	fea43423          	sd	a0,-24(s0)
    8000595e:	feb43023          	sd	a1,-32(s0)
  st->dev = ip->dev;
    80005962:	fe843783          	ld	a5,-24(s0)
    80005966:	439c                	lw	a5,0(a5)
    80005968:	0007871b          	sext.w	a4,a5
    8000596c:	fe043783          	ld	a5,-32(s0)
    80005970:	c398                	sw	a4,0(a5)
  st->ino = ip->inum;
    80005972:	fe843783          	ld	a5,-24(s0)
    80005976:	43d8                	lw	a4,4(a5)
    80005978:	fe043783          	ld	a5,-32(s0)
    8000597c:	c3d8                	sw	a4,4(a5)
  st->type = ip->type;
    8000597e:	fe843783          	ld	a5,-24(s0)
    80005982:	04479703          	lh	a4,68(a5)
    80005986:	fe043783          	ld	a5,-32(s0)
    8000598a:	00e79423          	sh	a4,8(a5)
  st->nlink = ip->nlink;
    8000598e:	fe843783          	ld	a5,-24(s0)
    80005992:	04a79703          	lh	a4,74(a5)
    80005996:	fe043783          	ld	a5,-32(s0)
    8000599a:	00e79523          	sh	a4,10(a5)
  st->size = ip->size;
    8000599e:	fe843783          	ld	a5,-24(s0)
    800059a2:	47fc                	lw	a5,76(a5)
    800059a4:	02079713          	slli	a4,a5,0x20
    800059a8:	9301                	srli	a4,a4,0x20
    800059aa:	fe043783          	ld	a5,-32(s0)
    800059ae:	eb98                	sd	a4,16(a5)
}
    800059b0:	0001                	nop
    800059b2:	6462                	ld	s0,24(sp)
    800059b4:	6105                	addi	sp,sp,32
    800059b6:	8082                	ret

00000000800059b8 <readi>:
// Caller must hold ip->lock.
// If user_dst==1, then dst is a user virtual address;
// otherwise, dst is a kernel address.
int
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
    800059b8:	711d                	addi	sp,sp,-96
    800059ba:	ec86                	sd	ra,88(sp)
    800059bc:	e8a2                	sd	s0,80(sp)
    800059be:	e4a6                	sd	s1,72(sp)
    800059c0:	1080                	addi	s0,sp,96
    800059c2:	faa43c23          	sd	a0,-72(s0)
    800059c6:	87ae                	mv	a5,a1
    800059c8:	fac43423          	sd	a2,-88(s0)
    800059cc:	faf42a23          	sw	a5,-76(s0)
    800059d0:	87b6                	mv	a5,a3
    800059d2:	faf42823          	sw	a5,-80(s0)
    800059d6:	87ba                	mv	a5,a4
    800059d8:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800059dc:	fb843783          	ld	a5,-72(s0)
    800059e0:	47f8                	lw	a4,76(a5)
    800059e2:	fb042783          	lw	a5,-80(s0)
    800059e6:	2781                	sext.w	a5,a5
    800059e8:	00f76e63          	bltu	a4,a5,80005a04 <readi+0x4c>
    800059ec:	fb042703          	lw	a4,-80(s0)
    800059f0:	fa442783          	lw	a5,-92(s0)
    800059f4:	9fb9                	addw	a5,a5,a4
    800059f6:	0007871b          	sext.w	a4,a5
    800059fa:	fb042783          	lw	a5,-80(s0)
    800059fe:	2781                	sext.w	a5,a5
    80005a00:	00f77463          	bgeu	a4,a5,80005a08 <readi+0x50>
    return 0;
    80005a04:	4781                	li	a5,0
    80005a06:	aa05                	j	80005b36 <readi+0x17e>
  if(off + n > ip->size)
    80005a08:	fb042703          	lw	a4,-80(s0)
    80005a0c:	fa442783          	lw	a5,-92(s0)
    80005a10:	9fb9                	addw	a5,a5,a4
    80005a12:	0007871b          	sext.w	a4,a5
    80005a16:	fb843783          	ld	a5,-72(s0)
    80005a1a:	47fc                	lw	a5,76(a5)
    80005a1c:	00e7fb63          	bgeu	a5,a4,80005a32 <readi+0x7a>
    n = ip->size - off;
    80005a20:	fb843783          	ld	a5,-72(s0)
    80005a24:	47f8                	lw	a4,76(a5)
    80005a26:	fb042783          	lw	a5,-80(s0)
    80005a2a:	40f707bb          	subw	a5,a4,a5
    80005a2e:	faf42223          	sw	a5,-92(s0)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005a32:	fc042e23          	sw	zero,-36(s0)
    80005a36:	a0f5                	j	80005b22 <readi+0x16a>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80005a38:	fb843783          	ld	a5,-72(s0)
    80005a3c:	4384                	lw	s1,0(a5)
    80005a3e:	fb042783          	lw	a5,-80(s0)
    80005a42:	00a7d79b          	srliw	a5,a5,0xa
    80005a46:	2781                	sext.w	a5,a5
    80005a48:	85be                	mv	a1,a5
    80005a4a:	fb843503          	ld	a0,-72(s0)
    80005a4e:	00000097          	auipc	ra,0x0
    80005a52:	c60080e7          	jalr	-928(ra) # 800056ae <bmap>
    80005a56:	87aa                	mv	a5,a0
    80005a58:	2781                	sext.w	a5,a5
    80005a5a:	85be                	mv	a1,a5
    80005a5c:	8526                	mv	a0,s1
    80005a5e:	fffff097          	auipc	ra,0xfffff
    80005a62:	fdc080e7          	jalr	-36(ra) # 80004a3a <bread>
    80005a66:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005a6a:	fb042783          	lw	a5,-80(s0)
    80005a6e:	3ff7f793          	andi	a5,a5,1023
    80005a72:	2781                	sext.w	a5,a5
    80005a74:	40000713          	li	a4,1024
    80005a78:	40f707bb          	subw	a5,a4,a5
    80005a7c:	0007869b          	sext.w	a3,a5
    80005a80:	fa442703          	lw	a4,-92(s0)
    80005a84:	fdc42783          	lw	a5,-36(s0)
    80005a88:	40f707bb          	subw	a5,a4,a5
    80005a8c:	2781                	sext.w	a5,a5
    80005a8e:	863e                	mv	a2,a5
    80005a90:	87b6                	mv	a5,a3
    80005a92:	0007869b          	sext.w	a3,a5
    80005a96:	0006071b          	sext.w	a4,a2
    80005a9a:	00d77363          	bgeu	a4,a3,80005aa0 <readi+0xe8>
    80005a9e:	87b2                	mv	a5,a2
    80005aa0:	fcf42623          	sw	a5,-52(s0)
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80005aa4:	fd043783          	ld	a5,-48(s0)
    80005aa8:	05878713          	addi	a4,a5,88
    80005aac:	fb046783          	lwu	a5,-80(s0)
    80005ab0:	3ff7f793          	andi	a5,a5,1023
    80005ab4:	973e                	add	a4,a4,a5
    80005ab6:	fcc46683          	lwu	a3,-52(s0)
    80005aba:	fb442783          	lw	a5,-76(s0)
    80005abe:	863a                	mv	a2,a4
    80005ac0:	fa843583          	ld	a1,-88(s0)
    80005ac4:	853e                	mv	a0,a5
    80005ac6:	ffffe097          	auipc	ra,0xffffe
    80005aca:	c5a080e7          	jalr	-934(ra) # 80003720 <either_copyout>
    80005ace:	87aa                	mv	a5,a0
    80005ad0:	873e                	mv	a4,a5
    80005ad2:	57fd                	li	a5,-1
    80005ad4:	00f71c63          	bne	a4,a5,80005aec <readi+0x134>
      brelse(bp);
    80005ad8:	fd043503          	ld	a0,-48(s0)
    80005adc:	fffff097          	auipc	ra,0xfffff
    80005ae0:	000080e7          	jalr	ra # 80004adc <brelse>
      tot = -1;
    80005ae4:	57fd                	li	a5,-1
    80005ae6:	fcf42e23          	sw	a5,-36(s0)
      break;
    80005aea:	a0a1                	j	80005b32 <readi+0x17a>
    }
    brelse(bp);
    80005aec:	fd043503          	ld	a0,-48(s0)
    80005af0:	fffff097          	auipc	ra,0xfffff
    80005af4:	fec080e7          	jalr	-20(ra) # 80004adc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80005af8:	fdc42703          	lw	a4,-36(s0)
    80005afc:	fcc42783          	lw	a5,-52(s0)
    80005b00:	9fb9                	addw	a5,a5,a4
    80005b02:	fcf42e23          	sw	a5,-36(s0)
    80005b06:	fb042703          	lw	a4,-80(s0)
    80005b0a:	fcc42783          	lw	a5,-52(s0)
    80005b0e:	9fb9                	addw	a5,a5,a4
    80005b10:	faf42823          	sw	a5,-80(s0)
    80005b14:	fcc46783          	lwu	a5,-52(s0)
    80005b18:	fa843703          	ld	a4,-88(s0)
    80005b1c:	97ba                	add	a5,a5,a4
    80005b1e:	faf43423          	sd	a5,-88(s0)
    80005b22:	fdc42703          	lw	a4,-36(s0)
    80005b26:	fa442783          	lw	a5,-92(s0)
    80005b2a:	2701                	sext.w	a4,a4
    80005b2c:	2781                	sext.w	a5,a5
    80005b2e:	f0f765e3          	bltu	a4,a5,80005a38 <readi+0x80>
  }
  return tot;
    80005b32:	fdc42783          	lw	a5,-36(s0)
}
    80005b36:	853e                	mv	a0,a5
    80005b38:	60e6                	ld	ra,88(sp)
    80005b3a:	6446                	ld	s0,80(sp)
    80005b3c:	64a6                	ld	s1,72(sp)
    80005b3e:	6125                	addi	sp,sp,96
    80005b40:	8082                	ret

0000000080005b42 <writei>:
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80005b42:	711d                	addi	sp,sp,-96
    80005b44:	ec86                	sd	ra,88(sp)
    80005b46:	e8a2                	sd	s0,80(sp)
    80005b48:	e4a6                	sd	s1,72(sp)
    80005b4a:	1080                	addi	s0,sp,96
    80005b4c:	faa43c23          	sd	a0,-72(s0)
    80005b50:	87ae                	mv	a5,a1
    80005b52:	fac43423          	sd	a2,-88(s0)
    80005b56:	faf42a23          	sw	a5,-76(s0)
    80005b5a:	87b6                	mv	a5,a3
    80005b5c:	faf42823          	sw	a5,-80(s0)
    80005b60:	87ba                	mv	a5,a4
    80005b62:	faf42223          	sw	a5,-92(s0)
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80005b66:	fb843783          	ld	a5,-72(s0)
    80005b6a:	47f8                	lw	a4,76(a5)
    80005b6c:	fb042783          	lw	a5,-80(s0)
    80005b70:	2781                	sext.w	a5,a5
    80005b72:	00f76e63          	bltu	a4,a5,80005b8e <writei+0x4c>
    80005b76:	fb042703          	lw	a4,-80(s0)
    80005b7a:	fa442783          	lw	a5,-92(s0)
    80005b7e:	9fb9                	addw	a5,a5,a4
    80005b80:	0007871b          	sext.w	a4,a5
    80005b84:	fb042783          	lw	a5,-80(s0)
    80005b88:	2781                	sext.w	a5,a5
    80005b8a:	00f77463          	bgeu	a4,a5,80005b92 <writei+0x50>
    return -1;
    80005b8e:	57fd                	li	a5,-1
    80005b90:	a2b1                	j	80005cdc <writei+0x19a>
  if(off + n > MAXFILE*BSIZE)
    80005b92:	fb042703          	lw	a4,-80(s0)
    80005b96:	fa442783          	lw	a5,-92(s0)
    80005b9a:	9fb9                	addw	a5,a5,a4
    80005b9c:	2781                	sext.w	a5,a5
    80005b9e:	873e                	mv	a4,a5
    80005ba0:	000437b7          	lui	a5,0x43
    80005ba4:	00e7f463          	bgeu	a5,a4,80005bac <writei+0x6a>
    return -1;
    80005ba8:	57fd                	li	a5,-1
    80005baa:	aa0d                	j	80005cdc <writei+0x19a>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005bac:	fc042e23          	sw	zero,-36(s0)
    80005bb0:	a8cd                	j	80005ca2 <writei+0x160>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80005bb2:	fb843783          	ld	a5,-72(s0)
    80005bb6:	4384                	lw	s1,0(a5)
    80005bb8:	fb042783          	lw	a5,-80(s0)
    80005bbc:	00a7d79b          	srliw	a5,a5,0xa
    80005bc0:	2781                	sext.w	a5,a5
    80005bc2:	85be                	mv	a1,a5
    80005bc4:	fb843503          	ld	a0,-72(s0)
    80005bc8:	00000097          	auipc	ra,0x0
    80005bcc:	ae6080e7          	jalr	-1306(ra) # 800056ae <bmap>
    80005bd0:	87aa                	mv	a5,a0
    80005bd2:	2781                	sext.w	a5,a5
    80005bd4:	85be                	mv	a1,a5
    80005bd6:	8526                	mv	a0,s1
    80005bd8:	fffff097          	auipc	ra,0xfffff
    80005bdc:	e62080e7          	jalr	-414(ra) # 80004a3a <bread>
    80005be0:	fca43823          	sd	a0,-48(s0)
    m = min(n - tot, BSIZE - off%BSIZE);
    80005be4:	fb042783          	lw	a5,-80(s0)
    80005be8:	3ff7f793          	andi	a5,a5,1023
    80005bec:	2781                	sext.w	a5,a5
    80005bee:	40000713          	li	a4,1024
    80005bf2:	40f707bb          	subw	a5,a4,a5
    80005bf6:	0007869b          	sext.w	a3,a5
    80005bfa:	fa442703          	lw	a4,-92(s0)
    80005bfe:	fdc42783          	lw	a5,-36(s0)
    80005c02:	40f707bb          	subw	a5,a4,a5
    80005c06:	2781                	sext.w	a5,a5
    80005c08:	863e                	mv	a2,a5
    80005c0a:	87b6                	mv	a5,a3
    80005c0c:	0007869b          	sext.w	a3,a5
    80005c10:	0006071b          	sext.w	a4,a2
    80005c14:	00d77363          	bgeu	a4,a3,80005c1a <writei+0xd8>
    80005c18:	87b2                	mv	a5,a2
    80005c1a:	fcf42623          	sw	a5,-52(s0)
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80005c1e:	fd043783          	ld	a5,-48(s0)
    80005c22:	05878713          	addi	a4,a5,88 # 43058 <_entry-0x7ffbcfa8>
    80005c26:	fb046783          	lwu	a5,-80(s0)
    80005c2a:	3ff7f793          	andi	a5,a5,1023
    80005c2e:	97ba                	add	a5,a5,a4
    80005c30:	fcc46683          	lwu	a3,-52(s0)
    80005c34:	fb442703          	lw	a4,-76(s0)
    80005c38:	fa843603          	ld	a2,-88(s0)
    80005c3c:	85ba                	mv	a1,a4
    80005c3e:	853e                	mv	a0,a5
    80005c40:	ffffe097          	auipc	ra,0xffffe
    80005c44:	b54080e7          	jalr	-1196(ra) # 80003794 <either_copyin>
    80005c48:	87aa                	mv	a5,a0
    80005c4a:	873e                	mv	a4,a5
    80005c4c:	57fd                	li	a5,-1
    80005c4e:	00f71963          	bne	a4,a5,80005c60 <writei+0x11e>
      brelse(bp);
    80005c52:	fd043503          	ld	a0,-48(s0)
    80005c56:	fffff097          	auipc	ra,0xfffff
    80005c5a:	e86080e7          	jalr	-378(ra) # 80004adc <brelse>
      break;
    80005c5e:	a891                	j	80005cb2 <writei+0x170>
    }
    log_write(bp);
    80005c60:	fd043503          	ld	a0,-48(s0)
    80005c64:	00001097          	auipc	ra,0x1
    80005c68:	af6080e7          	jalr	-1290(ra) # 8000675a <log_write>
    brelse(bp);
    80005c6c:	fd043503          	ld	a0,-48(s0)
    80005c70:	fffff097          	auipc	ra,0xfffff
    80005c74:	e6c080e7          	jalr	-404(ra) # 80004adc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80005c78:	fdc42703          	lw	a4,-36(s0)
    80005c7c:	fcc42783          	lw	a5,-52(s0)
    80005c80:	9fb9                	addw	a5,a5,a4
    80005c82:	fcf42e23          	sw	a5,-36(s0)
    80005c86:	fb042703          	lw	a4,-80(s0)
    80005c8a:	fcc42783          	lw	a5,-52(s0)
    80005c8e:	9fb9                	addw	a5,a5,a4
    80005c90:	faf42823          	sw	a5,-80(s0)
    80005c94:	fcc46783          	lwu	a5,-52(s0)
    80005c98:	fa843703          	ld	a4,-88(s0)
    80005c9c:	97ba                	add	a5,a5,a4
    80005c9e:	faf43423          	sd	a5,-88(s0)
    80005ca2:	fdc42703          	lw	a4,-36(s0)
    80005ca6:	fa442783          	lw	a5,-92(s0)
    80005caa:	2701                	sext.w	a4,a4
    80005cac:	2781                	sext.w	a5,a5
    80005cae:	f0f762e3          	bltu	a4,a5,80005bb2 <writei+0x70>
  }

  if(off > ip->size)
    80005cb2:	fb843783          	ld	a5,-72(s0)
    80005cb6:	47f8                	lw	a4,76(a5)
    80005cb8:	fb042783          	lw	a5,-80(s0)
    80005cbc:	2781                	sext.w	a5,a5
    80005cbe:	00f77763          	bgeu	a4,a5,80005ccc <writei+0x18a>
    ip->size = off;
    80005cc2:	fb843783          	ld	a5,-72(s0)
    80005cc6:	fb042703          	lw	a4,-80(s0)
    80005cca:	c7f8                	sw	a4,76(a5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80005ccc:	fb843503          	ld	a0,-72(s0)
    80005cd0:	fffff097          	auipc	ra,0xfffff
    80005cd4:	502080e7          	jalr	1282(ra) # 800051d2 <iupdate>

  return tot;
    80005cd8:	fdc42783          	lw	a5,-36(s0)
}
    80005cdc:	853e                	mv	a0,a5
    80005cde:	60e6                	ld	ra,88(sp)
    80005ce0:	6446                	ld	s0,80(sp)
    80005ce2:	64a6                	ld	s1,72(sp)
    80005ce4:	6125                	addi	sp,sp,96
    80005ce6:	8082                	ret

0000000080005ce8 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80005ce8:	1101                	addi	sp,sp,-32
    80005cea:	ec06                	sd	ra,24(sp)
    80005cec:	e822                	sd	s0,16(sp)
    80005cee:	1000                	addi	s0,sp,32
    80005cf0:	fea43423          	sd	a0,-24(s0)
    80005cf4:	feb43023          	sd	a1,-32(s0)
  return strncmp(s, t, DIRSIZ);
    80005cf8:	4639                	li	a2,14
    80005cfa:	fe043583          	ld	a1,-32(s0)
    80005cfe:	fe843503          	ld	a0,-24(s0)
    80005d02:	ffffc097          	auipc	ra,0xffffc
    80005d06:	938080e7          	jalr	-1736(ra) # 8000163a <strncmp>
    80005d0a:	87aa                	mv	a5,a0
}
    80005d0c:	853e                	mv	a0,a5
    80005d0e:	60e2                	ld	ra,24(sp)
    80005d10:	6442                	ld	s0,16(sp)
    80005d12:	6105                	addi	sp,sp,32
    80005d14:	8082                	ret

0000000080005d16 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80005d16:	715d                	addi	sp,sp,-80
    80005d18:	e486                	sd	ra,72(sp)
    80005d1a:	e0a2                	sd	s0,64(sp)
    80005d1c:	0880                	addi	s0,sp,80
    80005d1e:	fca43423          	sd	a0,-56(s0)
    80005d22:	fcb43023          	sd	a1,-64(s0)
    80005d26:	fac43c23          	sd	a2,-72(s0)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80005d2a:	fc843783          	ld	a5,-56(s0)
    80005d2e:	04479783          	lh	a5,68(a5)
    80005d32:	0007871b          	sext.w	a4,a5
    80005d36:	4785                	li	a5,1
    80005d38:	00f70a63          	beq	a4,a5,80005d4c <dirlookup+0x36>
    panic("dirlookup not DIR");
    80005d3c:	00005517          	auipc	a0,0x5
    80005d40:	7c450513          	addi	a0,a0,1988 # 8000b500 <etext+0x500>
    80005d44:	ffffb097          	auipc	ra,0xffffb
    80005d48:	f3a080e7          	jalr	-198(ra) # 80000c7e <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
    80005d4c:	fe042623          	sw	zero,-20(s0)
    80005d50:	a849                	j	80005de2 <dirlookup+0xcc>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005d52:	fd840793          	addi	a5,s0,-40
    80005d56:	fec42683          	lw	a3,-20(s0)
    80005d5a:	4741                	li	a4,16
    80005d5c:	863e                	mv	a2,a5
    80005d5e:	4581                	li	a1,0
    80005d60:	fc843503          	ld	a0,-56(s0)
    80005d64:	00000097          	auipc	ra,0x0
    80005d68:	c54080e7          	jalr	-940(ra) # 800059b8 <readi>
    80005d6c:	87aa                	mv	a5,a0
    80005d6e:	873e                	mv	a4,a5
    80005d70:	47c1                	li	a5,16
    80005d72:	00f70a63          	beq	a4,a5,80005d86 <dirlookup+0x70>
      panic("dirlookup read");
    80005d76:	00005517          	auipc	a0,0x5
    80005d7a:	7a250513          	addi	a0,a0,1954 # 8000b518 <etext+0x518>
    80005d7e:	ffffb097          	auipc	ra,0xffffb
    80005d82:	f00080e7          	jalr	-256(ra) # 80000c7e <panic>
    if(de.inum == 0)
    80005d86:	fd845783          	lhu	a5,-40(s0)
    80005d8a:	c7b1                	beqz	a5,80005dd6 <dirlookup+0xc0>
      continue;
    if(namecmp(name, de.name) == 0){
    80005d8c:	fd840793          	addi	a5,s0,-40
    80005d90:	0789                	addi	a5,a5,2
    80005d92:	85be                	mv	a1,a5
    80005d94:	fc043503          	ld	a0,-64(s0)
    80005d98:	00000097          	auipc	ra,0x0
    80005d9c:	f50080e7          	jalr	-176(ra) # 80005ce8 <namecmp>
    80005da0:	87aa                	mv	a5,a0
    80005da2:	eb9d                	bnez	a5,80005dd8 <dirlookup+0xc2>
      // entry matches path element
      if(poff)
    80005da4:	fb843783          	ld	a5,-72(s0)
    80005da8:	c791                	beqz	a5,80005db4 <dirlookup+0x9e>
        *poff = off;
    80005daa:	fb843783          	ld	a5,-72(s0)
    80005dae:	fec42703          	lw	a4,-20(s0)
    80005db2:	c398                	sw	a4,0(a5)
      inum = de.inum;
    80005db4:	fd845783          	lhu	a5,-40(s0)
    80005db8:	fef42423          	sw	a5,-24(s0)
      return iget(dp->dev, inum);
    80005dbc:	fc843783          	ld	a5,-56(s0)
    80005dc0:	439c                	lw	a5,0(a5)
    80005dc2:	fe842703          	lw	a4,-24(s0)
    80005dc6:	85ba                	mv	a1,a4
    80005dc8:	853e                	mv	a0,a5
    80005dca:	fffff097          	auipc	ra,0xfffff
    80005dce:	4f0080e7          	jalr	1264(ra) # 800052ba <iget>
    80005dd2:	87aa                	mv	a5,a0
    80005dd4:	a005                	j	80005df4 <dirlookup+0xde>
      continue;
    80005dd6:	0001                	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005dd8:	fec42783          	lw	a5,-20(s0)
    80005ddc:	27c1                	addiw	a5,a5,16
    80005dde:	fef42623          	sw	a5,-20(s0)
    80005de2:	fc843783          	ld	a5,-56(s0)
    80005de6:	47f8                	lw	a4,76(a5)
    80005de8:	fec42783          	lw	a5,-20(s0)
    80005dec:	2781                	sext.w	a5,a5
    80005dee:	f6e7e2e3          	bltu	a5,a4,80005d52 <dirlookup+0x3c>
    }
  }

  return 0;
    80005df2:	4781                	li	a5,0
}
    80005df4:	853e                	mv	a0,a5
    80005df6:	60a6                	ld	ra,72(sp)
    80005df8:	6406                	ld	s0,64(sp)
    80005dfa:	6161                	addi	sp,sp,80
    80005dfc:	8082                	ret

0000000080005dfe <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
    80005dfe:	715d                	addi	sp,sp,-80
    80005e00:	e486                	sd	ra,72(sp)
    80005e02:	e0a2                	sd	s0,64(sp)
    80005e04:	0880                	addi	s0,sp,80
    80005e06:	fca43423          	sd	a0,-56(s0)
    80005e0a:	fcb43023          	sd	a1,-64(s0)
    80005e0e:	87b2                	mv	a5,a2
    80005e10:	faf42e23          	sw	a5,-68(s0)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    80005e14:	4601                	li	a2,0
    80005e16:	fc043583          	ld	a1,-64(s0)
    80005e1a:	fc843503          	ld	a0,-56(s0)
    80005e1e:	00000097          	auipc	ra,0x0
    80005e22:	ef8080e7          	jalr	-264(ra) # 80005d16 <dirlookup>
    80005e26:	fea43023          	sd	a0,-32(s0)
    80005e2a:	fe043783          	ld	a5,-32(s0)
    80005e2e:	cb89                	beqz	a5,80005e40 <dirlink+0x42>
    iput(ip);
    80005e30:	fe043503          	ld	a0,-32(s0)
    80005e34:	fffff097          	auipc	ra,0xfffff
    80005e38:	77c080e7          	jalr	1916(ra) # 800055b0 <iput>
    return -1;
    80005e3c:	57fd                	li	a5,-1
    80005e3e:	a865                	j	80005ef6 <dirlink+0xf8>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005e40:	fe042623          	sw	zero,-20(s0)
    80005e44:	a0a1                	j	80005e8c <dirlink+0x8e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005e46:	fd040793          	addi	a5,s0,-48
    80005e4a:	fec42683          	lw	a3,-20(s0)
    80005e4e:	4741                	li	a4,16
    80005e50:	863e                	mv	a2,a5
    80005e52:	4581                	li	a1,0
    80005e54:	fc843503          	ld	a0,-56(s0)
    80005e58:	00000097          	auipc	ra,0x0
    80005e5c:	b60080e7          	jalr	-1184(ra) # 800059b8 <readi>
    80005e60:	87aa                	mv	a5,a0
    80005e62:	873e                	mv	a4,a5
    80005e64:	47c1                	li	a5,16
    80005e66:	00f70a63          	beq	a4,a5,80005e7a <dirlink+0x7c>
      panic("dirlink read");
    80005e6a:	00005517          	auipc	a0,0x5
    80005e6e:	6be50513          	addi	a0,a0,1726 # 8000b528 <etext+0x528>
    80005e72:	ffffb097          	auipc	ra,0xffffb
    80005e76:	e0c080e7          	jalr	-500(ra) # 80000c7e <panic>
    if(de.inum == 0)
    80005e7a:	fd045783          	lhu	a5,-48(s0)
    80005e7e:	cf99                	beqz	a5,80005e9c <dirlink+0x9e>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80005e80:	fec42783          	lw	a5,-20(s0)
    80005e84:	27c1                	addiw	a5,a5,16
    80005e86:	2781                	sext.w	a5,a5
    80005e88:	fef42623          	sw	a5,-20(s0)
    80005e8c:	fc843783          	ld	a5,-56(s0)
    80005e90:	47f8                	lw	a4,76(a5)
    80005e92:	fec42783          	lw	a5,-20(s0)
    80005e96:	fae7e8e3          	bltu	a5,a4,80005e46 <dirlink+0x48>
    80005e9a:	a011                	j	80005e9e <dirlink+0xa0>
      break;
    80005e9c:	0001                	nop
  }

  strncpy(de.name, name, DIRSIZ);
    80005e9e:	fd040793          	addi	a5,s0,-48
    80005ea2:	0789                	addi	a5,a5,2
    80005ea4:	4639                	li	a2,14
    80005ea6:	fc043583          	ld	a1,-64(s0)
    80005eaa:	853e                	mv	a0,a5
    80005eac:	ffffc097          	auipc	ra,0xffffc
    80005eb0:	818080e7          	jalr	-2024(ra) # 800016c4 <strncpy>
  de.inum = inum;
    80005eb4:	fbc42783          	lw	a5,-68(s0)
    80005eb8:	17c2                	slli	a5,a5,0x30
    80005eba:	93c1                	srli	a5,a5,0x30
    80005ebc:	fcf41823          	sh	a5,-48(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005ec0:	fd040793          	addi	a5,s0,-48
    80005ec4:	fec42683          	lw	a3,-20(s0)
    80005ec8:	4741                	li	a4,16
    80005eca:	863e                	mv	a2,a5
    80005ecc:	4581                	li	a1,0
    80005ece:	fc843503          	ld	a0,-56(s0)
    80005ed2:	00000097          	auipc	ra,0x0
    80005ed6:	c70080e7          	jalr	-912(ra) # 80005b42 <writei>
    80005eda:	87aa                	mv	a5,a0
    80005edc:	873e                	mv	a4,a5
    80005ede:	47c1                	li	a5,16
    80005ee0:	00f70a63          	beq	a4,a5,80005ef4 <dirlink+0xf6>
    panic("dirlink");
    80005ee4:	00005517          	auipc	a0,0x5
    80005ee8:	65450513          	addi	a0,a0,1620 # 8000b538 <etext+0x538>
    80005eec:	ffffb097          	auipc	ra,0xffffb
    80005ef0:	d92080e7          	jalr	-622(ra) # 80000c7e <panic>

  return 0;
    80005ef4:	4781                	li	a5,0
}
    80005ef6:	853e                	mv	a0,a5
    80005ef8:	60a6                	ld	ra,72(sp)
    80005efa:	6406                	ld	s0,64(sp)
    80005efc:	6161                	addi	sp,sp,80
    80005efe:	8082                	ret

0000000080005f00 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
    80005f00:	7179                	addi	sp,sp,-48
    80005f02:	f406                	sd	ra,40(sp)
    80005f04:	f022                	sd	s0,32(sp)
    80005f06:	1800                	addi	s0,sp,48
    80005f08:	fca43c23          	sd	a0,-40(s0)
    80005f0c:	fcb43823          	sd	a1,-48(s0)
  char *s;
  int len;

  while(*path == '/')
    80005f10:	a031                	j	80005f1c <skipelem+0x1c>
    path++;
    80005f12:	fd843783          	ld	a5,-40(s0)
    80005f16:	0785                	addi	a5,a5,1
    80005f18:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005f1c:	fd843783          	ld	a5,-40(s0)
    80005f20:	0007c783          	lbu	a5,0(a5)
    80005f24:	873e                	mv	a4,a5
    80005f26:	02f00793          	li	a5,47
    80005f2a:	fef704e3          	beq	a4,a5,80005f12 <skipelem+0x12>
  if(*path == 0)
    80005f2e:	fd843783          	ld	a5,-40(s0)
    80005f32:	0007c783          	lbu	a5,0(a5)
    80005f36:	e399                	bnez	a5,80005f3c <skipelem+0x3c>
    return 0;
    80005f38:	4781                	li	a5,0
    80005f3a:	a06d                	j	80005fe4 <skipelem+0xe4>
  s = path;
    80005f3c:	fd843783          	ld	a5,-40(s0)
    80005f40:	fef43423          	sd	a5,-24(s0)
  while(*path != '/' && *path != 0)
    80005f44:	a031                	j	80005f50 <skipelem+0x50>
    path++;
    80005f46:	fd843783          	ld	a5,-40(s0)
    80005f4a:	0785                	addi	a5,a5,1
    80005f4c:	fcf43c23          	sd	a5,-40(s0)
  while(*path != '/' && *path != 0)
    80005f50:	fd843783          	ld	a5,-40(s0)
    80005f54:	0007c783          	lbu	a5,0(a5)
    80005f58:	873e                	mv	a4,a5
    80005f5a:	02f00793          	li	a5,47
    80005f5e:	00f70763          	beq	a4,a5,80005f6c <skipelem+0x6c>
    80005f62:	fd843783          	ld	a5,-40(s0)
    80005f66:	0007c783          	lbu	a5,0(a5)
    80005f6a:	fff1                	bnez	a5,80005f46 <skipelem+0x46>
  len = path - s;
    80005f6c:	fd843703          	ld	a4,-40(s0)
    80005f70:	fe843783          	ld	a5,-24(s0)
    80005f74:	40f707b3          	sub	a5,a4,a5
    80005f78:	fef42223          	sw	a5,-28(s0)
  if(len >= DIRSIZ)
    80005f7c:	fe442783          	lw	a5,-28(s0)
    80005f80:	0007871b          	sext.w	a4,a5
    80005f84:	47b5                	li	a5,13
    80005f86:	00e7dc63          	bge	a5,a4,80005f9e <skipelem+0x9e>
    memmove(name, s, DIRSIZ);
    80005f8a:	4639                	li	a2,14
    80005f8c:	fe843583          	ld	a1,-24(s0)
    80005f90:	fd043503          	ld	a0,-48(s0)
    80005f94:	ffffb097          	auipc	ra,0xffffb
    80005f98:	592080e7          	jalr	1426(ra) # 80001526 <memmove>
    80005f9c:	a80d                	j	80005fce <skipelem+0xce>
  else {
    memmove(name, s, len);
    80005f9e:	fe442783          	lw	a5,-28(s0)
    80005fa2:	863e                	mv	a2,a5
    80005fa4:	fe843583          	ld	a1,-24(s0)
    80005fa8:	fd043503          	ld	a0,-48(s0)
    80005fac:	ffffb097          	auipc	ra,0xffffb
    80005fb0:	57a080e7          	jalr	1402(ra) # 80001526 <memmove>
    name[len] = 0;
    80005fb4:	fe442783          	lw	a5,-28(s0)
    80005fb8:	fd043703          	ld	a4,-48(s0)
    80005fbc:	97ba                	add	a5,a5,a4
    80005fbe:	00078023          	sb	zero,0(a5)
  }
  while(*path == '/')
    80005fc2:	a031                	j	80005fce <skipelem+0xce>
    path++;
    80005fc4:	fd843783          	ld	a5,-40(s0)
    80005fc8:	0785                	addi	a5,a5,1
    80005fca:	fcf43c23          	sd	a5,-40(s0)
  while(*path == '/')
    80005fce:	fd843783          	ld	a5,-40(s0)
    80005fd2:	0007c783          	lbu	a5,0(a5)
    80005fd6:	873e                	mv	a4,a5
    80005fd8:	02f00793          	li	a5,47
    80005fdc:	fef704e3          	beq	a4,a5,80005fc4 <skipelem+0xc4>
  return path;
    80005fe0:	fd843783          	ld	a5,-40(s0)
}
    80005fe4:	853e                	mv	a0,a5
    80005fe6:	70a2                	ld	ra,40(sp)
    80005fe8:	7402                	ld	s0,32(sp)
    80005fea:	6145                	addi	sp,sp,48
    80005fec:	8082                	ret

0000000080005fee <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80005fee:	7139                	addi	sp,sp,-64
    80005ff0:	fc06                	sd	ra,56(sp)
    80005ff2:	f822                	sd	s0,48(sp)
    80005ff4:	0080                	addi	s0,sp,64
    80005ff6:	fca43c23          	sd	a0,-40(s0)
    80005ffa:	87ae                	mv	a5,a1
    80005ffc:	fcc43423          	sd	a2,-56(s0)
    80006000:	fcf42a23          	sw	a5,-44(s0)
  struct inode *ip, *next;

  if(*path == '/')
    80006004:	fd843783          	ld	a5,-40(s0)
    80006008:	0007c783          	lbu	a5,0(a5)
    8000600c:	873e                	mv	a4,a5
    8000600e:	02f00793          	li	a5,47
    80006012:	00f71b63          	bne	a4,a5,80006028 <namex+0x3a>
    ip = iget(ROOTDEV, ROOTINO);
    80006016:	4585                	li	a1,1
    80006018:	4505                	li	a0,1
    8000601a:	fffff097          	auipc	ra,0xfffff
    8000601e:	2a0080e7          	jalr	672(ra) # 800052ba <iget>
    80006022:	fea43423          	sd	a0,-24(s0)
    80006026:	a84d                	j	800060d8 <namex+0xea>
  else
    ip = idup(myproc()->cwd);
    80006028:	ffffc097          	auipc	ra,0xffffc
    8000602c:	7ec080e7          	jalr	2028(ra) # 80002814 <myproc>
    80006030:	87aa                	mv	a5,a0
    80006032:	1587b783          	ld	a5,344(a5)
    80006036:	853e                	mv	a0,a5
    80006038:	fffff097          	auipc	ra,0xfffff
    8000603c:	39e080e7          	jalr	926(ra) # 800053d6 <idup>
    80006040:	fea43423          	sd	a0,-24(s0)

  while((path = skipelem(path, name)) != 0){
    80006044:	a851                	j	800060d8 <namex+0xea>
    ilock(ip);
    80006046:	fe843503          	ld	a0,-24(s0)
    8000604a:	fffff097          	auipc	ra,0xfffff
    8000604e:	3d8080e7          	jalr	984(ra) # 80005422 <ilock>
    if(ip->type != T_DIR){
    80006052:	fe843783          	ld	a5,-24(s0)
    80006056:	04479783          	lh	a5,68(a5)
    8000605a:	0007871b          	sext.w	a4,a5
    8000605e:	4785                	li	a5,1
    80006060:	00f70a63          	beq	a4,a5,80006074 <namex+0x86>
      iunlockput(ip);
    80006064:	fe843503          	ld	a0,-24(s0)
    80006068:	fffff097          	auipc	ra,0xfffff
    8000606c:	618080e7          	jalr	1560(ra) # 80005680 <iunlockput>
      return 0;
    80006070:	4781                	li	a5,0
    80006072:	a871                	j	8000610e <namex+0x120>
    }
    if(nameiparent && *path == '\0'){
    80006074:	fd442783          	lw	a5,-44(s0)
    80006078:	2781                	sext.w	a5,a5
    8000607a:	cf99                	beqz	a5,80006098 <namex+0xaa>
    8000607c:	fd843783          	ld	a5,-40(s0)
    80006080:	0007c783          	lbu	a5,0(a5)
    80006084:	eb91                	bnez	a5,80006098 <namex+0xaa>
      // Stop one level early.
      iunlock(ip);
    80006086:	fe843503          	ld	a0,-24(s0)
    8000608a:	fffff097          	auipc	ra,0xfffff
    8000608e:	4cc080e7          	jalr	1228(ra) # 80005556 <iunlock>
      return ip;
    80006092:	fe843783          	ld	a5,-24(s0)
    80006096:	a8a5                	j	8000610e <namex+0x120>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
    80006098:	4601                	li	a2,0
    8000609a:	fc843583          	ld	a1,-56(s0)
    8000609e:	fe843503          	ld	a0,-24(s0)
    800060a2:	00000097          	auipc	ra,0x0
    800060a6:	c74080e7          	jalr	-908(ra) # 80005d16 <dirlookup>
    800060aa:	fea43023          	sd	a0,-32(s0)
    800060ae:	fe043783          	ld	a5,-32(s0)
    800060b2:	eb89                	bnez	a5,800060c4 <namex+0xd6>
      iunlockput(ip);
    800060b4:	fe843503          	ld	a0,-24(s0)
    800060b8:	fffff097          	auipc	ra,0xfffff
    800060bc:	5c8080e7          	jalr	1480(ra) # 80005680 <iunlockput>
      return 0;
    800060c0:	4781                	li	a5,0
    800060c2:	a0b1                	j	8000610e <namex+0x120>
    }
    iunlockput(ip);
    800060c4:	fe843503          	ld	a0,-24(s0)
    800060c8:	fffff097          	auipc	ra,0xfffff
    800060cc:	5b8080e7          	jalr	1464(ra) # 80005680 <iunlockput>
    ip = next;
    800060d0:	fe043783          	ld	a5,-32(s0)
    800060d4:	fef43423          	sd	a5,-24(s0)
  while((path = skipelem(path, name)) != 0){
    800060d8:	fc843583          	ld	a1,-56(s0)
    800060dc:	fd843503          	ld	a0,-40(s0)
    800060e0:	00000097          	auipc	ra,0x0
    800060e4:	e20080e7          	jalr	-480(ra) # 80005f00 <skipelem>
    800060e8:	fca43c23          	sd	a0,-40(s0)
    800060ec:	fd843783          	ld	a5,-40(s0)
    800060f0:	fbb9                	bnez	a5,80006046 <namex+0x58>
  }
  if(nameiparent){
    800060f2:	fd442783          	lw	a5,-44(s0)
    800060f6:	2781                	sext.w	a5,a5
    800060f8:	cb89                	beqz	a5,8000610a <namex+0x11c>
    iput(ip);
    800060fa:	fe843503          	ld	a0,-24(s0)
    800060fe:	fffff097          	auipc	ra,0xfffff
    80006102:	4b2080e7          	jalr	1202(ra) # 800055b0 <iput>
    return 0;
    80006106:	4781                	li	a5,0
    80006108:	a019                	j	8000610e <namex+0x120>
  }
  return ip;
    8000610a:	fe843783          	ld	a5,-24(s0)
}
    8000610e:	853e                	mv	a0,a5
    80006110:	70e2                	ld	ra,56(sp)
    80006112:	7442                	ld	s0,48(sp)
    80006114:	6121                	addi	sp,sp,64
    80006116:	8082                	ret

0000000080006118 <namei>:

struct inode*
namei(char *path)
{
    80006118:	7179                	addi	sp,sp,-48
    8000611a:	f406                	sd	ra,40(sp)
    8000611c:	f022                	sd	s0,32(sp)
    8000611e:	1800                	addi	s0,sp,48
    80006120:	fca43c23          	sd	a0,-40(s0)
  char name[DIRSIZ];
  return namex(path, 0, name);
    80006124:	fe040793          	addi	a5,s0,-32
    80006128:	863e                	mv	a2,a5
    8000612a:	4581                	li	a1,0
    8000612c:	fd843503          	ld	a0,-40(s0)
    80006130:	00000097          	auipc	ra,0x0
    80006134:	ebe080e7          	jalr	-322(ra) # 80005fee <namex>
    80006138:	87aa                	mv	a5,a0
}
    8000613a:	853e                	mv	a0,a5
    8000613c:	70a2                	ld	ra,40(sp)
    8000613e:	7402                	ld	s0,32(sp)
    80006140:	6145                	addi	sp,sp,48
    80006142:	8082                	ret

0000000080006144 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80006144:	1101                	addi	sp,sp,-32
    80006146:	ec06                	sd	ra,24(sp)
    80006148:	e822                	sd	s0,16(sp)
    8000614a:	1000                	addi	s0,sp,32
    8000614c:	fea43423          	sd	a0,-24(s0)
    80006150:	feb43023          	sd	a1,-32(s0)
  return namex(path, 1, name);
    80006154:	fe043603          	ld	a2,-32(s0)
    80006158:	4585                	li	a1,1
    8000615a:	fe843503          	ld	a0,-24(s0)
    8000615e:	00000097          	auipc	ra,0x0
    80006162:	e90080e7          	jalr	-368(ra) # 80005fee <namex>
    80006166:	87aa                	mv	a5,a0
}
    80006168:	853e                	mv	a0,a5
    8000616a:	60e2                	ld	ra,24(sp)
    8000616c:	6442                	ld	s0,16(sp)
    8000616e:	6105                	addi	sp,sp,32
    80006170:	8082                	ret

0000000080006172 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev, struct superblock *sb)
{
    80006172:	1101                	addi	sp,sp,-32
    80006174:	ec06                	sd	ra,24(sp)
    80006176:	e822                	sd	s0,16(sp)
    80006178:	1000                	addi	s0,sp,32
    8000617a:	87aa                	mv	a5,a0
    8000617c:	feb43023          	sd	a1,-32(s0)
    80006180:	fef42623          	sw	a5,-20(s0)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  initlock(&log.lock, "log");
    80006184:	00005597          	auipc	a1,0x5
    80006188:	3bc58593          	addi	a1,a1,956 # 8000b540 <etext+0x540>
    8000618c:	0001e517          	auipc	a0,0x1e
    80006190:	30450513          	addi	a0,a0,772 # 80024490 <log>
    80006194:	ffffb097          	auipc	ra,0xffffb
    80006198:	0aa080e7          	jalr	170(ra) # 8000123e <initlock>
  log.start = sb->logstart;
    8000619c:	fe043783          	ld	a5,-32(s0)
    800061a0:	4bdc                	lw	a5,20(a5)
    800061a2:	0007871b          	sext.w	a4,a5
    800061a6:	0001e797          	auipc	a5,0x1e
    800061aa:	2ea78793          	addi	a5,a5,746 # 80024490 <log>
    800061ae:	cf98                	sw	a4,24(a5)
  log.size = sb->nlog;
    800061b0:	fe043783          	ld	a5,-32(s0)
    800061b4:	4b9c                	lw	a5,16(a5)
    800061b6:	0007871b          	sext.w	a4,a5
    800061ba:	0001e797          	auipc	a5,0x1e
    800061be:	2d678793          	addi	a5,a5,726 # 80024490 <log>
    800061c2:	cfd8                	sw	a4,28(a5)
  log.dev = dev;
    800061c4:	0001e797          	auipc	a5,0x1e
    800061c8:	2cc78793          	addi	a5,a5,716 # 80024490 <log>
    800061cc:	fec42703          	lw	a4,-20(s0)
    800061d0:	d798                	sw	a4,40(a5)
  recover_from_log();
    800061d2:	00000097          	auipc	ra,0x0
    800061d6:	272080e7          	jalr	626(ra) # 80006444 <recover_from_log>
}
    800061da:	0001                	nop
    800061dc:	60e2                	ld	ra,24(sp)
    800061de:	6442                	ld	s0,16(sp)
    800061e0:	6105                	addi	sp,sp,32
    800061e2:	8082                	ret

00000000800061e4 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(int recovering)
{
    800061e4:	7139                	addi	sp,sp,-64
    800061e6:	fc06                	sd	ra,56(sp)
    800061e8:	f822                	sd	s0,48(sp)
    800061ea:	0080                	addi	s0,sp,64
    800061ec:	87aa                	mv	a5,a0
    800061ee:	fcf42623          	sw	a5,-52(s0)
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    800061f2:	fe042623          	sw	zero,-20(s0)
    800061f6:	a0f9                	j	800062c4 <install_trans+0xe0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800061f8:	0001e797          	auipc	a5,0x1e
    800061fc:	29878793          	addi	a5,a5,664 # 80024490 <log>
    80006200:	579c                	lw	a5,40(a5)
    80006202:	0007869b          	sext.w	a3,a5
    80006206:	0001e797          	auipc	a5,0x1e
    8000620a:	28a78793          	addi	a5,a5,650 # 80024490 <log>
    8000620e:	4f9c                	lw	a5,24(a5)
    80006210:	fec42703          	lw	a4,-20(s0)
    80006214:	9fb9                	addw	a5,a5,a4
    80006216:	2781                	sext.w	a5,a5
    80006218:	2785                	addiw	a5,a5,1
    8000621a:	2781                	sext.w	a5,a5
    8000621c:	2781                	sext.w	a5,a5
    8000621e:	85be                	mv	a1,a5
    80006220:	8536                	mv	a0,a3
    80006222:	fffff097          	auipc	ra,0xfffff
    80006226:	818080e7          	jalr	-2024(ra) # 80004a3a <bread>
    8000622a:	fea43023          	sd	a0,-32(s0)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000622e:	0001e797          	auipc	a5,0x1e
    80006232:	26278793          	addi	a5,a5,610 # 80024490 <log>
    80006236:	579c                	lw	a5,40(a5)
    80006238:	0007869b          	sext.w	a3,a5
    8000623c:	0001e717          	auipc	a4,0x1e
    80006240:	25470713          	addi	a4,a4,596 # 80024490 <log>
    80006244:	fec42783          	lw	a5,-20(s0)
    80006248:	07a1                	addi	a5,a5,8
    8000624a:	078a                	slli	a5,a5,0x2
    8000624c:	97ba                	add	a5,a5,a4
    8000624e:	4b9c                	lw	a5,16(a5)
    80006250:	2781                	sext.w	a5,a5
    80006252:	85be                	mv	a1,a5
    80006254:	8536                	mv	a0,a3
    80006256:	ffffe097          	auipc	ra,0xffffe
    8000625a:	7e4080e7          	jalr	2020(ra) # 80004a3a <bread>
    8000625e:	fca43c23          	sd	a0,-40(s0)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80006262:	fd843783          	ld	a5,-40(s0)
    80006266:	05878713          	addi	a4,a5,88
    8000626a:	fe043783          	ld	a5,-32(s0)
    8000626e:	05878793          	addi	a5,a5,88
    80006272:	40000613          	li	a2,1024
    80006276:	85be                	mv	a1,a5
    80006278:	853a                	mv	a0,a4
    8000627a:	ffffb097          	auipc	ra,0xffffb
    8000627e:	2ac080e7          	jalr	684(ra) # 80001526 <memmove>
    bwrite(dbuf);  // write dst to disk
    80006282:	fd843503          	ld	a0,-40(s0)
    80006286:	fffff097          	auipc	ra,0xfffff
    8000628a:	80e080e7          	jalr	-2034(ra) # 80004a94 <bwrite>
    if(recovering == 0)
    8000628e:	fcc42783          	lw	a5,-52(s0)
    80006292:	2781                	sext.w	a5,a5
    80006294:	e799                	bnez	a5,800062a2 <install_trans+0xbe>
      bunpin(dbuf);
    80006296:	fd843503          	ld	a0,-40(s0)
    8000629a:	fffff097          	auipc	ra,0xfffff
    8000629e:	978080e7          	jalr	-1672(ra) # 80004c12 <bunpin>
    brelse(lbuf);
    800062a2:	fe043503          	ld	a0,-32(s0)
    800062a6:	fffff097          	auipc	ra,0xfffff
    800062aa:	836080e7          	jalr	-1994(ra) # 80004adc <brelse>
    brelse(dbuf);
    800062ae:	fd843503          	ld	a0,-40(s0)
    800062b2:	fffff097          	auipc	ra,0xfffff
    800062b6:	82a080e7          	jalr	-2006(ra) # 80004adc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800062ba:	fec42783          	lw	a5,-20(s0)
    800062be:	2785                	addiw	a5,a5,1
    800062c0:	fef42623          	sw	a5,-20(s0)
    800062c4:	0001e797          	auipc	a5,0x1e
    800062c8:	1cc78793          	addi	a5,a5,460 # 80024490 <log>
    800062cc:	57d8                	lw	a4,44(a5)
    800062ce:	fec42783          	lw	a5,-20(s0)
    800062d2:	2781                	sext.w	a5,a5
    800062d4:	f2e7c2e3          	blt	a5,a4,800061f8 <install_trans+0x14>
  }
}
    800062d8:	0001                	nop
    800062da:	0001                	nop
    800062dc:	70e2                	ld	ra,56(sp)
    800062de:	7442                	ld	s0,48(sp)
    800062e0:	6121                	addi	sp,sp,64
    800062e2:	8082                	ret

00000000800062e4 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
    800062e4:	7179                	addi	sp,sp,-48
    800062e6:	f406                	sd	ra,40(sp)
    800062e8:	f022                	sd	s0,32(sp)
    800062ea:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    800062ec:	0001e797          	auipc	a5,0x1e
    800062f0:	1a478793          	addi	a5,a5,420 # 80024490 <log>
    800062f4:	579c                	lw	a5,40(a5)
    800062f6:	0007871b          	sext.w	a4,a5
    800062fa:	0001e797          	auipc	a5,0x1e
    800062fe:	19678793          	addi	a5,a5,406 # 80024490 <log>
    80006302:	4f9c                	lw	a5,24(a5)
    80006304:	2781                	sext.w	a5,a5
    80006306:	85be                	mv	a1,a5
    80006308:	853a                	mv	a0,a4
    8000630a:	ffffe097          	auipc	ra,0xffffe
    8000630e:	730080e7          	jalr	1840(ra) # 80004a3a <bread>
    80006312:	fea43023          	sd	a0,-32(s0)
  struct logheader *lh = (struct logheader *) (buf->data);
    80006316:	fe043783          	ld	a5,-32(s0)
    8000631a:	05878793          	addi	a5,a5,88
    8000631e:	fcf43c23          	sd	a5,-40(s0)
  int i;
  log.lh.n = lh->n;
    80006322:	fd843783          	ld	a5,-40(s0)
    80006326:	4398                	lw	a4,0(a5)
    80006328:	0001e797          	auipc	a5,0x1e
    8000632c:	16878793          	addi	a5,a5,360 # 80024490 <log>
    80006330:	d7d8                	sw	a4,44(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006332:	fe042623          	sw	zero,-20(s0)
    80006336:	a03d                	j	80006364 <read_head+0x80>
    log.lh.block[i] = lh->block[i];
    80006338:	fd843703          	ld	a4,-40(s0)
    8000633c:	fec42783          	lw	a5,-20(s0)
    80006340:	078a                	slli	a5,a5,0x2
    80006342:	97ba                	add	a5,a5,a4
    80006344:	43d8                	lw	a4,4(a5)
    80006346:	0001e697          	auipc	a3,0x1e
    8000634a:	14a68693          	addi	a3,a3,330 # 80024490 <log>
    8000634e:	fec42783          	lw	a5,-20(s0)
    80006352:	07a1                	addi	a5,a5,8
    80006354:	078a                	slli	a5,a5,0x2
    80006356:	97b6                	add	a5,a5,a3
    80006358:	cb98                	sw	a4,16(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000635a:	fec42783          	lw	a5,-20(s0)
    8000635e:	2785                	addiw	a5,a5,1
    80006360:	fef42623          	sw	a5,-20(s0)
    80006364:	0001e797          	auipc	a5,0x1e
    80006368:	12c78793          	addi	a5,a5,300 # 80024490 <log>
    8000636c:	57d8                	lw	a4,44(a5)
    8000636e:	fec42783          	lw	a5,-20(s0)
    80006372:	2781                	sext.w	a5,a5
    80006374:	fce7c2e3          	blt	a5,a4,80006338 <read_head+0x54>
  }
  brelse(buf);
    80006378:	fe043503          	ld	a0,-32(s0)
    8000637c:	ffffe097          	auipc	ra,0xffffe
    80006380:	760080e7          	jalr	1888(ra) # 80004adc <brelse>
}
    80006384:	0001                	nop
    80006386:	70a2                	ld	ra,40(sp)
    80006388:	7402                	ld	s0,32(sp)
    8000638a:	6145                	addi	sp,sp,48
    8000638c:	8082                	ret

000000008000638e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000638e:	7179                	addi	sp,sp,-48
    80006390:	f406                	sd	ra,40(sp)
    80006392:	f022                	sd	s0,32(sp)
    80006394:	1800                	addi	s0,sp,48
  struct buf *buf = bread(log.dev, log.start);
    80006396:	0001e797          	auipc	a5,0x1e
    8000639a:	0fa78793          	addi	a5,a5,250 # 80024490 <log>
    8000639e:	579c                	lw	a5,40(a5)
    800063a0:	0007871b          	sext.w	a4,a5
    800063a4:	0001e797          	auipc	a5,0x1e
    800063a8:	0ec78793          	addi	a5,a5,236 # 80024490 <log>
    800063ac:	4f9c                	lw	a5,24(a5)
    800063ae:	2781                	sext.w	a5,a5
    800063b0:	85be                	mv	a1,a5
    800063b2:	853a                	mv	a0,a4
    800063b4:	ffffe097          	auipc	ra,0xffffe
    800063b8:	686080e7          	jalr	1670(ra) # 80004a3a <bread>
    800063bc:	fea43023          	sd	a0,-32(s0)
  struct logheader *hb = (struct logheader *) (buf->data);
    800063c0:	fe043783          	ld	a5,-32(s0)
    800063c4:	05878793          	addi	a5,a5,88
    800063c8:	fcf43c23          	sd	a5,-40(s0)
  int i;
  hb->n = log.lh.n;
    800063cc:	0001e797          	auipc	a5,0x1e
    800063d0:	0c478793          	addi	a5,a5,196 # 80024490 <log>
    800063d4:	57d8                	lw	a4,44(a5)
    800063d6:	fd843783          	ld	a5,-40(s0)
    800063da:	c398                	sw	a4,0(a5)
  for (i = 0; i < log.lh.n; i++) {
    800063dc:	fe042623          	sw	zero,-20(s0)
    800063e0:	a03d                	j	8000640e <write_head+0x80>
    hb->block[i] = log.lh.block[i];
    800063e2:	0001e717          	auipc	a4,0x1e
    800063e6:	0ae70713          	addi	a4,a4,174 # 80024490 <log>
    800063ea:	fec42783          	lw	a5,-20(s0)
    800063ee:	07a1                	addi	a5,a5,8
    800063f0:	078a                	slli	a5,a5,0x2
    800063f2:	97ba                	add	a5,a5,a4
    800063f4:	4b98                	lw	a4,16(a5)
    800063f6:	fd843683          	ld	a3,-40(s0)
    800063fa:	fec42783          	lw	a5,-20(s0)
    800063fe:	078a                	slli	a5,a5,0x2
    80006400:	97b6                	add	a5,a5,a3
    80006402:	c3d8                	sw	a4,4(a5)
  for (i = 0; i < log.lh.n; i++) {
    80006404:	fec42783          	lw	a5,-20(s0)
    80006408:	2785                	addiw	a5,a5,1
    8000640a:	fef42623          	sw	a5,-20(s0)
    8000640e:	0001e797          	auipc	a5,0x1e
    80006412:	08278793          	addi	a5,a5,130 # 80024490 <log>
    80006416:	57d8                	lw	a4,44(a5)
    80006418:	fec42783          	lw	a5,-20(s0)
    8000641c:	2781                	sext.w	a5,a5
    8000641e:	fce7c2e3          	blt	a5,a4,800063e2 <write_head+0x54>
  }
  bwrite(buf);
    80006422:	fe043503          	ld	a0,-32(s0)
    80006426:	ffffe097          	auipc	ra,0xffffe
    8000642a:	66e080e7          	jalr	1646(ra) # 80004a94 <bwrite>
  brelse(buf);
    8000642e:	fe043503          	ld	a0,-32(s0)
    80006432:	ffffe097          	auipc	ra,0xffffe
    80006436:	6aa080e7          	jalr	1706(ra) # 80004adc <brelse>
}
    8000643a:	0001                	nop
    8000643c:	70a2                	ld	ra,40(sp)
    8000643e:	7402                	ld	s0,32(sp)
    80006440:	6145                	addi	sp,sp,48
    80006442:	8082                	ret

0000000080006444 <recover_from_log>:

static void
recover_from_log(void)
{
    80006444:	1141                	addi	sp,sp,-16
    80006446:	e406                	sd	ra,8(sp)
    80006448:	e022                	sd	s0,0(sp)
    8000644a:	0800                	addi	s0,sp,16
  read_head();
    8000644c:	00000097          	auipc	ra,0x0
    80006450:	e98080e7          	jalr	-360(ra) # 800062e4 <read_head>
  install_trans(1); // if committed, copy from log to disk
    80006454:	4505                	li	a0,1
    80006456:	00000097          	auipc	ra,0x0
    8000645a:	d8e080e7          	jalr	-626(ra) # 800061e4 <install_trans>
  log.lh.n = 0;
    8000645e:	0001e797          	auipc	a5,0x1e
    80006462:	03278793          	addi	a5,a5,50 # 80024490 <log>
    80006466:	0207a623          	sw	zero,44(a5)
  write_head(); // clear the log
    8000646a:	00000097          	auipc	ra,0x0
    8000646e:	f24080e7          	jalr	-220(ra) # 8000638e <write_head>
}
    80006472:	0001                	nop
    80006474:	60a2                	ld	ra,8(sp)
    80006476:	6402                	ld	s0,0(sp)
    80006478:	0141                	addi	sp,sp,16
    8000647a:	8082                	ret

000000008000647c <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
    8000647c:	1141                	addi	sp,sp,-16
    8000647e:	e406                	sd	ra,8(sp)
    80006480:	e022                	sd	s0,0(sp)
    80006482:	0800                	addi	s0,sp,16
  acquire(&log.lock);
    80006484:	0001e517          	auipc	a0,0x1e
    80006488:	00c50513          	addi	a0,a0,12 # 80024490 <log>
    8000648c:	ffffb097          	auipc	ra,0xffffb
    80006490:	de2080e7          	jalr	-542(ra) # 8000126e <acquire>
  while(1){
    if(log.committing){
    80006494:	0001e797          	auipc	a5,0x1e
    80006498:	ffc78793          	addi	a5,a5,-4 # 80024490 <log>
    8000649c:	53dc                	lw	a5,36(a5)
    8000649e:	cf91                	beqz	a5,800064ba <begin_op+0x3e>
      sleep(&log, &log.lock);
    800064a0:	0001e597          	auipc	a1,0x1e
    800064a4:	ff058593          	addi	a1,a1,-16 # 80024490 <log>
    800064a8:	0001e517          	auipc	a0,0x1e
    800064ac:	fe850513          	addi	a0,a0,-24 # 80024490 <log>
    800064b0:	ffffd097          	auipc	ra,0xffffd
    800064b4:	030080e7          	jalr	48(ra) # 800034e0 <sleep>
    800064b8:	bff1                	j	80006494 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800064ba:	0001e797          	auipc	a5,0x1e
    800064be:	fd678793          	addi	a5,a5,-42 # 80024490 <log>
    800064c2:	57d8                	lw	a4,44(a5)
    800064c4:	0001e797          	auipc	a5,0x1e
    800064c8:	fcc78793          	addi	a5,a5,-52 # 80024490 <log>
    800064cc:	539c                	lw	a5,32(a5)
    800064ce:	2785                	addiw	a5,a5,1
    800064d0:	2781                	sext.w	a5,a5
    800064d2:	86be                	mv	a3,a5
    800064d4:	87b6                	mv	a5,a3
    800064d6:	0027979b          	slliw	a5,a5,0x2
    800064da:	9fb5                	addw	a5,a5,a3
    800064dc:	0017979b          	slliw	a5,a5,0x1
    800064e0:	2781                	sext.w	a5,a5
    800064e2:	9fb9                	addw	a5,a5,a4
    800064e4:	2781                	sext.w	a5,a5
    800064e6:	873e                	mv	a4,a5
    800064e8:	47f9                	li	a5,30
    800064ea:	00e7df63          	bge	a5,a4,80006508 <begin_op+0x8c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800064ee:	0001e597          	auipc	a1,0x1e
    800064f2:	fa258593          	addi	a1,a1,-94 # 80024490 <log>
    800064f6:	0001e517          	auipc	a0,0x1e
    800064fa:	f9a50513          	addi	a0,a0,-102 # 80024490 <log>
    800064fe:	ffffd097          	auipc	ra,0xffffd
    80006502:	fe2080e7          	jalr	-30(ra) # 800034e0 <sleep>
    80006506:	b779                	j	80006494 <begin_op+0x18>
    } else {
      log.outstanding += 1;
    80006508:	0001e797          	auipc	a5,0x1e
    8000650c:	f8878793          	addi	a5,a5,-120 # 80024490 <log>
    80006510:	539c                	lw	a5,32(a5)
    80006512:	2785                	addiw	a5,a5,1
    80006514:	0007871b          	sext.w	a4,a5
    80006518:	0001e797          	auipc	a5,0x1e
    8000651c:	f7878793          	addi	a5,a5,-136 # 80024490 <log>
    80006520:	d398                	sw	a4,32(a5)
      release(&log.lock);
    80006522:	0001e517          	auipc	a0,0x1e
    80006526:	f6e50513          	addi	a0,a0,-146 # 80024490 <log>
    8000652a:	ffffb097          	auipc	ra,0xffffb
    8000652e:	da8080e7          	jalr	-600(ra) # 800012d2 <release>
      break;
    80006532:	0001                	nop
    }
  }
}
    80006534:	0001                	nop
    80006536:	60a2                	ld	ra,8(sp)
    80006538:	6402                	ld	s0,0(sp)
    8000653a:	0141                	addi	sp,sp,16
    8000653c:	8082                	ret

000000008000653e <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000653e:	1101                	addi	sp,sp,-32
    80006540:	ec06                	sd	ra,24(sp)
    80006542:	e822                	sd	s0,16(sp)
    80006544:	1000                	addi	s0,sp,32
  int do_commit = 0;
    80006546:	fe042623          	sw	zero,-20(s0)

  acquire(&log.lock);
    8000654a:	0001e517          	auipc	a0,0x1e
    8000654e:	f4650513          	addi	a0,a0,-186 # 80024490 <log>
    80006552:	ffffb097          	auipc	ra,0xffffb
    80006556:	d1c080e7          	jalr	-740(ra) # 8000126e <acquire>
  log.outstanding -= 1;
    8000655a:	0001e797          	auipc	a5,0x1e
    8000655e:	f3678793          	addi	a5,a5,-202 # 80024490 <log>
    80006562:	539c                	lw	a5,32(a5)
    80006564:	37fd                	addiw	a5,a5,-1
    80006566:	0007871b          	sext.w	a4,a5
    8000656a:	0001e797          	auipc	a5,0x1e
    8000656e:	f2678793          	addi	a5,a5,-218 # 80024490 <log>
    80006572:	d398                	sw	a4,32(a5)
  if(log.committing)
    80006574:	0001e797          	auipc	a5,0x1e
    80006578:	f1c78793          	addi	a5,a5,-228 # 80024490 <log>
    8000657c:	53dc                	lw	a5,36(a5)
    8000657e:	cb89                	beqz	a5,80006590 <end_op+0x52>
    panic("log.committing");
    80006580:	00005517          	auipc	a0,0x5
    80006584:	fc850513          	addi	a0,a0,-56 # 8000b548 <etext+0x548>
    80006588:	ffffa097          	auipc	ra,0xffffa
    8000658c:	6f6080e7          	jalr	1782(ra) # 80000c7e <panic>
  if(log.outstanding == 0){
    80006590:	0001e797          	auipc	a5,0x1e
    80006594:	f0078793          	addi	a5,a5,-256 # 80024490 <log>
    80006598:	539c                	lw	a5,32(a5)
    8000659a:	eb99                	bnez	a5,800065b0 <end_op+0x72>
    do_commit = 1;
    8000659c:	4785                	li	a5,1
    8000659e:	fef42623          	sw	a5,-20(s0)
    log.committing = 1;
    800065a2:	0001e797          	auipc	a5,0x1e
    800065a6:	eee78793          	addi	a5,a5,-274 # 80024490 <log>
    800065aa:	4705                	li	a4,1
    800065ac:	d3d8                	sw	a4,36(a5)
    800065ae:	a809                	j	800065c0 <end_op+0x82>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
    800065b0:	0001e517          	auipc	a0,0x1e
    800065b4:	ee050513          	addi	a0,a0,-288 # 80024490 <log>
    800065b8:	ffffd097          	auipc	ra,0xffffd
    800065bc:	fec080e7          	jalr	-20(ra) # 800035a4 <wakeup>
  }
  release(&log.lock);
    800065c0:	0001e517          	auipc	a0,0x1e
    800065c4:	ed050513          	addi	a0,a0,-304 # 80024490 <log>
    800065c8:	ffffb097          	auipc	ra,0xffffb
    800065cc:	d0a080e7          	jalr	-758(ra) # 800012d2 <release>

  if(do_commit){
    800065d0:	fec42783          	lw	a5,-20(s0)
    800065d4:	2781                	sext.w	a5,a5
    800065d6:	c3b9                	beqz	a5,8000661c <end_op+0xde>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    800065d8:	00000097          	auipc	ra,0x0
    800065dc:	134080e7          	jalr	308(ra) # 8000670c <commit>
    acquire(&log.lock);
    800065e0:	0001e517          	auipc	a0,0x1e
    800065e4:	eb050513          	addi	a0,a0,-336 # 80024490 <log>
    800065e8:	ffffb097          	auipc	ra,0xffffb
    800065ec:	c86080e7          	jalr	-890(ra) # 8000126e <acquire>
    log.committing = 0;
    800065f0:	0001e797          	auipc	a5,0x1e
    800065f4:	ea078793          	addi	a5,a5,-352 # 80024490 <log>
    800065f8:	0207a223          	sw	zero,36(a5)
    wakeup(&log);
    800065fc:	0001e517          	auipc	a0,0x1e
    80006600:	e9450513          	addi	a0,a0,-364 # 80024490 <log>
    80006604:	ffffd097          	auipc	ra,0xffffd
    80006608:	fa0080e7          	jalr	-96(ra) # 800035a4 <wakeup>
    release(&log.lock);
    8000660c:	0001e517          	auipc	a0,0x1e
    80006610:	e8450513          	addi	a0,a0,-380 # 80024490 <log>
    80006614:	ffffb097          	auipc	ra,0xffffb
    80006618:	cbe080e7          	jalr	-834(ra) # 800012d2 <release>
  }
}
    8000661c:	0001                	nop
    8000661e:	60e2                	ld	ra,24(sp)
    80006620:	6442                	ld	s0,16(sp)
    80006622:	6105                	addi	sp,sp,32
    80006624:	8082                	ret

0000000080006626 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
    80006626:	7179                	addi	sp,sp,-48
    80006628:	f406                	sd	ra,40(sp)
    8000662a:	f022                	sd	s0,32(sp)
    8000662c:	1800                	addi	s0,sp,48
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    8000662e:	fe042623          	sw	zero,-20(s0)
    80006632:	a86d                	j	800066ec <write_log+0xc6>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80006634:	0001e797          	auipc	a5,0x1e
    80006638:	e5c78793          	addi	a5,a5,-420 # 80024490 <log>
    8000663c:	579c                	lw	a5,40(a5)
    8000663e:	0007869b          	sext.w	a3,a5
    80006642:	0001e797          	auipc	a5,0x1e
    80006646:	e4e78793          	addi	a5,a5,-434 # 80024490 <log>
    8000664a:	4f9c                	lw	a5,24(a5)
    8000664c:	fec42703          	lw	a4,-20(s0)
    80006650:	9fb9                	addw	a5,a5,a4
    80006652:	2781                	sext.w	a5,a5
    80006654:	2785                	addiw	a5,a5,1
    80006656:	2781                	sext.w	a5,a5
    80006658:	2781                	sext.w	a5,a5
    8000665a:	85be                	mv	a1,a5
    8000665c:	8536                	mv	a0,a3
    8000665e:	ffffe097          	auipc	ra,0xffffe
    80006662:	3dc080e7          	jalr	988(ra) # 80004a3a <bread>
    80006666:	fea43023          	sd	a0,-32(s0)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000666a:	0001e797          	auipc	a5,0x1e
    8000666e:	e2678793          	addi	a5,a5,-474 # 80024490 <log>
    80006672:	579c                	lw	a5,40(a5)
    80006674:	0007869b          	sext.w	a3,a5
    80006678:	0001e717          	auipc	a4,0x1e
    8000667c:	e1870713          	addi	a4,a4,-488 # 80024490 <log>
    80006680:	fec42783          	lw	a5,-20(s0)
    80006684:	07a1                	addi	a5,a5,8
    80006686:	078a                	slli	a5,a5,0x2
    80006688:	97ba                	add	a5,a5,a4
    8000668a:	4b9c                	lw	a5,16(a5)
    8000668c:	2781                	sext.w	a5,a5
    8000668e:	85be                	mv	a1,a5
    80006690:	8536                	mv	a0,a3
    80006692:	ffffe097          	auipc	ra,0xffffe
    80006696:	3a8080e7          	jalr	936(ra) # 80004a3a <bread>
    8000669a:	fca43c23          	sd	a0,-40(s0)
    memmove(to->data, from->data, BSIZE);
    8000669e:	fe043783          	ld	a5,-32(s0)
    800066a2:	05878713          	addi	a4,a5,88
    800066a6:	fd843783          	ld	a5,-40(s0)
    800066aa:	05878793          	addi	a5,a5,88
    800066ae:	40000613          	li	a2,1024
    800066b2:	85be                	mv	a1,a5
    800066b4:	853a                	mv	a0,a4
    800066b6:	ffffb097          	auipc	ra,0xffffb
    800066ba:	e70080e7          	jalr	-400(ra) # 80001526 <memmove>
    bwrite(to);  // write the log
    800066be:	fe043503          	ld	a0,-32(s0)
    800066c2:	ffffe097          	auipc	ra,0xffffe
    800066c6:	3d2080e7          	jalr	978(ra) # 80004a94 <bwrite>
    brelse(from);
    800066ca:	fd843503          	ld	a0,-40(s0)
    800066ce:	ffffe097          	auipc	ra,0xffffe
    800066d2:	40e080e7          	jalr	1038(ra) # 80004adc <brelse>
    brelse(to);
    800066d6:	fe043503          	ld	a0,-32(s0)
    800066da:	ffffe097          	auipc	ra,0xffffe
    800066de:	402080e7          	jalr	1026(ra) # 80004adc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800066e2:	fec42783          	lw	a5,-20(s0)
    800066e6:	2785                	addiw	a5,a5,1
    800066e8:	fef42623          	sw	a5,-20(s0)
    800066ec:	0001e797          	auipc	a5,0x1e
    800066f0:	da478793          	addi	a5,a5,-604 # 80024490 <log>
    800066f4:	57d8                	lw	a4,44(a5)
    800066f6:	fec42783          	lw	a5,-20(s0)
    800066fa:	2781                	sext.w	a5,a5
    800066fc:	f2e7cce3          	blt	a5,a4,80006634 <write_log+0xe>
  }
}
    80006700:	0001                	nop
    80006702:	0001                	nop
    80006704:	70a2                	ld	ra,40(sp)
    80006706:	7402                	ld	s0,32(sp)
    80006708:	6145                	addi	sp,sp,48
    8000670a:	8082                	ret

000000008000670c <commit>:

static void
commit()
{
    8000670c:	1141                	addi	sp,sp,-16
    8000670e:	e406                	sd	ra,8(sp)
    80006710:	e022                	sd	s0,0(sp)
    80006712:	0800                	addi	s0,sp,16
  if (log.lh.n > 0) {
    80006714:	0001e797          	auipc	a5,0x1e
    80006718:	d7c78793          	addi	a5,a5,-644 # 80024490 <log>
    8000671c:	57dc                	lw	a5,44(a5)
    8000671e:	02f05963          	blez	a5,80006750 <commit+0x44>
    write_log();     // Write modified blocks from cache to log
    80006722:	00000097          	auipc	ra,0x0
    80006726:	f04080e7          	jalr	-252(ra) # 80006626 <write_log>
    write_head();    // Write header to disk -- the real commit
    8000672a:	00000097          	auipc	ra,0x0
    8000672e:	c64080e7          	jalr	-924(ra) # 8000638e <write_head>
    install_trans(0); // Now install writes to home locations
    80006732:	4501                	li	a0,0
    80006734:	00000097          	auipc	ra,0x0
    80006738:	ab0080e7          	jalr	-1360(ra) # 800061e4 <install_trans>
    log.lh.n = 0;
    8000673c:	0001e797          	auipc	a5,0x1e
    80006740:	d5478793          	addi	a5,a5,-684 # 80024490 <log>
    80006744:	0207a623          	sw	zero,44(a5)
    write_head();    // Erase the transaction from the log
    80006748:	00000097          	auipc	ra,0x0
    8000674c:	c46080e7          	jalr	-954(ra) # 8000638e <write_head>
  }
}
    80006750:	0001                	nop
    80006752:	60a2                	ld	ra,8(sp)
    80006754:	6402                	ld	s0,0(sp)
    80006756:	0141                	addi	sp,sp,16
    80006758:	8082                	ret

000000008000675a <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000675a:	7179                	addi	sp,sp,-48
    8000675c:	f406                	sd	ra,40(sp)
    8000675e:	f022                	sd	s0,32(sp)
    80006760:	1800                	addi	s0,sp,48
    80006762:	fca43c23          	sd	a0,-40(s0)
  int i;

  acquire(&log.lock);
    80006766:	0001e517          	auipc	a0,0x1e
    8000676a:	d2a50513          	addi	a0,a0,-726 # 80024490 <log>
    8000676e:	ffffb097          	auipc	ra,0xffffb
    80006772:	b00080e7          	jalr	-1280(ra) # 8000126e <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80006776:	0001e797          	auipc	a5,0x1e
    8000677a:	d1a78793          	addi	a5,a5,-742 # 80024490 <log>
    8000677e:	57dc                	lw	a5,44(a5)
    80006780:	873e                	mv	a4,a5
    80006782:	47f5                	li	a5,29
    80006784:	02e7c063          	blt	a5,a4,800067a4 <log_write+0x4a>
    80006788:	0001e797          	auipc	a5,0x1e
    8000678c:	d0878793          	addi	a5,a5,-760 # 80024490 <log>
    80006790:	57d8                	lw	a4,44(a5)
    80006792:	0001e797          	auipc	a5,0x1e
    80006796:	cfe78793          	addi	a5,a5,-770 # 80024490 <log>
    8000679a:	4fdc                	lw	a5,28(a5)
    8000679c:	37fd                	addiw	a5,a5,-1
    8000679e:	2781                	sext.w	a5,a5
    800067a0:	00f74a63          	blt	a4,a5,800067b4 <log_write+0x5a>
    panic("too big a transaction");
    800067a4:	00005517          	auipc	a0,0x5
    800067a8:	db450513          	addi	a0,a0,-588 # 8000b558 <etext+0x558>
    800067ac:	ffffa097          	auipc	ra,0xffffa
    800067b0:	4d2080e7          	jalr	1234(ra) # 80000c7e <panic>
  if (log.outstanding < 1)
    800067b4:	0001e797          	auipc	a5,0x1e
    800067b8:	cdc78793          	addi	a5,a5,-804 # 80024490 <log>
    800067bc:	539c                	lw	a5,32(a5)
    800067be:	00f04a63          	bgtz	a5,800067d2 <log_write+0x78>
    panic("log_write outside of trans");
    800067c2:	00005517          	auipc	a0,0x5
    800067c6:	dae50513          	addi	a0,a0,-594 # 8000b570 <etext+0x570>
    800067ca:	ffffa097          	auipc	ra,0xffffa
    800067ce:	4b4080e7          	jalr	1204(ra) # 80000c7e <panic>

  for (i = 0; i < log.lh.n; i++) {
    800067d2:	fe042623          	sw	zero,-20(s0)
    800067d6:	a03d                	j	80006804 <log_write+0xaa>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800067d8:	0001e717          	auipc	a4,0x1e
    800067dc:	cb870713          	addi	a4,a4,-840 # 80024490 <log>
    800067e0:	fec42783          	lw	a5,-20(s0)
    800067e4:	07a1                	addi	a5,a5,8
    800067e6:	078a                	slli	a5,a5,0x2
    800067e8:	97ba                	add	a5,a5,a4
    800067ea:	4b9c                	lw	a5,16(a5)
    800067ec:	0007871b          	sext.w	a4,a5
    800067f0:	fd843783          	ld	a5,-40(s0)
    800067f4:	47dc                	lw	a5,12(a5)
    800067f6:	02f70263          	beq	a4,a5,8000681a <log_write+0xc0>
  for (i = 0; i < log.lh.n; i++) {
    800067fa:	fec42783          	lw	a5,-20(s0)
    800067fe:	2785                	addiw	a5,a5,1
    80006800:	fef42623          	sw	a5,-20(s0)
    80006804:	0001e797          	auipc	a5,0x1e
    80006808:	c8c78793          	addi	a5,a5,-884 # 80024490 <log>
    8000680c:	57d8                	lw	a4,44(a5)
    8000680e:	fec42783          	lw	a5,-20(s0)
    80006812:	2781                	sext.w	a5,a5
    80006814:	fce7c2e3          	blt	a5,a4,800067d8 <log_write+0x7e>
    80006818:	a011                	j	8000681c <log_write+0xc2>
      break;
    8000681a:	0001                	nop
  }
  log.lh.block[i] = b->blockno;
    8000681c:	fd843783          	ld	a5,-40(s0)
    80006820:	47dc                	lw	a5,12(a5)
    80006822:	0007871b          	sext.w	a4,a5
    80006826:	0001e697          	auipc	a3,0x1e
    8000682a:	c6a68693          	addi	a3,a3,-918 # 80024490 <log>
    8000682e:	fec42783          	lw	a5,-20(s0)
    80006832:	07a1                	addi	a5,a5,8
    80006834:	078a                	slli	a5,a5,0x2
    80006836:	97b6                	add	a5,a5,a3
    80006838:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    8000683a:	0001e797          	auipc	a5,0x1e
    8000683e:	c5678793          	addi	a5,a5,-938 # 80024490 <log>
    80006842:	57d8                	lw	a4,44(a5)
    80006844:	fec42783          	lw	a5,-20(s0)
    80006848:	2781                	sext.w	a5,a5
    8000684a:	02e79563          	bne	a5,a4,80006874 <log_write+0x11a>
    bpin(b);
    8000684e:	fd843503          	ld	a0,-40(s0)
    80006852:	ffffe097          	auipc	ra,0xffffe
    80006856:	378080e7          	jalr	888(ra) # 80004bca <bpin>
    log.lh.n++;
    8000685a:	0001e797          	auipc	a5,0x1e
    8000685e:	c3678793          	addi	a5,a5,-970 # 80024490 <log>
    80006862:	57dc                	lw	a5,44(a5)
    80006864:	2785                	addiw	a5,a5,1
    80006866:	0007871b          	sext.w	a4,a5
    8000686a:	0001e797          	auipc	a5,0x1e
    8000686e:	c2678793          	addi	a5,a5,-986 # 80024490 <log>
    80006872:	d7d8                	sw	a4,44(a5)
  }
  release(&log.lock);
    80006874:	0001e517          	auipc	a0,0x1e
    80006878:	c1c50513          	addi	a0,a0,-996 # 80024490 <log>
    8000687c:	ffffb097          	auipc	ra,0xffffb
    80006880:	a56080e7          	jalr	-1450(ra) # 800012d2 <release>
}
    80006884:	0001                	nop
    80006886:	70a2                	ld	ra,40(sp)
    80006888:	7402                	ld	s0,32(sp)
    8000688a:	6145                	addi	sp,sp,48
    8000688c:	8082                	ret

000000008000688e <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000688e:	1101                	addi	sp,sp,-32
    80006890:	ec06                	sd	ra,24(sp)
    80006892:	e822                	sd	s0,16(sp)
    80006894:	1000                	addi	s0,sp,32
    80006896:	fea43423          	sd	a0,-24(s0)
    8000689a:	feb43023          	sd	a1,-32(s0)
  initlock(&lk->lk, "sleep lock");
    8000689e:	fe843783          	ld	a5,-24(s0)
    800068a2:	07a1                	addi	a5,a5,8
    800068a4:	00005597          	auipc	a1,0x5
    800068a8:	cec58593          	addi	a1,a1,-788 # 8000b590 <etext+0x590>
    800068ac:	853e                	mv	a0,a5
    800068ae:	ffffb097          	auipc	ra,0xffffb
    800068b2:	990080e7          	jalr	-1648(ra) # 8000123e <initlock>
  lk->name = name;
    800068b6:	fe843783          	ld	a5,-24(s0)
    800068ba:	fe043703          	ld	a4,-32(s0)
    800068be:	f398                	sd	a4,32(a5)
  lk->locked = 0;
    800068c0:	fe843783          	ld	a5,-24(s0)
    800068c4:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    800068c8:	fe843783          	ld	a5,-24(s0)
    800068cc:	0207a423          	sw	zero,40(a5)
}
    800068d0:	0001                	nop
    800068d2:	60e2                	ld	ra,24(sp)
    800068d4:	6442                	ld	s0,16(sp)
    800068d6:	6105                	addi	sp,sp,32
    800068d8:	8082                	ret

00000000800068da <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800068da:	1101                	addi	sp,sp,-32
    800068dc:	ec06                	sd	ra,24(sp)
    800068de:	e822                	sd	s0,16(sp)
    800068e0:	1000                	addi	s0,sp,32
    800068e2:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    800068e6:	fe843783          	ld	a5,-24(s0)
    800068ea:	07a1                	addi	a5,a5,8
    800068ec:	853e                	mv	a0,a5
    800068ee:	ffffb097          	auipc	ra,0xffffb
    800068f2:	980080e7          	jalr	-1664(ra) # 8000126e <acquire>
  while (lk->locked) {
    800068f6:	a819                	j	8000690c <acquiresleep+0x32>
    sleep(lk, &lk->lk);
    800068f8:	fe843783          	ld	a5,-24(s0)
    800068fc:	07a1                	addi	a5,a5,8
    800068fe:	85be                	mv	a1,a5
    80006900:	fe843503          	ld	a0,-24(s0)
    80006904:	ffffd097          	auipc	ra,0xffffd
    80006908:	bdc080e7          	jalr	-1060(ra) # 800034e0 <sleep>
  while (lk->locked) {
    8000690c:	fe843783          	ld	a5,-24(s0)
    80006910:	439c                	lw	a5,0(a5)
    80006912:	f3fd                	bnez	a5,800068f8 <acquiresleep+0x1e>
  }
  lk->locked = 1;
    80006914:	fe843783          	ld	a5,-24(s0)
    80006918:	4705                	li	a4,1
    8000691a:	c398                	sw	a4,0(a5)
  lk->pid = myproc()->pid;
    8000691c:	ffffc097          	auipc	ra,0xffffc
    80006920:	ef8080e7          	jalr	-264(ra) # 80002814 <myproc>
    80006924:	87aa                	mv	a5,a0
    80006926:	5b98                	lw	a4,48(a5)
    80006928:	fe843783          	ld	a5,-24(s0)
    8000692c:	d798                	sw	a4,40(a5)
  release(&lk->lk);
    8000692e:	fe843783          	ld	a5,-24(s0)
    80006932:	07a1                	addi	a5,a5,8
    80006934:	853e                	mv	a0,a5
    80006936:	ffffb097          	auipc	ra,0xffffb
    8000693a:	99c080e7          	jalr	-1636(ra) # 800012d2 <release>
}
    8000693e:	0001                	nop
    80006940:	60e2                	ld	ra,24(sp)
    80006942:	6442                	ld	s0,16(sp)
    80006944:	6105                	addi	sp,sp,32
    80006946:	8082                	ret

0000000080006948 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80006948:	1101                	addi	sp,sp,-32
    8000694a:	ec06                	sd	ra,24(sp)
    8000694c:	e822                	sd	s0,16(sp)
    8000694e:	1000                	addi	s0,sp,32
    80006950:	fea43423          	sd	a0,-24(s0)
  acquire(&lk->lk);
    80006954:	fe843783          	ld	a5,-24(s0)
    80006958:	07a1                	addi	a5,a5,8
    8000695a:	853e                	mv	a0,a5
    8000695c:	ffffb097          	auipc	ra,0xffffb
    80006960:	912080e7          	jalr	-1774(ra) # 8000126e <acquire>
  lk->locked = 0;
    80006964:	fe843783          	ld	a5,-24(s0)
    80006968:	0007a023          	sw	zero,0(a5)
  lk->pid = 0;
    8000696c:	fe843783          	ld	a5,-24(s0)
    80006970:	0207a423          	sw	zero,40(a5)
  wakeup(lk);
    80006974:	fe843503          	ld	a0,-24(s0)
    80006978:	ffffd097          	auipc	ra,0xffffd
    8000697c:	c2c080e7          	jalr	-980(ra) # 800035a4 <wakeup>
  release(&lk->lk);
    80006980:	fe843783          	ld	a5,-24(s0)
    80006984:	07a1                	addi	a5,a5,8
    80006986:	853e                	mv	a0,a5
    80006988:	ffffb097          	auipc	ra,0xffffb
    8000698c:	94a080e7          	jalr	-1718(ra) # 800012d2 <release>
}
    80006990:	0001                	nop
    80006992:	60e2                	ld	ra,24(sp)
    80006994:	6442                	ld	s0,16(sp)
    80006996:	6105                	addi	sp,sp,32
    80006998:	8082                	ret

000000008000699a <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    8000699a:	7139                	addi	sp,sp,-64
    8000699c:	fc06                	sd	ra,56(sp)
    8000699e:	f822                	sd	s0,48(sp)
    800069a0:	f426                	sd	s1,40(sp)
    800069a2:	0080                	addi	s0,sp,64
    800069a4:	fca43423          	sd	a0,-56(s0)
  int r;
  
  acquire(&lk->lk);
    800069a8:	fc843783          	ld	a5,-56(s0)
    800069ac:	07a1                	addi	a5,a5,8
    800069ae:	853e                	mv	a0,a5
    800069b0:	ffffb097          	auipc	ra,0xffffb
    800069b4:	8be080e7          	jalr	-1858(ra) # 8000126e <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800069b8:	fc843783          	ld	a5,-56(s0)
    800069bc:	439c                	lw	a5,0(a5)
    800069be:	cf99                	beqz	a5,800069dc <holdingsleep+0x42>
    800069c0:	fc843783          	ld	a5,-56(s0)
    800069c4:	5784                	lw	s1,40(a5)
    800069c6:	ffffc097          	auipc	ra,0xffffc
    800069ca:	e4e080e7          	jalr	-434(ra) # 80002814 <myproc>
    800069ce:	87aa                	mv	a5,a0
    800069d0:	5b9c                	lw	a5,48(a5)
    800069d2:	8726                	mv	a4,s1
    800069d4:	00f71463          	bne	a4,a5,800069dc <holdingsleep+0x42>
    800069d8:	4785                	li	a5,1
    800069da:	a011                	j	800069de <holdingsleep+0x44>
    800069dc:	4781                	li	a5,0
    800069de:	fcf42e23          	sw	a5,-36(s0)
  release(&lk->lk);
    800069e2:	fc843783          	ld	a5,-56(s0)
    800069e6:	07a1                	addi	a5,a5,8
    800069e8:	853e                	mv	a0,a5
    800069ea:	ffffb097          	auipc	ra,0xffffb
    800069ee:	8e8080e7          	jalr	-1816(ra) # 800012d2 <release>
  return r;
    800069f2:	fdc42783          	lw	a5,-36(s0)
}
    800069f6:	853e                	mv	a0,a5
    800069f8:	70e2                	ld	ra,56(sp)
    800069fa:	7442                	ld	s0,48(sp)
    800069fc:	74a2                	ld	s1,40(sp)
    800069fe:	6121                	addi	sp,sp,64
    80006a00:	8082                	ret

0000000080006a02 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80006a02:	1141                	addi	sp,sp,-16
    80006a04:	e406                	sd	ra,8(sp)
    80006a06:	e022                	sd	s0,0(sp)
    80006a08:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80006a0a:	00005597          	auipc	a1,0x5
    80006a0e:	b9658593          	addi	a1,a1,-1130 # 8000b5a0 <etext+0x5a0>
    80006a12:	0001e517          	auipc	a0,0x1e
    80006a16:	bc650513          	addi	a0,a0,-1082 # 800245d8 <ftable>
    80006a1a:	ffffb097          	auipc	ra,0xffffb
    80006a1e:	824080e7          	jalr	-2012(ra) # 8000123e <initlock>
}
    80006a22:	0001                	nop
    80006a24:	60a2                	ld	ra,8(sp)
    80006a26:	6402                	ld	s0,0(sp)
    80006a28:	0141                	addi	sp,sp,16
    80006a2a:	8082                	ret

0000000080006a2c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80006a2c:	1101                	addi	sp,sp,-32
    80006a2e:	ec06                	sd	ra,24(sp)
    80006a30:	e822                	sd	s0,16(sp)
    80006a32:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80006a34:	0001e517          	auipc	a0,0x1e
    80006a38:	ba450513          	addi	a0,a0,-1116 # 800245d8 <ftable>
    80006a3c:	ffffb097          	auipc	ra,0xffffb
    80006a40:	832080e7          	jalr	-1998(ra) # 8000126e <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80006a44:	0001e797          	auipc	a5,0x1e
    80006a48:	bac78793          	addi	a5,a5,-1108 # 800245f0 <ftable+0x18>
    80006a4c:	fef43423          	sd	a5,-24(s0)
    80006a50:	a815                	j	80006a84 <filealloc+0x58>
    if(f->ref == 0){
    80006a52:	fe843783          	ld	a5,-24(s0)
    80006a56:	43dc                	lw	a5,4(a5)
    80006a58:	e385                	bnez	a5,80006a78 <filealloc+0x4c>
      f->ref = 1;
    80006a5a:	fe843783          	ld	a5,-24(s0)
    80006a5e:	4705                	li	a4,1
    80006a60:	c3d8                	sw	a4,4(a5)
      release(&ftable.lock);
    80006a62:	0001e517          	auipc	a0,0x1e
    80006a66:	b7650513          	addi	a0,a0,-1162 # 800245d8 <ftable>
    80006a6a:	ffffb097          	auipc	ra,0xffffb
    80006a6e:	868080e7          	jalr	-1944(ra) # 800012d2 <release>
      return f;
    80006a72:	fe843783          	ld	a5,-24(s0)
    80006a76:	a805                	j	80006aa6 <filealloc+0x7a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80006a78:	fe843783          	ld	a5,-24(s0)
    80006a7c:	02878793          	addi	a5,a5,40
    80006a80:	fef43423          	sd	a5,-24(s0)
    80006a84:	0001f797          	auipc	a5,0x1f
    80006a88:	b0c78793          	addi	a5,a5,-1268 # 80025590 <ftable+0xfb8>
    80006a8c:	fe843703          	ld	a4,-24(s0)
    80006a90:	fcf761e3          	bltu	a4,a5,80006a52 <filealloc+0x26>
    }
  }
  release(&ftable.lock);
    80006a94:	0001e517          	auipc	a0,0x1e
    80006a98:	b4450513          	addi	a0,a0,-1212 # 800245d8 <ftable>
    80006a9c:	ffffb097          	auipc	ra,0xffffb
    80006aa0:	836080e7          	jalr	-1994(ra) # 800012d2 <release>
  return 0;
    80006aa4:	4781                	li	a5,0
}
    80006aa6:	853e                	mv	a0,a5
    80006aa8:	60e2                	ld	ra,24(sp)
    80006aaa:	6442                	ld	s0,16(sp)
    80006aac:	6105                	addi	sp,sp,32
    80006aae:	8082                	ret

0000000080006ab0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80006ab0:	1101                	addi	sp,sp,-32
    80006ab2:	ec06                	sd	ra,24(sp)
    80006ab4:	e822                	sd	s0,16(sp)
    80006ab6:	1000                	addi	s0,sp,32
    80006ab8:	fea43423          	sd	a0,-24(s0)
  acquire(&ftable.lock);
    80006abc:	0001e517          	auipc	a0,0x1e
    80006ac0:	b1c50513          	addi	a0,a0,-1252 # 800245d8 <ftable>
    80006ac4:	ffffa097          	auipc	ra,0xffffa
    80006ac8:	7aa080e7          	jalr	1962(ra) # 8000126e <acquire>
  if(f->ref < 1)
    80006acc:	fe843783          	ld	a5,-24(s0)
    80006ad0:	43dc                	lw	a5,4(a5)
    80006ad2:	00f04a63          	bgtz	a5,80006ae6 <filedup+0x36>
    panic("filedup");
    80006ad6:	00005517          	auipc	a0,0x5
    80006ada:	ad250513          	addi	a0,a0,-1326 # 8000b5a8 <etext+0x5a8>
    80006ade:	ffffa097          	auipc	ra,0xffffa
    80006ae2:	1a0080e7          	jalr	416(ra) # 80000c7e <panic>
  f->ref++;
    80006ae6:	fe843783          	ld	a5,-24(s0)
    80006aea:	43dc                	lw	a5,4(a5)
    80006aec:	2785                	addiw	a5,a5,1
    80006aee:	0007871b          	sext.w	a4,a5
    80006af2:	fe843783          	ld	a5,-24(s0)
    80006af6:	c3d8                	sw	a4,4(a5)
  release(&ftable.lock);
    80006af8:	0001e517          	auipc	a0,0x1e
    80006afc:	ae050513          	addi	a0,a0,-1312 # 800245d8 <ftable>
    80006b00:	ffffa097          	auipc	ra,0xffffa
    80006b04:	7d2080e7          	jalr	2002(ra) # 800012d2 <release>
  return f;
    80006b08:	fe843783          	ld	a5,-24(s0)
}
    80006b0c:	853e                	mv	a0,a5
    80006b0e:	60e2                	ld	ra,24(sp)
    80006b10:	6442                	ld	s0,16(sp)
    80006b12:	6105                	addi	sp,sp,32
    80006b14:	8082                	ret

0000000080006b16 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80006b16:	715d                	addi	sp,sp,-80
    80006b18:	e486                	sd	ra,72(sp)
    80006b1a:	e0a2                	sd	s0,64(sp)
    80006b1c:	0880                	addi	s0,sp,80
    80006b1e:	faa43c23          	sd	a0,-72(s0)
  struct file ff;

  acquire(&ftable.lock);
    80006b22:	0001e517          	auipc	a0,0x1e
    80006b26:	ab650513          	addi	a0,a0,-1354 # 800245d8 <ftable>
    80006b2a:	ffffa097          	auipc	ra,0xffffa
    80006b2e:	744080e7          	jalr	1860(ra) # 8000126e <acquire>
  if(f->ref < 1)
    80006b32:	fb843783          	ld	a5,-72(s0)
    80006b36:	43dc                	lw	a5,4(a5)
    80006b38:	00f04a63          	bgtz	a5,80006b4c <fileclose+0x36>
    panic("fileclose");
    80006b3c:	00005517          	auipc	a0,0x5
    80006b40:	a7450513          	addi	a0,a0,-1420 # 8000b5b0 <etext+0x5b0>
    80006b44:	ffffa097          	auipc	ra,0xffffa
    80006b48:	13a080e7          	jalr	314(ra) # 80000c7e <panic>
  if(--f->ref > 0){
    80006b4c:	fb843783          	ld	a5,-72(s0)
    80006b50:	43dc                	lw	a5,4(a5)
    80006b52:	37fd                	addiw	a5,a5,-1
    80006b54:	0007871b          	sext.w	a4,a5
    80006b58:	fb843783          	ld	a5,-72(s0)
    80006b5c:	c3d8                	sw	a4,4(a5)
    80006b5e:	fb843783          	ld	a5,-72(s0)
    80006b62:	43dc                	lw	a5,4(a5)
    80006b64:	00f05b63          	blez	a5,80006b7a <fileclose+0x64>
    release(&ftable.lock);
    80006b68:	0001e517          	auipc	a0,0x1e
    80006b6c:	a7050513          	addi	a0,a0,-1424 # 800245d8 <ftable>
    80006b70:	ffffa097          	auipc	ra,0xffffa
    80006b74:	762080e7          	jalr	1890(ra) # 800012d2 <release>
    80006b78:	a879                	j	80006c16 <fileclose+0x100>
    return;
  }
  ff = *f;
    80006b7a:	fb843783          	ld	a5,-72(s0)
    80006b7e:	638c                	ld	a1,0(a5)
    80006b80:	6790                	ld	a2,8(a5)
    80006b82:	6b94                	ld	a3,16(a5)
    80006b84:	6f98                	ld	a4,24(a5)
    80006b86:	739c                	ld	a5,32(a5)
    80006b88:	fcb43423          	sd	a1,-56(s0)
    80006b8c:	fcc43823          	sd	a2,-48(s0)
    80006b90:	fcd43c23          	sd	a3,-40(s0)
    80006b94:	fee43023          	sd	a4,-32(s0)
    80006b98:	fef43423          	sd	a5,-24(s0)
  f->ref = 0;
    80006b9c:	fb843783          	ld	a5,-72(s0)
    80006ba0:	0007a223          	sw	zero,4(a5)
  f->type = FD_NONE;
    80006ba4:	fb843783          	ld	a5,-72(s0)
    80006ba8:	0007a023          	sw	zero,0(a5)
  release(&ftable.lock);
    80006bac:	0001e517          	auipc	a0,0x1e
    80006bb0:	a2c50513          	addi	a0,a0,-1492 # 800245d8 <ftable>
    80006bb4:	ffffa097          	auipc	ra,0xffffa
    80006bb8:	71e080e7          	jalr	1822(ra) # 800012d2 <release>

  if(ff.type == FD_PIPE){
    80006bbc:	fc842783          	lw	a5,-56(s0)
    80006bc0:	873e                	mv	a4,a5
    80006bc2:	4785                	li	a5,1
    80006bc4:	00f71e63          	bne	a4,a5,80006be0 <fileclose+0xca>
    pipeclose(ff.pipe, ff.writable);
    80006bc8:	fd843783          	ld	a5,-40(s0)
    80006bcc:	fd144703          	lbu	a4,-47(s0)
    80006bd0:	2701                	sext.w	a4,a4
    80006bd2:	85ba                	mv	a1,a4
    80006bd4:	853e                	mv	a0,a5
    80006bd6:	00000097          	auipc	ra,0x0
    80006bda:	5aa080e7          	jalr	1450(ra) # 80007180 <pipeclose>
    80006bde:	a825                	j	80006c16 <fileclose+0x100>
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80006be0:	fc842783          	lw	a5,-56(s0)
    80006be4:	873e                	mv	a4,a5
    80006be6:	4789                	li	a5,2
    80006be8:	00f70863          	beq	a4,a5,80006bf8 <fileclose+0xe2>
    80006bec:	fc842783          	lw	a5,-56(s0)
    80006bf0:	873e                	mv	a4,a5
    80006bf2:	478d                	li	a5,3
    80006bf4:	02f71163          	bne	a4,a5,80006c16 <fileclose+0x100>
    begin_op();
    80006bf8:	00000097          	auipc	ra,0x0
    80006bfc:	884080e7          	jalr	-1916(ra) # 8000647c <begin_op>
    iput(ff.ip);
    80006c00:	fe043783          	ld	a5,-32(s0)
    80006c04:	853e                	mv	a0,a5
    80006c06:	fffff097          	auipc	ra,0xfffff
    80006c0a:	9aa080e7          	jalr	-1622(ra) # 800055b0 <iput>
    end_op();
    80006c0e:	00000097          	auipc	ra,0x0
    80006c12:	930080e7          	jalr	-1744(ra) # 8000653e <end_op>
  }
}
    80006c16:	60a6                	ld	ra,72(sp)
    80006c18:	6406                	ld	s0,64(sp)
    80006c1a:	6161                	addi	sp,sp,80
    80006c1c:	8082                	ret

0000000080006c1e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80006c1e:	7139                	addi	sp,sp,-64
    80006c20:	fc06                	sd	ra,56(sp)
    80006c22:	f822                	sd	s0,48(sp)
    80006c24:	0080                	addi	s0,sp,64
    80006c26:	fca43423          	sd	a0,-56(s0)
    80006c2a:	fcb43023          	sd	a1,-64(s0)
  struct proc *p = myproc();
    80006c2e:	ffffc097          	auipc	ra,0xffffc
    80006c32:	be6080e7          	jalr	-1050(ra) # 80002814 <myproc>
    80006c36:	fea43423          	sd	a0,-24(s0)
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80006c3a:	fc843783          	ld	a5,-56(s0)
    80006c3e:	439c                	lw	a5,0(a5)
    80006c40:	873e                	mv	a4,a5
    80006c42:	4789                	li	a5,2
    80006c44:	00f70963          	beq	a4,a5,80006c56 <filestat+0x38>
    80006c48:	fc843783          	ld	a5,-56(s0)
    80006c4c:	439c                	lw	a5,0(a5)
    80006c4e:	873e                	mv	a4,a5
    80006c50:	478d                	li	a5,3
    80006c52:	06f71263          	bne	a4,a5,80006cb6 <filestat+0x98>
    ilock(f->ip);
    80006c56:	fc843783          	ld	a5,-56(s0)
    80006c5a:	6f9c                	ld	a5,24(a5)
    80006c5c:	853e                	mv	a0,a5
    80006c5e:	ffffe097          	auipc	ra,0xffffe
    80006c62:	7c4080e7          	jalr	1988(ra) # 80005422 <ilock>
    stati(f->ip, &st);
    80006c66:	fc843783          	ld	a5,-56(s0)
    80006c6a:	6f9c                	ld	a5,24(a5)
    80006c6c:	fd040713          	addi	a4,s0,-48
    80006c70:	85ba                	mv	a1,a4
    80006c72:	853e                	mv	a0,a5
    80006c74:	fffff097          	auipc	ra,0xfffff
    80006c78:	ce0080e7          	jalr	-800(ra) # 80005954 <stati>
    iunlock(f->ip);
    80006c7c:	fc843783          	ld	a5,-56(s0)
    80006c80:	6f9c                	ld	a5,24(a5)
    80006c82:	853e                	mv	a0,a5
    80006c84:	fffff097          	auipc	ra,0xfffff
    80006c88:	8d2080e7          	jalr	-1838(ra) # 80005556 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80006c8c:	fe843783          	ld	a5,-24(s0)
    80006c90:	6fbc                	ld	a5,88(a5)
    80006c92:	fd040713          	addi	a4,s0,-48
    80006c96:	46e1                	li	a3,24
    80006c98:	863a                	mv	a2,a4
    80006c9a:	fc043583          	ld	a1,-64(s0)
    80006c9e:	853e                	mv	a0,a5
    80006ca0:	ffffb097          	auipc	ra,0xffffb
    80006ca4:	646080e7          	jalr	1606(ra) # 800022e6 <copyout>
    80006ca8:	87aa                	mv	a5,a0
    80006caa:	0007d463          	bgez	a5,80006cb2 <filestat+0x94>
      return -1;
    80006cae:	57fd                	li	a5,-1
    80006cb0:	a021                	j	80006cb8 <filestat+0x9a>
    return 0;
    80006cb2:	4781                	li	a5,0
    80006cb4:	a011                	j	80006cb8 <filestat+0x9a>
  }
  return -1;
    80006cb6:	57fd                	li	a5,-1
}
    80006cb8:	853e                	mv	a0,a5
    80006cba:	70e2                	ld	ra,56(sp)
    80006cbc:	7442                	ld	s0,48(sp)
    80006cbe:	6121                	addi	sp,sp,64
    80006cc0:	8082                	ret

0000000080006cc2 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80006cc2:	7139                	addi	sp,sp,-64
    80006cc4:	fc06                	sd	ra,56(sp)
    80006cc6:	f822                	sd	s0,48(sp)
    80006cc8:	0080                	addi	s0,sp,64
    80006cca:	fca43c23          	sd	a0,-40(s0)
    80006cce:	fcb43823          	sd	a1,-48(s0)
    80006cd2:	87b2                	mv	a5,a2
    80006cd4:	fcf42623          	sw	a5,-52(s0)
  int r = 0;
    80006cd8:	fe042623          	sw	zero,-20(s0)

  if(f->readable == 0)
    80006cdc:	fd843783          	ld	a5,-40(s0)
    80006ce0:	0087c783          	lbu	a5,8(a5)
    80006ce4:	e399                	bnez	a5,80006cea <fileread+0x28>
    return -1;
    80006ce6:	57fd                	li	a5,-1
    80006ce8:	aa1d                	j	80006e1e <fileread+0x15c>

  if(f->type == FD_PIPE){
    80006cea:	fd843783          	ld	a5,-40(s0)
    80006cee:	439c                	lw	a5,0(a5)
    80006cf0:	873e                	mv	a4,a5
    80006cf2:	4785                	li	a5,1
    80006cf4:	02f71363          	bne	a4,a5,80006d1a <fileread+0x58>
    r = piperead(f->pipe, addr, n);
    80006cf8:	fd843783          	ld	a5,-40(s0)
    80006cfc:	6b9c                	ld	a5,16(a5)
    80006cfe:	fcc42703          	lw	a4,-52(s0)
    80006d02:	863a                	mv	a2,a4
    80006d04:	fd043583          	ld	a1,-48(s0)
    80006d08:	853e                	mv	a0,a5
    80006d0a:	00000097          	auipc	ra,0x0
    80006d0e:	668080e7          	jalr	1640(ra) # 80007372 <piperead>
    80006d12:	87aa                	mv	a5,a0
    80006d14:	fef42623          	sw	a5,-20(s0)
    80006d18:	a209                	j	80006e1a <fileread+0x158>
  } else if(f->type == FD_DEVICE){
    80006d1a:	fd843783          	ld	a5,-40(s0)
    80006d1e:	439c                	lw	a5,0(a5)
    80006d20:	873e                	mv	a4,a5
    80006d22:	478d                	li	a5,3
    80006d24:	06f71863          	bne	a4,a5,80006d94 <fileread+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80006d28:	fd843783          	ld	a5,-40(s0)
    80006d2c:	02479783          	lh	a5,36(a5)
    80006d30:	2781                	sext.w	a5,a5
    80006d32:	0207c863          	bltz	a5,80006d62 <fileread+0xa0>
    80006d36:	fd843783          	ld	a5,-40(s0)
    80006d3a:	02479783          	lh	a5,36(a5)
    80006d3e:	0007871b          	sext.w	a4,a5
    80006d42:	47a5                	li	a5,9
    80006d44:	00e7cf63          	blt	a5,a4,80006d62 <fileread+0xa0>
    80006d48:	fd843783          	ld	a5,-40(s0)
    80006d4c:	02479783          	lh	a5,36(a5)
    80006d50:	2781                	sext.w	a5,a5
    80006d52:	0001d717          	auipc	a4,0x1d
    80006d56:	7e670713          	addi	a4,a4,2022 # 80024538 <devsw>
    80006d5a:	0792                	slli	a5,a5,0x4
    80006d5c:	97ba                	add	a5,a5,a4
    80006d5e:	639c                	ld	a5,0(a5)
    80006d60:	e399                	bnez	a5,80006d66 <fileread+0xa4>
      return -1;
    80006d62:	57fd                	li	a5,-1
    80006d64:	a86d                	j	80006e1e <fileread+0x15c>
    r = devsw[f->major].read(1, addr, n);
    80006d66:	fd843783          	ld	a5,-40(s0)
    80006d6a:	02479783          	lh	a5,36(a5)
    80006d6e:	2781                	sext.w	a5,a5
    80006d70:	0001d717          	auipc	a4,0x1d
    80006d74:	7c870713          	addi	a4,a4,1992 # 80024538 <devsw>
    80006d78:	0792                	slli	a5,a5,0x4
    80006d7a:	97ba                	add	a5,a5,a4
    80006d7c:	6398                	ld	a4,0(a5)
    80006d7e:	fcc42783          	lw	a5,-52(s0)
    80006d82:	863e                	mv	a2,a5
    80006d84:	fd043583          	ld	a1,-48(s0)
    80006d88:	4505                	li	a0,1
    80006d8a:	9702                	jalr	a4
    80006d8c:	87aa                	mv	a5,a0
    80006d8e:	fef42623          	sw	a5,-20(s0)
    80006d92:	a061                	j	80006e1a <fileread+0x158>
  } else if(f->type == FD_INODE){
    80006d94:	fd843783          	ld	a5,-40(s0)
    80006d98:	439c                	lw	a5,0(a5)
    80006d9a:	873e                	mv	a4,a5
    80006d9c:	4789                	li	a5,2
    80006d9e:	06f71663          	bne	a4,a5,80006e0a <fileread+0x148>
    ilock(f->ip);
    80006da2:	fd843783          	ld	a5,-40(s0)
    80006da6:	6f9c                	ld	a5,24(a5)
    80006da8:	853e                	mv	a0,a5
    80006daa:	ffffe097          	auipc	ra,0xffffe
    80006dae:	678080e7          	jalr	1656(ra) # 80005422 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80006db2:	fd843783          	ld	a5,-40(s0)
    80006db6:	6f88                	ld	a0,24(a5)
    80006db8:	fd843783          	ld	a5,-40(s0)
    80006dbc:	539c                	lw	a5,32(a5)
    80006dbe:	fcc42703          	lw	a4,-52(s0)
    80006dc2:	86be                	mv	a3,a5
    80006dc4:	fd043603          	ld	a2,-48(s0)
    80006dc8:	4585                	li	a1,1
    80006dca:	fffff097          	auipc	ra,0xfffff
    80006dce:	bee080e7          	jalr	-1042(ra) # 800059b8 <readi>
    80006dd2:	87aa                	mv	a5,a0
    80006dd4:	fef42623          	sw	a5,-20(s0)
    80006dd8:	fec42783          	lw	a5,-20(s0)
    80006ddc:	2781                	sext.w	a5,a5
    80006dde:	00f05d63          	blez	a5,80006df8 <fileread+0x136>
      f->off += r;
    80006de2:	fd843783          	ld	a5,-40(s0)
    80006de6:	5398                	lw	a4,32(a5)
    80006de8:	fec42783          	lw	a5,-20(s0)
    80006dec:	9fb9                	addw	a5,a5,a4
    80006dee:	0007871b          	sext.w	a4,a5
    80006df2:	fd843783          	ld	a5,-40(s0)
    80006df6:	d398                	sw	a4,32(a5)
    iunlock(f->ip);
    80006df8:	fd843783          	ld	a5,-40(s0)
    80006dfc:	6f9c                	ld	a5,24(a5)
    80006dfe:	853e                	mv	a0,a5
    80006e00:	ffffe097          	auipc	ra,0xffffe
    80006e04:	756080e7          	jalr	1878(ra) # 80005556 <iunlock>
    80006e08:	a809                	j	80006e1a <fileread+0x158>
  } else {
    panic("fileread");
    80006e0a:	00004517          	auipc	a0,0x4
    80006e0e:	7b650513          	addi	a0,a0,1974 # 8000b5c0 <etext+0x5c0>
    80006e12:	ffffa097          	auipc	ra,0xffffa
    80006e16:	e6c080e7          	jalr	-404(ra) # 80000c7e <panic>
  }

  return r;
    80006e1a:	fec42783          	lw	a5,-20(s0)
}
    80006e1e:	853e                	mv	a0,a5
    80006e20:	70e2                	ld	ra,56(sp)
    80006e22:	7442                	ld	s0,48(sp)
    80006e24:	6121                	addi	sp,sp,64
    80006e26:	8082                	ret

0000000080006e28 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80006e28:	715d                	addi	sp,sp,-80
    80006e2a:	e486                	sd	ra,72(sp)
    80006e2c:	e0a2                	sd	s0,64(sp)
    80006e2e:	0880                	addi	s0,sp,80
    80006e30:	fca43423          	sd	a0,-56(s0)
    80006e34:	fcb43023          	sd	a1,-64(s0)
    80006e38:	87b2                	mv	a5,a2
    80006e3a:	faf42e23          	sw	a5,-68(s0)
  int r, ret = 0;
    80006e3e:	fe042623          	sw	zero,-20(s0)

  if(f->writable == 0)
    80006e42:	fc843783          	ld	a5,-56(s0)
    80006e46:	0097c783          	lbu	a5,9(a5)
    80006e4a:	e399                	bnez	a5,80006e50 <filewrite+0x28>
    return -1;
    80006e4c:	57fd                	li	a5,-1
    80006e4e:	aad1                	j	80007022 <filewrite+0x1fa>

  if(f->type == FD_PIPE){
    80006e50:	fc843783          	ld	a5,-56(s0)
    80006e54:	439c                	lw	a5,0(a5)
    80006e56:	873e                	mv	a4,a5
    80006e58:	4785                	li	a5,1
    80006e5a:	02f71363          	bne	a4,a5,80006e80 <filewrite+0x58>
    ret = pipewrite(f->pipe, addr, n);
    80006e5e:	fc843783          	ld	a5,-56(s0)
    80006e62:	6b9c                	ld	a5,16(a5)
    80006e64:	fbc42703          	lw	a4,-68(s0)
    80006e68:	863a                	mv	a2,a4
    80006e6a:	fc043583          	ld	a1,-64(s0)
    80006e6e:	853e                	mv	a0,a5
    80006e70:	00000097          	auipc	ra,0x0
    80006e74:	3b8080e7          	jalr	952(ra) # 80007228 <pipewrite>
    80006e78:	87aa                	mv	a5,a0
    80006e7a:	fef42623          	sw	a5,-20(s0)
    80006e7e:	a245                	j	8000701e <filewrite+0x1f6>
  } else if(f->type == FD_DEVICE){
    80006e80:	fc843783          	ld	a5,-56(s0)
    80006e84:	439c                	lw	a5,0(a5)
    80006e86:	873e                	mv	a4,a5
    80006e88:	478d                	li	a5,3
    80006e8a:	06f71863          	bne	a4,a5,80006efa <filewrite+0xd2>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80006e8e:	fc843783          	ld	a5,-56(s0)
    80006e92:	02479783          	lh	a5,36(a5)
    80006e96:	2781                	sext.w	a5,a5
    80006e98:	0207c863          	bltz	a5,80006ec8 <filewrite+0xa0>
    80006e9c:	fc843783          	ld	a5,-56(s0)
    80006ea0:	02479783          	lh	a5,36(a5)
    80006ea4:	0007871b          	sext.w	a4,a5
    80006ea8:	47a5                	li	a5,9
    80006eaa:	00e7cf63          	blt	a5,a4,80006ec8 <filewrite+0xa0>
    80006eae:	fc843783          	ld	a5,-56(s0)
    80006eb2:	02479783          	lh	a5,36(a5)
    80006eb6:	2781                	sext.w	a5,a5
    80006eb8:	0001d717          	auipc	a4,0x1d
    80006ebc:	68070713          	addi	a4,a4,1664 # 80024538 <devsw>
    80006ec0:	0792                	slli	a5,a5,0x4
    80006ec2:	97ba                	add	a5,a5,a4
    80006ec4:	679c                	ld	a5,8(a5)
    80006ec6:	e399                	bnez	a5,80006ecc <filewrite+0xa4>
      return -1;
    80006ec8:	57fd                	li	a5,-1
    80006eca:	aaa1                	j	80007022 <filewrite+0x1fa>
    ret = devsw[f->major].write(1, addr, n);
    80006ecc:	fc843783          	ld	a5,-56(s0)
    80006ed0:	02479783          	lh	a5,36(a5)
    80006ed4:	2781                	sext.w	a5,a5
    80006ed6:	0001d717          	auipc	a4,0x1d
    80006eda:	66270713          	addi	a4,a4,1634 # 80024538 <devsw>
    80006ede:	0792                	slli	a5,a5,0x4
    80006ee0:	97ba                	add	a5,a5,a4
    80006ee2:	6798                	ld	a4,8(a5)
    80006ee4:	fbc42783          	lw	a5,-68(s0)
    80006ee8:	863e                	mv	a2,a5
    80006eea:	fc043583          	ld	a1,-64(s0)
    80006eee:	4505                	li	a0,1
    80006ef0:	9702                	jalr	a4
    80006ef2:	87aa                	mv	a5,a0
    80006ef4:	fef42623          	sw	a5,-20(s0)
    80006ef8:	a21d                	j	8000701e <filewrite+0x1f6>
  } else if(f->type == FD_INODE){
    80006efa:	fc843783          	ld	a5,-56(s0)
    80006efe:	439c                	lw	a5,0(a5)
    80006f00:	873e                	mv	a4,a5
    80006f02:	4789                	li	a5,2
    80006f04:	10f71563          	bne	a4,a5,8000700e <filewrite+0x1e6>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    80006f08:	6785                	lui	a5,0x1
    80006f0a:	c0078793          	addi	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    80006f0e:	fef42023          	sw	a5,-32(s0)
    int i = 0;
    80006f12:	fe042423          	sw	zero,-24(s0)
    while(i < n){
    80006f16:	a0d9                	j	80006fdc <filewrite+0x1b4>
      int n1 = n - i;
    80006f18:	fbc42703          	lw	a4,-68(s0)
    80006f1c:	fe842783          	lw	a5,-24(s0)
    80006f20:	40f707bb          	subw	a5,a4,a5
    80006f24:	fef42223          	sw	a5,-28(s0)
      if(n1 > max)
    80006f28:	fe442703          	lw	a4,-28(s0)
    80006f2c:	fe042783          	lw	a5,-32(s0)
    80006f30:	2701                	sext.w	a4,a4
    80006f32:	2781                	sext.w	a5,a5
    80006f34:	00e7d663          	bge	a5,a4,80006f40 <filewrite+0x118>
        n1 = max;
    80006f38:	fe042783          	lw	a5,-32(s0)
    80006f3c:	fef42223          	sw	a5,-28(s0)

      begin_op();
    80006f40:	fffff097          	auipc	ra,0xfffff
    80006f44:	53c080e7          	jalr	1340(ra) # 8000647c <begin_op>
      ilock(f->ip);
    80006f48:	fc843783          	ld	a5,-56(s0)
    80006f4c:	6f9c                	ld	a5,24(a5)
    80006f4e:	853e                	mv	a0,a5
    80006f50:	ffffe097          	auipc	ra,0xffffe
    80006f54:	4d2080e7          	jalr	1234(ra) # 80005422 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80006f58:	fc843783          	ld	a5,-56(s0)
    80006f5c:	6f88                	ld	a0,24(a5)
    80006f5e:	fe842703          	lw	a4,-24(s0)
    80006f62:	fc043783          	ld	a5,-64(s0)
    80006f66:	00f70633          	add	a2,a4,a5
    80006f6a:	fc843783          	ld	a5,-56(s0)
    80006f6e:	539c                	lw	a5,32(a5)
    80006f70:	fe442703          	lw	a4,-28(s0)
    80006f74:	86be                	mv	a3,a5
    80006f76:	4585                	li	a1,1
    80006f78:	fffff097          	auipc	ra,0xfffff
    80006f7c:	bca080e7          	jalr	-1078(ra) # 80005b42 <writei>
    80006f80:	87aa                	mv	a5,a0
    80006f82:	fcf42e23          	sw	a5,-36(s0)
    80006f86:	fdc42783          	lw	a5,-36(s0)
    80006f8a:	2781                	sext.w	a5,a5
    80006f8c:	00f05d63          	blez	a5,80006fa6 <filewrite+0x17e>
        f->off += r;
    80006f90:	fc843783          	ld	a5,-56(s0)
    80006f94:	5398                	lw	a4,32(a5)
    80006f96:	fdc42783          	lw	a5,-36(s0)
    80006f9a:	9fb9                	addw	a5,a5,a4
    80006f9c:	0007871b          	sext.w	a4,a5
    80006fa0:	fc843783          	ld	a5,-56(s0)
    80006fa4:	d398                	sw	a4,32(a5)
      iunlock(f->ip);
    80006fa6:	fc843783          	ld	a5,-56(s0)
    80006faa:	6f9c                	ld	a5,24(a5)
    80006fac:	853e                	mv	a0,a5
    80006fae:	ffffe097          	auipc	ra,0xffffe
    80006fb2:	5a8080e7          	jalr	1448(ra) # 80005556 <iunlock>
      end_op();
    80006fb6:	fffff097          	auipc	ra,0xfffff
    80006fba:	588080e7          	jalr	1416(ra) # 8000653e <end_op>

      if(r != n1){
    80006fbe:	fdc42703          	lw	a4,-36(s0)
    80006fc2:	fe442783          	lw	a5,-28(s0)
    80006fc6:	2701                	sext.w	a4,a4
    80006fc8:	2781                	sext.w	a5,a5
    80006fca:	02f71263          	bne	a4,a5,80006fee <filewrite+0x1c6>
        // error from writei
        break;
      }
      i += r;
    80006fce:	fe842703          	lw	a4,-24(s0)
    80006fd2:	fdc42783          	lw	a5,-36(s0)
    80006fd6:	9fb9                	addw	a5,a5,a4
    80006fd8:	fef42423          	sw	a5,-24(s0)
    while(i < n){
    80006fdc:	fe842703          	lw	a4,-24(s0)
    80006fe0:	fbc42783          	lw	a5,-68(s0)
    80006fe4:	2701                	sext.w	a4,a4
    80006fe6:	2781                	sext.w	a5,a5
    80006fe8:	f2f748e3          	blt	a4,a5,80006f18 <filewrite+0xf0>
    80006fec:	a011                	j	80006ff0 <filewrite+0x1c8>
        break;
    80006fee:	0001                	nop
    }
    ret = (i == n ? n : -1);
    80006ff0:	fe842703          	lw	a4,-24(s0)
    80006ff4:	fbc42783          	lw	a5,-68(s0)
    80006ff8:	2701                	sext.w	a4,a4
    80006ffa:	2781                	sext.w	a5,a5
    80006ffc:	00f71563          	bne	a4,a5,80007006 <filewrite+0x1de>
    80007000:	fbc42783          	lw	a5,-68(s0)
    80007004:	a011                	j	80007008 <filewrite+0x1e0>
    80007006:	57fd                	li	a5,-1
    80007008:	fef42623          	sw	a5,-20(s0)
    8000700c:	a809                	j	8000701e <filewrite+0x1f6>
  } else {
    panic("filewrite");
    8000700e:	00004517          	auipc	a0,0x4
    80007012:	5c250513          	addi	a0,a0,1474 # 8000b5d0 <etext+0x5d0>
    80007016:	ffffa097          	auipc	ra,0xffffa
    8000701a:	c68080e7          	jalr	-920(ra) # 80000c7e <panic>
  }

  return ret;
    8000701e:	fec42783          	lw	a5,-20(s0)
}
    80007022:	853e                	mv	a0,a5
    80007024:	60a6                	ld	ra,72(sp)
    80007026:	6406                	ld	s0,64(sp)
    80007028:	6161                	addi	sp,sp,80
    8000702a:	8082                	ret

000000008000702c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000702c:	7179                	addi	sp,sp,-48
    8000702e:	f406                	sd	ra,40(sp)
    80007030:	f022                	sd	s0,32(sp)
    80007032:	1800                	addi	s0,sp,48
    80007034:	fca43c23          	sd	a0,-40(s0)
    80007038:	fcb43823          	sd	a1,-48(s0)
  struct pipe *pi;

  pi = 0;
    8000703c:	fe043423          	sd	zero,-24(s0)
  *f0 = *f1 = 0;
    80007040:	fd043783          	ld	a5,-48(s0)
    80007044:	0007b023          	sd	zero,0(a5)
    80007048:	fd043783          	ld	a5,-48(s0)
    8000704c:	6398                	ld	a4,0(a5)
    8000704e:	fd843783          	ld	a5,-40(s0)
    80007052:	e398                	sd	a4,0(a5)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80007054:	00000097          	auipc	ra,0x0
    80007058:	9d8080e7          	jalr	-1576(ra) # 80006a2c <filealloc>
    8000705c:	872a                	mv	a4,a0
    8000705e:	fd843783          	ld	a5,-40(s0)
    80007062:	e398                	sd	a4,0(a5)
    80007064:	fd843783          	ld	a5,-40(s0)
    80007068:	639c                	ld	a5,0(a5)
    8000706a:	c3e9                	beqz	a5,8000712c <pipealloc+0x100>
    8000706c:	00000097          	auipc	ra,0x0
    80007070:	9c0080e7          	jalr	-1600(ra) # 80006a2c <filealloc>
    80007074:	872a                	mv	a4,a0
    80007076:	fd043783          	ld	a5,-48(s0)
    8000707a:	e398                	sd	a4,0(a5)
    8000707c:	fd043783          	ld	a5,-48(s0)
    80007080:	639c                	ld	a5,0(a5)
    80007082:	c7cd                	beqz	a5,8000712c <pipealloc+0x100>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80007084:	ffffa097          	auipc	ra,0xffffa
    80007088:	096080e7          	jalr	150(ra) # 8000111a <kalloc>
    8000708c:	fea43423          	sd	a0,-24(s0)
    80007090:	fe843783          	ld	a5,-24(s0)
    80007094:	cfd1                	beqz	a5,80007130 <pipealloc+0x104>
    goto bad;
  pi->readopen = 1;
    80007096:	fe843783          	ld	a5,-24(s0)
    8000709a:	4705                	li	a4,1
    8000709c:	22e7a023          	sw	a4,544(a5)
  pi->writeopen = 1;
    800070a0:	fe843783          	ld	a5,-24(s0)
    800070a4:	4705                	li	a4,1
    800070a6:	22e7a223          	sw	a4,548(a5)
  pi->nwrite = 0;
    800070aa:	fe843783          	ld	a5,-24(s0)
    800070ae:	2007ae23          	sw	zero,540(a5)
  pi->nread = 0;
    800070b2:	fe843783          	ld	a5,-24(s0)
    800070b6:	2007ac23          	sw	zero,536(a5)
  initlock(&pi->lock, "pipe");
    800070ba:	fe843783          	ld	a5,-24(s0)
    800070be:	00004597          	auipc	a1,0x4
    800070c2:	52258593          	addi	a1,a1,1314 # 8000b5e0 <etext+0x5e0>
    800070c6:	853e                	mv	a0,a5
    800070c8:	ffffa097          	auipc	ra,0xffffa
    800070cc:	176080e7          	jalr	374(ra) # 8000123e <initlock>
  (*f0)->type = FD_PIPE;
    800070d0:	fd843783          	ld	a5,-40(s0)
    800070d4:	639c                	ld	a5,0(a5)
    800070d6:	4705                	li	a4,1
    800070d8:	c398                	sw	a4,0(a5)
  (*f0)->readable = 1;
    800070da:	fd843783          	ld	a5,-40(s0)
    800070de:	639c                	ld	a5,0(a5)
    800070e0:	4705                	li	a4,1
    800070e2:	00e78423          	sb	a4,8(a5)
  (*f0)->writable = 0;
    800070e6:	fd843783          	ld	a5,-40(s0)
    800070ea:	639c                	ld	a5,0(a5)
    800070ec:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800070f0:	fd843783          	ld	a5,-40(s0)
    800070f4:	639c                	ld	a5,0(a5)
    800070f6:	fe843703          	ld	a4,-24(s0)
    800070fa:	eb98                	sd	a4,16(a5)
  (*f1)->type = FD_PIPE;
    800070fc:	fd043783          	ld	a5,-48(s0)
    80007100:	639c                	ld	a5,0(a5)
    80007102:	4705                	li	a4,1
    80007104:	c398                	sw	a4,0(a5)
  (*f1)->readable = 0;
    80007106:	fd043783          	ld	a5,-48(s0)
    8000710a:	639c                	ld	a5,0(a5)
    8000710c:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80007110:	fd043783          	ld	a5,-48(s0)
    80007114:	639c                	ld	a5,0(a5)
    80007116:	4705                	li	a4,1
    80007118:	00e784a3          	sb	a4,9(a5)
  (*f1)->pipe = pi;
    8000711c:	fd043783          	ld	a5,-48(s0)
    80007120:	639c                	ld	a5,0(a5)
    80007122:	fe843703          	ld	a4,-24(s0)
    80007126:	eb98                	sd	a4,16(a5)
  return 0;
    80007128:	4781                	li	a5,0
    8000712a:	a0b1                	j	80007176 <pipealloc+0x14a>
    goto bad;
    8000712c:	0001                	nop
    8000712e:	a011                	j	80007132 <pipealloc+0x106>
    goto bad;
    80007130:	0001                	nop

 bad:
  if(pi)
    80007132:	fe843783          	ld	a5,-24(s0)
    80007136:	c799                	beqz	a5,80007144 <pipealloc+0x118>
    kfree((char*)pi);
    80007138:	fe843503          	ld	a0,-24(s0)
    8000713c:	ffffa097          	auipc	ra,0xffffa
    80007140:	f3a080e7          	jalr	-198(ra) # 80001076 <kfree>
  if(*f0)
    80007144:	fd843783          	ld	a5,-40(s0)
    80007148:	639c                	ld	a5,0(a5)
    8000714a:	cb89                	beqz	a5,8000715c <pipealloc+0x130>
    fileclose(*f0);
    8000714c:	fd843783          	ld	a5,-40(s0)
    80007150:	639c                	ld	a5,0(a5)
    80007152:	853e                	mv	a0,a5
    80007154:	00000097          	auipc	ra,0x0
    80007158:	9c2080e7          	jalr	-1598(ra) # 80006b16 <fileclose>
  if(*f1)
    8000715c:	fd043783          	ld	a5,-48(s0)
    80007160:	639c                	ld	a5,0(a5)
    80007162:	cb89                	beqz	a5,80007174 <pipealloc+0x148>
    fileclose(*f1);
    80007164:	fd043783          	ld	a5,-48(s0)
    80007168:	639c                	ld	a5,0(a5)
    8000716a:	853e                	mv	a0,a5
    8000716c:	00000097          	auipc	ra,0x0
    80007170:	9aa080e7          	jalr	-1622(ra) # 80006b16 <fileclose>
  return -1;
    80007174:	57fd                	li	a5,-1
}
    80007176:	853e                	mv	a0,a5
    80007178:	70a2                	ld	ra,40(sp)
    8000717a:	7402                	ld	s0,32(sp)
    8000717c:	6145                	addi	sp,sp,48
    8000717e:	8082                	ret

0000000080007180 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80007180:	1101                	addi	sp,sp,-32
    80007182:	ec06                	sd	ra,24(sp)
    80007184:	e822                	sd	s0,16(sp)
    80007186:	1000                	addi	s0,sp,32
    80007188:	fea43423          	sd	a0,-24(s0)
    8000718c:	87ae                	mv	a5,a1
    8000718e:	fef42223          	sw	a5,-28(s0)
  acquire(&pi->lock);
    80007192:	fe843783          	ld	a5,-24(s0)
    80007196:	853e                	mv	a0,a5
    80007198:	ffffa097          	auipc	ra,0xffffa
    8000719c:	0d6080e7          	jalr	214(ra) # 8000126e <acquire>
  if(writable){
    800071a0:	fe442783          	lw	a5,-28(s0)
    800071a4:	2781                	sext.w	a5,a5
    800071a6:	cf99                	beqz	a5,800071c4 <pipeclose+0x44>
    pi->writeopen = 0;
    800071a8:	fe843783          	ld	a5,-24(s0)
    800071ac:	2207a223          	sw	zero,548(a5)
    wakeup(&pi->nread);
    800071b0:	fe843783          	ld	a5,-24(s0)
    800071b4:	21878793          	addi	a5,a5,536
    800071b8:	853e                	mv	a0,a5
    800071ba:	ffffc097          	auipc	ra,0xffffc
    800071be:	3ea080e7          	jalr	1002(ra) # 800035a4 <wakeup>
    800071c2:	a831                	j	800071de <pipeclose+0x5e>
  } else {
    pi->readopen = 0;
    800071c4:	fe843783          	ld	a5,-24(s0)
    800071c8:	2207a023          	sw	zero,544(a5)
    wakeup(&pi->nwrite);
    800071cc:	fe843783          	ld	a5,-24(s0)
    800071d0:	21c78793          	addi	a5,a5,540
    800071d4:	853e                	mv	a0,a5
    800071d6:	ffffc097          	auipc	ra,0xffffc
    800071da:	3ce080e7          	jalr	974(ra) # 800035a4 <wakeup>
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    800071de:	fe843783          	ld	a5,-24(s0)
    800071e2:	2207a783          	lw	a5,544(a5)
    800071e6:	e785                	bnez	a5,8000720e <pipeclose+0x8e>
    800071e8:	fe843783          	ld	a5,-24(s0)
    800071ec:	2247a783          	lw	a5,548(a5)
    800071f0:	ef99                	bnez	a5,8000720e <pipeclose+0x8e>
    release(&pi->lock);
    800071f2:	fe843783          	ld	a5,-24(s0)
    800071f6:	853e                	mv	a0,a5
    800071f8:	ffffa097          	auipc	ra,0xffffa
    800071fc:	0da080e7          	jalr	218(ra) # 800012d2 <release>
    kfree((char*)pi);
    80007200:	fe843503          	ld	a0,-24(s0)
    80007204:	ffffa097          	auipc	ra,0xffffa
    80007208:	e72080e7          	jalr	-398(ra) # 80001076 <kfree>
    8000720c:	a809                	j	8000721e <pipeclose+0x9e>
  } else
    release(&pi->lock);
    8000720e:	fe843783          	ld	a5,-24(s0)
    80007212:	853e                	mv	a0,a5
    80007214:	ffffa097          	auipc	ra,0xffffa
    80007218:	0be080e7          	jalr	190(ra) # 800012d2 <release>
}
    8000721c:	0001                	nop
    8000721e:	0001                	nop
    80007220:	60e2                	ld	ra,24(sp)
    80007222:	6442                	ld	s0,16(sp)
    80007224:	6105                	addi	sp,sp,32
    80007226:	8082                	ret

0000000080007228 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80007228:	715d                	addi	sp,sp,-80
    8000722a:	e486                	sd	ra,72(sp)
    8000722c:	e0a2                	sd	s0,64(sp)
    8000722e:	0880                	addi	s0,sp,80
    80007230:	fca43423          	sd	a0,-56(s0)
    80007234:	fcb43023          	sd	a1,-64(s0)
    80007238:	87b2                	mv	a5,a2
    8000723a:	faf42e23          	sw	a5,-68(s0)
  int i = 0;
    8000723e:	fe042623          	sw	zero,-20(s0)
  struct proc *pr = myproc();
    80007242:	ffffb097          	auipc	ra,0xffffb
    80007246:	5d2080e7          	jalr	1490(ra) # 80002814 <myproc>
    8000724a:	fea43023          	sd	a0,-32(s0)

  acquire(&pi->lock);
    8000724e:	fc843783          	ld	a5,-56(s0)
    80007252:	853e                	mv	a0,a5
    80007254:	ffffa097          	auipc	ra,0xffffa
    80007258:	01a080e7          	jalr	26(ra) # 8000126e <acquire>
  while(i < n){
    8000725c:	a8d1                	j	80007330 <pipewrite+0x108>
    if(pi->readopen == 0 || pr->killed){
    8000725e:	fc843783          	ld	a5,-56(s0)
    80007262:	2207a783          	lw	a5,544(a5)
    80007266:	c789                	beqz	a5,80007270 <pipewrite+0x48>
    80007268:	fe043783          	ld	a5,-32(s0)
    8000726c:	579c                	lw	a5,40(a5)
    8000726e:	cb91                	beqz	a5,80007282 <pipewrite+0x5a>
      release(&pi->lock);
    80007270:	fc843783          	ld	a5,-56(s0)
    80007274:	853e                	mv	a0,a5
    80007276:	ffffa097          	auipc	ra,0xffffa
    8000727a:	05c080e7          	jalr	92(ra) # 800012d2 <release>
      return -1;
    8000727e:	57fd                	li	a5,-1
    80007280:	a0e5                	j	80007368 <pipewrite+0x140>
    }
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80007282:	fc843783          	ld	a5,-56(s0)
    80007286:	21c7a703          	lw	a4,540(a5)
    8000728a:	fc843783          	ld	a5,-56(s0)
    8000728e:	2187a783          	lw	a5,536(a5)
    80007292:	2007879b          	addiw	a5,a5,512
    80007296:	2781                	sext.w	a5,a5
    80007298:	02f71863          	bne	a4,a5,800072c8 <pipewrite+0xa0>
      wakeup(&pi->nread);
    8000729c:	fc843783          	ld	a5,-56(s0)
    800072a0:	21878793          	addi	a5,a5,536
    800072a4:	853e                	mv	a0,a5
    800072a6:	ffffc097          	auipc	ra,0xffffc
    800072aa:	2fe080e7          	jalr	766(ra) # 800035a4 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800072ae:	fc843783          	ld	a5,-56(s0)
    800072b2:	21c78793          	addi	a5,a5,540
    800072b6:	fc843703          	ld	a4,-56(s0)
    800072ba:	85ba                	mv	a1,a4
    800072bc:	853e                	mv	a0,a5
    800072be:	ffffc097          	auipc	ra,0xffffc
    800072c2:	222080e7          	jalr	546(ra) # 800034e0 <sleep>
    800072c6:	a0ad                	j	80007330 <pipewrite+0x108>
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800072c8:	fe043783          	ld	a5,-32(s0)
    800072cc:	6fa8                	ld	a0,88(a5)
    800072ce:	fec42703          	lw	a4,-20(s0)
    800072d2:	fc043783          	ld	a5,-64(s0)
    800072d6:	973e                	add	a4,a4,a5
    800072d8:	fdf40793          	addi	a5,s0,-33
    800072dc:	4685                	li	a3,1
    800072de:	863a                	mv	a2,a4
    800072e0:	85be                	mv	a1,a5
    800072e2:	ffffb097          	auipc	ra,0xffffb
    800072e6:	0d2080e7          	jalr	210(ra) # 800023b4 <copyin>
    800072ea:	87aa                	mv	a5,a0
    800072ec:	873e                	mv	a4,a5
    800072ee:	57fd                	li	a5,-1
    800072f0:	04f70963          	beq	a4,a5,80007342 <pipewrite+0x11a>
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800072f4:	fc843783          	ld	a5,-56(s0)
    800072f8:	21c7a783          	lw	a5,540(a5)
    800072fc:	2781                	sext.w	a5,a5
    800072fe:	0017871b          	addiw	a4,a5,1
    80007302:	0007069b          	sext.w	a3,a4
    80007306:	fc843703          	ld	a4,-56(s0)
    8000730a:	20d72e23          	sw	a3,540(a4)
    8000730e:	1ff7f793          	andi	a5,a5,511
    80007312:	2781                	sext.w	a5,a5
    80007314:	fdf44703          	lbu	a4,-33(s0)
    80007318:	fc843683          	ld	a3,-56(s0)
    8000731c:	1782                	slli	a5,a5,0x20
    8000731e:	9381                	srli	a5,a5,0x20
    80007320:	97b6                	add	a5,a5,a3
    80007322:	00e78c23          	sb	a4,24(a5)
      i++;
    80007326:	fec42783          	lw	a5,-20(s0)
    8000732a:	2785                	addiw	a5,a5,1
    8000732c:	fef42623          	sw	a5,-20(s0)
  while(i < n){
    80007330:	fec42703          	lw	a4,-20(s0)
    80007334:	fbc42783          	lw	a5,-68(s0)
    80007338:	2701                	sext.w	a4,a4
    8000733a:	2781                	sext.w	a5,a5
    8000733c:	f2f741e3          	blt	a4,a5,8000725e <pipewrite+0x36>
    80007340:	a011                	j	80007344 <pipewrite+0x11c>
        break;
    80007342:	0001                	nop
    }
  }
  wakeup(&pi->nread);
    80007344:	fc843783          	ld	a5,-56(s0)
    80007348:	21878793          	addi	a5,a5,536
    8000734c:	853e                	mv	a0,a5
    8000734e:	ffffc097          	auipc	ra,0xffffc
    80007352:	256080e7          	jalr	598(ra) # 800035a4 <wakeup>
  release(&pi->lock);
    80007356:	fc843783          	ld	a5,-56(s0)
    8000735a:	853e                	mv	a0,a5
    8000735c:	ffffa097          	auipc	ra,0xffffa
    80007360:	f76080e7          	jalr	-138(ra) # 800012d2 <release>

  return i;
    80007364:	fec42783          	lw	a5,-20(s0)
}
    80007368:	853e                	mv	a0,a5
    8000736a:	60a6                	ld	ra,72(sp)
    8000736c:	6406                	ld	s0,64(sp)
    8000736e:	6161                	addi	sp,sp,80
    80007370:	8082                	ret

0000000080007372 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80007372:	715d                	addi	sp,sp,-80
    80007374:	e486                	sd	ra,72(sp)
    80007376:	e0a2                	sd	s0,64(sp)
    80007378:	0880                	addi	s0,sp,80
    8000737a:	fca43423          	sd	a0,-56(s0)
    8000737e:	fcb43023          	sd	a1,-64(s0)
    80007382:	87b2                	mv	a5,a2
    80007384:	faf42e23          	sw	a5,-68(s0)
  int i;
  struct proc *pr = myproc();
    80007388:	ffffb097          	auipc	ra,0xffffb
    8000738c:	48c080e7          	jalr	1164(ra) # 80002814 <myproc>
    80007390:	fea43023          	sd	a0,-32(s0)
  char ch;

  acquire(&pi->lock);
    80007394:	fc843783          	ld	a5,-56(s0)
    80007398:	853e                	mv	a0,a5
    8000739a:	ffffa097          	auipc	ra,0xffffa
    8000739e:	ed4080e7          	jalr	-300(ra) # 8000126e <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800073a2:	a815                	j	800073d6 <piperead+0x64>
    if(pr->killed){
    800073a4:	fe043783          	ld	a5,-32(s0)
    800073a8:	579c                	lw	a5,40(a5)
    800073aa:	cb91                	beqz	a5,800073be <piperead+0x4c>
      release(&pi->lock);
    800073ac:	fc843783          	ld	a5,-56(s0)
    800073b0:	853e                	mv	a0,a5
    800073b2:	ffffa097          	auipc	ra,0xffffa
    800073b6:	f20080e7          	jalr	-224(ra) # 800012d2 <release>
      return -1;
    800073ba:	57fd                	li	a5,-1
    800073bc:	a8dd                	j	800074b2 <piperead+0x140>
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800073be:	fc843783          	ld	a5,-56(s0)
    800073c2:	21878793          	addi	a5,a5,536
    800073c6:	fc843703          	ld	a4,-56(s0)
    800073ca:	85ba                	mv	a1,a4
    800073cc:	853e                	mv	a0,a5
    800073ce:	ffffc097          	auipc	ra,0xffffc
    800073d2:	112080e7          	jalr	274(ra) # 800034e0 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800073d6:	fc843783          	ld	a5,-56(s0)
    800073da:	2187a703          	lw	a4,536(a5)
    800073de:	fc843783          	ld	a5,-56(s0)
    800073e2:	21c7a783          	lw	a5,540(a5)
    800073e6:	00f71763          	bne	a4,a5,800073f4 <piperead+0x82>
    800073ea:	fc843783          	ld	a5,-56(s0)
    800073ee:	2247a783          	lw	a5,548(a5)
    800073f2:	fbcd                	bnez	a5,800073a4 <piperead+0x32>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800073f4:	fe042623          	sw	zero,-20(s0)
    800073f8:	a8bd                	j	80007476 <piperead+0x104>
    if(pi->nread == pi->nwrite)
    800073fa:	fc843783          	ld	a5,-56(s0)
    800073fe:	2187a703          	lw	a4,536(a5)
    80007402:	fc843783          	ld	a5,-56(s0)
    80007406:	21c7a783          	lw	a5,540(a5)
    8000740a:	06f70f63          	beq	a4,a5,80007488 <piperead+0x116>
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000740e:	fc843783          	ld	a5,-56(s0)
    80007412:	2187a783          	lw	a5,536(a5)
    80007416:	2781                	sext.w	a5,a5
    80007418:	0017871b          	addiw	a4,a5,1
    8000741c:	0007069b          	sext.w	a3,a4
    80007420:	fc843703          	ld	a4,-56(s0)
    80007424:	20d72c23          	sw	a3,536(a4)
    80007428:	1ff7f793          	andi	a5,a5,511
    8000742c:	2781                	sext.w	a5,a5
    8000742e:	fc843703          	ld	a4,-56(s0)
    80007432:	1782                	slli	a5,a5,0x20
    80007434:	9381                	srli	a5,a5,0x20
    80007436:	97ba                	add	a5,a5,a4
    80007438:	0187c783          	lbu	a5,24(a5)
    8000743c:	fcf40fa3          	sb	a5,-33(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80007440:	fe043783          	ld	a5,-32(s0)
    80007444:	6fa8                	ld	a0,88(a5)
    80007446:	fec42703          	lw	a4,-20(s0)
    8000744a:	fc043783          	ld	a5,-64(s0)
    8000744e:	97ba                	add	a5,a5,a4
    80007450:	fdf40713          	addi	a4,s0,-33
    80007454:	4685                	li	a3,1
    80007456:	863a                	mv	a2,a4
    80007458:	85be                	mv	a1,a5
    8000745a:	ffffb097          	auipc	ra,0xffffb
    8000745e:	e8c080e7          	jalr	-372(ra) # 800022e6 <copyout>
    80007462:	87aa                	mv	a5,a0
    80007464:	873e                	mv	a4,a5
    80007466:	57fd                	li	a5,-1
    80007468:	02f70263          	beq	a4,a5,8000748c <piperead+0x11a>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000746c:	fec42783          	lw	a5,-20(s0)
    80007470:	2785                	addiw	a5,a5,1
    80007472:	fef42623          	sw	a5,-20(s0)
    80007476:	fec42703          	lw	a4,-20(s0)
    8000747a:	fbc42783          	lw	a5,-68(s0)
    8000747e:	2701                	sext.w	a4,a4
    80007480:	2781                	sext.w	a5,a5
    80007482:	f6f74ce3          	blt	a4,a5,800073fa <piperead+0x88>
    80007486:	a021                	j	8000748e <piperead+0x11c>
      break;
    80007488:	0001                	nop
    8000748a:	a011                	j	8000748e <piperead+0x11c>
      break;
    8000748c:	0001                	nop
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000748e:	fc843783          	ld	a5,-56(s0)
    80007492:	21c78793          	addi	a5,a5,540
    80007496:	853e                	mv	a0,a5
    80007498:	ffffc097          	auipc	ra,0xffffc
    8000749c:	10c080e7          	jalr	268(ra) # 800035a4 <wakeup>
  release(&pi->lock);
    800074a0:	fc843783          	ld	a5,-56(s0)
    800074a4:	853e                	mv	a0,a5
    800074a6:	ffffa097          	auipc	ra,0xffffa
    800074aa:	e2c080e7          	jalr	-468(ra) # 800012d2 <release>
  return i;
    800074ae:	fec42783          	lw	a5,-20(s0)
}
    800074b2:	853e                	mv	a0,a5
    800074b4:	60a6                	ld	ra,72(sp)
    800074b6:	6406                	ld	s0,64(sp)
    800074b8:	6161                	addi	sp,sp,80
    800074ba:	8082                	ret

00000000800074bc <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800074bc:	de010113          	addi	sp,sp,-544
    800074c0:	20113c23          	sd	ra,536(sp)
    800074c4:	20813823          	sd	s0,528(sp)
    800074c8:	20913423          	sd	s1,520(sp)
    800074cc:	1400                	addi	s0,sp,544
    800074ce:	dea43423          	sd	a0,-536(s0)
    800074d2:	deb43023          	sd	a1,-544(s0)
  char *s, *last;
  int i, off;
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800074d6:	fa043c23          	sd	zero,-72(s0)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
    800074da:	fa043023          	sd	zero,-96(s0)
  struct proc *p = myproc();
    800074de:	ffffb097          	auipc	ra,0xffffb
    800074e2:	336080e7          	jalr	822(ra) # 80002814 <myproc>
    800074e6:	f8a43c23          	sd	a0,-104(s0)

  begin_op();
    800074ea:	fffff097          	auipc	ra,0xfffff
    800074ee:	f92080e7          	jalr	-110(ra) # 8000647c <begin_op>

  if((ip = namei(path)) == 0){
    800074f2:	de843503          	ld	a0,-536(s0)
    800074f6:	fffff097          	auipc	ra,0xfffff
    800074fa:	c22080e7          	jalr	-990(ra) # 80006118 <namei>
    800074fe:	faa43423          	sd	a0,-88(s0)
    80007502:	fa843783          	ld	a5,-88(s0)
    80007506:	e799                	bnez	a5,80007514 <exec+0x58>
    end_op();
    80007508:	fffff097          	auipc	ra,0xfffff
    8000750c:	036080e7          	jalr	54(ra) # 8000653e <end_op>
    return -1;
    80007510:	57fd                	li	a5,-1
    80007512:	a90d                	j	80007944 <exec+0x488>
  }
  ilock(ip);
    80007514:	fa843503          	ld	a0,-88(s0)
    80007518:	ffffe097          	auipc	ra,0xffffe
    8000751c:	f0a080e7          	jalr	-246(ra) # 80005422 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80007520:	e3040793          	addi	a5,s0,-464
    80007524:	04000713          	li	a4,64
    80007528:	4681                	li	a3,0
    8000752a:	863e                	mv	a2,a5
    8000752c:	4581                	li	a1,0
    8000752e:	fa843503          	ld	a0,-88(s0)
    80007532:	ffffe097          	auipc	ra,0xffffe
    80007536:	486080e7          	jalr	1158(ra) # 800059b8 <readi>
    8000753a:	87aa                	mv	a5,a0
    8000753c:	873e                	mv	a4,a5
    8000753e:	04000793          	li	a5,64
    80007542:	38f71b63          	bne	a4,a5,800078d8 <exec+0x41c>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80007546:	e3042783          	lw	a5,-464(s0)
    8000754a:	873e                	mv	a4,a5
    8000754c:	464c47b7          	lui	a5,0x464c4
    80007550:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80007554:	38f71463          	bne	a4,a5,800078dc <exec+0x420>
    goto bad;

  if((pagetable = proc_pagetable(p)) == 0)
    80007558:	f9843503          	ld	a0,-104(s0)
    8000755c:	ffffb097          	auipc	ra,0xffffb
    80007560:	532080e7          	jalr	1330(ra) # 80002a8e <proc_pagetable>
    80007564:	faa43023          	sd	a0,-96(s0)
    80007568:	fa043783          	ld	a5,-96(s0)
    8000756c:	36078a63          	beqz	a5,800078e0 <exec+0x424>
    goto bad;

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80007570:	fc042623          	sw	zero,-52(s0)
    80007574:	e5043783          	ld	a5,-432(s0)
    80007578:	fcf42423          	sw	a5,-56(s0)
    8000757c:	a8e1                	j	80007654 <exec+0x198>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000757e:	df840793          	addi	a5,s0,-520
    80007582:	fc842683          	lw	a3,-56(s0)
    80007586:	03800713          	li	a4,56
    8000758a:	863e                	mv	a2,a5
    8000758c:	4581                	li	a1,0
    8000758e:	fa843503          	ld	a0,-88(s0)
    80007592:	ffffe097          	auipc	ra,0xffffe
    80007596:	426080e7          	jalr	1062(ra) # 800059b8 <readi>
    8000759a:	87aa                	mv	a5,a0
    8000759c:	873e                	mv	a4,a5
    8000759e:	03800793          	li	a5,56
    800075a2:	34f71163          	bne	a4,a5,800078e4 <exec+0x428>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
    800075a6:	df842783          	lw	a5,-520(s0)
    800075aa:	873e                	mv	a4,a5
    800075ac:	4785                	li	a5,1
    800075ae:	08f71663          	bne	a4,a5,8000763a <exec+0x17e>
      continue;
    if(ph.memsz < ph.filesz)
    800075b2:	e2043703          	ld	a4,-480(s0)
    800075b6:	e1843783          	ld	a5,-488(s0)
    800075ba:	32f76763          	bltu	a4,a5,800078e8 <exec+0x42c>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800075be:	e0843703          	ld	a4,-504(s0)
    800075c2:	e2043783          	ld	a5,-480(s0)
    800075c6:	973e                	add	a4,a4,a5
    800075c8:	e0843783          	ld	a5,-504(s0)
    800075cc:	32f76063          	bltu	a4,a5,800078ec <exec+0x430>
      goto bad;
    uint64 sz1;
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800075d0:	e0843703          	ld	a4,-504(s0)
    800075d4:	e2043783          	ld	a5,-480(s0)
    800075d8:	97ba                	add	a5,a5,a4
    800075da:	863e                	mv	a2,a5
    800075dc:	fb843583          	ld	a1,-72(s0)
    800075e0:	fa043503          	ld	a0,-96(s0)
    800075e4:	ffffb097          	auipc	ra,0xffffb
    800075e8:	924080e7          	jalr	-1756(ra) # 80001f08 <uvmalloc>
    800075ec:	f6a43823          	sd	a0,-144(s0)
    800075f0:	f7043783          	ld	a5,-144(s0)
    800075f4:	2e078e63          	beqz	a5,800078f0 <exec+0x434>
      goto bad;
    sz = sz1;
    800075f8:	f7043783          	ld	a5,-144(s0)
    800075fc:	faf43c23          	sd	a5,-72(s0)
    if((ph.vaddr % PGSIZE) != 0)
    80007600:	e0843703          	ld	a4,-504(s0)
    80007604:	6785                	lui	a5,0x1
    80007606:	17fd                	addi	a5,a5,-1
    80007608:	8ff9                	and	a5,a5,a4
    8000760a:	2e079563          	bnez	a5,800078f4 <exec+0x438>
      goto bad;
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000760e:	e0843783          	ld	a5,-504(s0)
    80007612:	e0043703          	ld	a4,-512(s0)
    80007616:	0007069b          	sext.w	a3,a4
    8000761a:	e1843703          	ld	a4,-488(s0)
    8000761e:	2701                	sext.w	a4,a4
    80007620:	fa843603          	ld	a2,-88(s0)
    80007624:	85be                	mv	a1,a5
    80007626:	fa043503          	ld	a0,-96(s0)
    8000762a:	00000097          	auipc	ra,0x0
    8000762e:	32e080e7          	jalr	814(ra) # 80007958 <loadseg>
    80007632:	87aa                	mv	a5,a0
    80007634:	2c07c263          	bltz	a5,800078f8 <exec+0x43c>
    80007638:	a011                	j	8000763c <exec+0x180>
      continue;
    8000763a:	0001                	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000763c:	fcc42783          	lw	a5,-52(s0)
    80007640:	2785                	addiw	a5,a5,1
    80007642:	fcf42623          	sw	a5,-52(s0)
    80007646:	fc842783          	lw	a5,-56(s0)
    8000764a:	0387879b          	addiw	a5,a5,56
    8000764e:	2781                	sext.w	a5,a5
    80007650:	fcf42423          	sw	a5,-56(s0)
    80007654:	e6845783          	lhu	a5,-408(s0)
    80007658:	0007871b          	sext.w	a4,a5
    8000765c:	fcc42783          	lw	a5,-52(s0)
    80007660:	2781                	sext.w	a5,a5
    80007662:	f0e7cee3          	blt	a5,a4,8000757e <exec+0xc2>
      goto bad;
  }
  iunlockput(ip);
    80007666:	fa843503          	ld	a0,-88(s0)
    8000766a:	ffffe097          	auipc	ra,0xffffe
    8000766e:	016080e7          	jalr	22(ra) # 80005680 <iunlockput>
  end_op();
    80007672:	fffff097          	auipc	ra,0xfffff
    80007676:	ecc080e7          	jalr	-308(ra) # 8000653e <end_op>
  ip = 0;
    8000767a:	fa043423          	sd	zero,-88(s0)

  p = myproc();
    8000767e:	ffffb097          	auipc	ra,0xffffb
    80007682:	196080e7          	jalr	406(ra) # 80002814 <myproc>
    80007686:	f8a43c23          	sd	a0,-104(s0)
  uint64 oldsz = p->sz;
    8000768a:	f9843783          	ld	a5,-104(s0)
    8000768e:	6bbc                	ld	a5,80(a5)
    80007690:	f8f43823          	sd	a5,-112(s0)

  // Allocate two pages at the next page boundary.
  // Use the second as the user stack.
  sz = PGROUNDUP(sz);
    80007694:	fb843703          	ld	a4,-72(s0)
    80007698:	6785                	lui	a5,0x1
    8000769a:	17fd                	addi	a5,a5,-1
    8000769c:	973e                	add	a4,a4,a5
    8000769e:	77fd                	lui	a5,0xfffff
    800076a0:	8ff9                	and	a5,a5,a4
    800076a2:	faf43c23          	sd	a5,-72(s0)
  uint64 sz1;
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800076a6:	fb843703          	ld	a4,-72(s0)
    800076aa:	6789                	lui	a5,0x2
    800076ac:	97ba                	add	a5,a5,a4
    800076ae:	863e                	mv	a2,a5
    800076b0:	fb843583          	ld	a1,-72(s0)
    800076b4:	fa043503          	ld	a0,-96(s0)
    800076b8:	ffffb097          	auipc	ra,0xffffb
    800076bc:	850080e7          	jalr	-1968(ra) # 80001f08 <uvmalloc>
    800076c0:	f8a43423          	sd	a0,-120(s0)
    800076c4:	f8843783          	ld	a5,-120(s0)
    800076c8:	22078a63          	beqz	a5,800078fc <exec+0x440>
    goto bad;
  sz = sz1;
    800076cc:	f8843783          	ld	a5,-120(s0)
    800076d0:	faf43c23          	sd	a5,-72(s0)
  uvmclear(pagetable, sz-2*PGSIZE);
    800076d4:	fb843703          	ld	a4,-72(s0)
    800076d8:	77f9                	lui	a5,0xffffe
    800076da:	97ba                	add	a5,a5,a4
    800076dc:	85be                	mv	a1,a5
    800076de:	fa043503          	ld	a0,-96(s0)
    800076e2:	ffffb097          	auipc	ra,0xffffb
    800076e6:	bae080e7          	jalr	-1106(ra) # 80002290 <uvmclear>
  sp = sz;
    800076ea:	fb843783          	ld	a5,-72(s0)
    800076ee:	faf43823          	sd	a5,-80(s0)
  stackbase = sp - PGSIZE;
    800076f2:	fb043703          	ld	a4,-80(s0)
    800076f6:	77fd                	lui	a5,0xfffff
    800076f8:	97ba                	add	a5,a5,a4
    800076fa:	f8f43023          	sd	a5,-128(s0)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    800076fe:	fc043023          	sd	zero,-64(s0)
    80007702:	a845                	j	800077b2 <exec+0x2f6>
    if(argc >= MAXARG)
    80007704:	fc043703          	ld	a4,-64(s0)
    80007708:	47fd                	li	a5,31
    8000770a:	1ee7eb63          	bltu	a5,a4,80007900 <exec+0x444>
      goto bad;
    sp -= strlen(argv[argc]) + 1;
    8000770e:	fc043783          	ld	a5,-64(s0)
    80007712:	078e                	slli	a5,a5,0x3
    80007714:	de043703          	ld	a4,-544(s0)
    80007718:	97ba                	add	a5,a5,a4
    8000771a:	639c                	ld	a5,0(a5)
    8000771c:	853e                	mv	a0,a5
    8000771e:	ffffa097          	auipc	ra,0xffffa
    80007722:	0a2080e7          	jalr	162(ra) # 800017c0 <strlen>
    80007726:	87aa                	mv	a5,a0
    80007728:	2785                	addiw	a5,a5,1
    8000772a:	2781                	sext.w	a5,a5
    8000772c:	873e                	mv	a4,a5
    8000772e:	fb043783          	ld	a5,-80(s0)
    80007732:	8f99                	sub	a5,a5,a4
    80007734:	faf43823          	sd	a5,-80(s0)
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80007738:	fb043783          	ld	a5,-80(s0)
    8000773c:	9bc1                	andi	a5,a5,-16
    8000773e:	faf43823          	sd	a5,-80(s0)
    if(sp < stackbase)
    80007742:	fb043703          	ld	a4,-80(s0)
    80007746:	f8043783          	ld	a5,-128(s0)
    8000774a:	1af76d63          	bltu	a4,a5,80007904 <exec+0x448>
      goto bad;
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000774e:	fc043783          	ld	a5,-64(s0)
    80007752:	078e                	slli	a5,a5,0x3
    80007754:	de043703          	ld	a4,-544(s0)
    80007758:	97ba                	add	a5,a5,a4
    8000775a:	6384                	ld	s1,0(a5)
    8000775c:	fc043783          	ld	a5,-64(s0)
    80007760:	078e                	slli	a5,a5,0x3
    80007762:	de043703          	ld	a4,-544(s0)
    80007766:	97ba                	add	a5,a5,a4
    80007768:	639c                	ld	a5,0(a5)
    8000776a:	853e                	mv	a0,a5
    8000776c:	ffffa097          	auipc	ra,0xffffa
    80007770:	054080e7          	jalr	84(ra) # 800017c0 <strlen>
    80007774:	87aa                	mv	a5,a0
    80007776:	2785                	addiw	a5,a5,1
    80007778:	2781                	sext.w	a5,a5
    8000777a:	86be                	mv	a3,a5
    8000777c:	8626                	mv	a2,s1
    8000777e:	fb043583          	ld	a1,-80(s0)
    80007782:	fa043503          	ld	a0,-96(s0)
    80007786:	ffffb097          	auipc	ra,0xffffb
    8000778a:	b60080e7          	jalr	-1184(ra) # 800022e6 <copyout>
    8000778e:	87aa                	mv	a5,a0
    80007790:	1607cc63          	bltz	a5,80007908 <exec+0x44c>
      goto bad;
    ustack[argc] = sp;
    80007794:	fc043783          	ld	a5,-64(s0)
    80007798:	078e                	slli	a5,a5,0x3
    8000779a:	fe040713          	addi	a4,s0,-32
    8000779e:	97ba                	add	a5,a5,a4
    800077a0:	fb043703          	ld	a4,-80(s0)
    800077a4:	e8e7b823          	sd	a4,-368(a5) # ffffffffffffee90 <end+0xffffffff7ffd5e90>
  for(argc = 0; argv[argc]; argc++) {
    800077a8:	fc043783          	ld	a5,-64(s0)
    800077ac:	0785                	addi	a5,a5,1
    800077ae:	fcf43023          	sd	a5,-64(s0)
    800077b2:	fc043783          	ld	a5,-64(s0)
    800077b6:	078e                	slli	a5,a5,0x3
    800077b8:	de043703          	ld	a4,-544(s0)
    800077bc:	97ba                	add	a5,a5,a4
    800077be:	639c                	ld	a5,0(a5)
    800077c0:	f3b1                	bnez	a5,80007704 <exec+0x248>
  }
  ustack[argc] = 0;
    800077c2:	fc043783          	ld	a5,-64(s0)
    800077c6:	078e                	slli	a5,a5,0x3
    800077c8:	fe040713          	addi	a4,s0,-32
    800077cc:	97ba                	add	a5,a5,a4
    800077ce:	e807b823          	sd	zero,-368(a5)

  // push the array of argv[] pointers.
  sp -= (argc+1) * sizeof(uint64);
    800077d2:	fc043783          	ld	a5,-64(s0)
    800077d6:	0785                	addi	a5,a5,1
    800077d8:	078e                	slli	a5,a5,0x3
    800077da:	fb043703          	ld	a4,-80(s0)
    800077de:	40f707b3          	sub	a5,a4,a5
    800077e2:	faf43823          	sd	a5,-80(s0)
  sp -= sp % 16;
    800077e6:	fb043783          	ld	a5,-80(s0)
    800077ea:	9bc1                	andi	a5,a5,-16
    800077ec:	faf43823          	sd	a5,-80(s0)
  if(sp < stackbase)
    800077f0:	fb043703          	ld	a4,-80(s0)
    800077f4:	f8043783          	ld	a5,-128(s0)
    800077f8:	10f76a63          	bltu	a4,a5,8000790c <exec+0x450>
    goto bad;
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800077fc:	fc043783          	ld	a5,-64(s0)
    80007800:	0785                	addi	a5,a5,1
    80007802:	00379713          	slli	a4,a5,0x3
    80007806:	e7040793          	addi	a5,s0,-400
    8000780a:	86ba                	mv	a3,a4
    8000780c:	863e                	mv	a2,a5
    8000780e:	fb043583          	ld	a1,-80(s0)
    80007812:	fa043503          	ld	a0,-96(s0)
    80007816:	ffffb097          	auipc	ra,0xffffb
    8000781a:	ad0080e7          	jalr	-1328(ra) # 800022e6 <copyout>
    8000781e:	87aa                	mv	a5,a0
    80007820:	0e07c863          	bltz	a5,80007910 <exec+0x454>
    goto bad;

  // arguments to user main(argc, argv)
  // argc is returned via the system call return
  // value, which goes in a0.
  p->trapframe->a1 = sp;
    80007824:	f9843783          	ld	a5,-104(s0)
    80007828:	73bc                	ld	a5,96(a5)
    8000782a:	fb043703          	ld	a4,-80(s0)
    8000782e:	ffb8                	sd	a4,120(a5)

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    80007830:	de843783          	ld	a5,-536(s0)
    80007834:	fcf43c23          	sd	a5,-40(s0)
    80007838:	fd843783          	ld	a5,-40(s0)
    8000783c:	fcf43823          	sd	a5,-48(s0)
    80007840:	a025                	j	80007868 <exec+0x3ac>
    if(*s == '/')
    80007842:	fd843783          	ld	a5,-40(s0)
    80007846:	0007c783          	lbu	a5,0(a5)
    8000784a:	873e                	mv	a4,a5
    8000784c:	02f00793          	li	a5,47
    80007850:	00f71763          	bne	a4,a5,8000785e <exec+0x3a2>
      last = s+1;
    80007854:	fd843783          	ld	a5,-40(s0)
    80007858:	0785                	addi	a5,a5,1
    8000785a:	fcf43823          	sd	a5,-48(s0)
  for(last=s=path; *s; s++)
    8000785e:	fd843783          	ld	a5,-40(s0)
    80007862:	0785                	addi	a5,a5,1
    80007864:	fcf43c23          	sd	a5,-40(s0)
    80007868:	fd843783          	ld	a5,-40(s0)
    8000786c:	0007c783          	lbu	a5,0(a5)
    80007870:	fbe9                	bnez	a5,80007842 <exec+0x386>
  safestrcpy(p->name, last, sizeof(p->name));
    80007872:	f9843783          	ld	a5,-104(s0)
    80007876:	16078793          	addi	a5,a5,352
    8000787a:	4641                	li	a2,16
    8000787c:	fd043583          	ld	a1,-48(s0)
    80007880:	853e                	mv	a0,a5
    80007882:	ffffa097          	auipc	ra,0xffffa
    80007886:	ec4080e7          	jalr	-316(ra) # 80001746 <safestrcpy>
    
  // Commit to the user image.
  oldpagetable = p->pagetable;
    8000788a:	f9843783          	ld	a5,-104(s0)
    8000788e:	6fbc                	ld	a5,88(a5)
    80007890:	f6f43c23          	sd	a5,-136(s0)
  p->pagetable = pagetable;
    80007894:	f9843783          	ld	a5,-104(s0)
    80007898:	fa043703          	ld	a4,-96(s0)
    8000789c:	efb8                	sd	a4,88(a5)
  p->sz = sz;
    8000789e:	f9843783          	ld	a5,-104(s0)
    800078a2:	fb843703          	ld	a4,-72(s0)
    800078a6:	ebb8                	sd	a4,80(a5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800078a8:	f9843783          	ld	a5,-104(s0)
    800078ac:	73bc                	ld	a5,96(a5)
    800078ae:	e4843703          	ld	a4,-440(s0)
    800078b2:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800078b4:	f9843783          	ld	a5,-104(s0)
    800078b8:	73bc                	ld	a5,96(a5)
    800078ba:	fb043703          	ld	a4,-80(s0)
    800078be:	fb98                	sd	a4,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800078c0:	f9043583          	ld	a1,-112(s0)
    800078c4:	f7843503          	ld	a0,-136(s0)
    800078c8:	ffffb097          	auipc	ra,0xffffb
    800078cc:	286080e7          	jalr	646(ra) # 80002b4e <proc_freepagetable>

  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800078d0:	fc043783          	ld	a5,-64(s0)
    800078d4:	2781                	sext.w	a5,a5
    800078d6:	a0bd                	j	80007944 <exec+0x488>
    goto bad;
    800078d8:	0001                	nop
    800078da:	a825                	j	80007912 <exec+0x456>
    goto bad;
    800078dc:	0001                	nop
    800078de:	a815                	j	80007912 <exec+0x456>
    goto bad;
    800078e0:	0001                	nop
    800078e2:	a805                	j	80007912 <exec+0x456>
      goto bad;
    800078e4:	0001                	nop
    800078e6:	a035                	j	80007912 <exec+0x456>
      goto bad;
    800078e8:	0001                	nop
    800078ea:	a025                	j	80007912 <exec+0x456>
      goto bad;
    800078ec:	0001                	nop
    800078ee:	a015                	j	80007912 <exec+0x456>
      goto bad;
    800078f0:	0001                	nop
    800078f2:	a005                	j	80007912 <exec+0x456>
      goto bad;
    800078f4:	0001                	nop
    800078f6:	a831                	j	80007912 <exec+0x456>
      goto bad;
    800078f8:	0001                	nop
    800078fa:	a821                	j	80007912 <exec+0x456>
    goto bad;
    800078fc:	0001                	nop
    800078fe:	a811                	j	80007912 <exec+0x456>
      goto bad;
    80007900:	0001                	nop
    80007902:	a801                	j	80007912 <exec+0x456>
      goto bad;
    80007904:	0001                	nop
    80007906:	a031                	j	80007912 <exec+0x456>
      goto bad;
    80007908:	0001                	nop
    8000790a:	a021                	j	80007912 <exec+0x456>
    goto bad;
    8000790c:	0001                	nop
    8000790e:	a011                	j	80007912 <exec+0x456>
    goto bad;
    80007910:	0001                	nop

 bad:
  if(pagetable)
    80007912:	fa043783          	ld	a5,-96(s0)
    80007916:	cb89                	beqz	a5,80007928 <exec+0x46c>
    proc_freepagetable(pagetable, sz);
    80007918:	fb843583          	ld	a1,-72(s0)
    8000791c:	fa043503          	ld	a0,-96(s0)
    80007920:	ffffb097          	auipc	ra,0xffffb
    80007924:	22e080e7          	jalr	558(ra) # 80002b4e <proc_freepagetable>
  if(ip){
    80007928:	fa843783          	ld	a5,-88(s0)
    8000792c:	cb99                	beqz	a5,80007942 <exec+0x486>
    iunlockput(ip);
    8000792e:	fa843503          	ld	a0,-88(s0)
    80007932:	ffffe097          	auipc	ra,0xffffe
    80007936:	d4e080e7          	jalr	-690(ra) # 80005680 <iunlockput>
    end_op();
    8000793a:	fffff097          	auipc	ra,0xfffff
    8000793e:	c04080e7          	jalr	-1020(ra) # 8000653e <end_op>
  }
  return -1;
    80007942:	57fd                	li	a5,-1
}
    80007944:	853e                	mv	a0,a5
    80007946:	21813083          	ld	ra,536(sp)
    8000794a:	21013403          	ld	s0,528(sp)
    8000794e:	20813483          	ld	s1,520(sp)
    80007952:	22010113          	addi	sp,sp,544
    80007956:	8082                	ret

0000000080007958 <loadseg>:
// va must be page-aligned
// and the pages from va to va+sz must already be mapped.
// Returns 0 on success, -1 on failure.
static int
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
    80007958:	7139                	addi	sp,sp,-64
    8000795a:	fc06                	sd	ra,56(sp)
    8000795c:	f822                	sd	s0,48(sp)
    8000795e:	0080                	addi	s0,sp,64
    80007960:	fca43c23          	sd	a0,-40(s0)
    80007964:	fcb43823          	sd	a1,-48(s0)
    80007968:	fcc43423          	sd	a2,-56(s0)
    8000796c:	87b6                	mv	a5,a3
    8000796e:	fcf42223          	sw	a5,-60(s0)
    80007972:	87ba                	mv	a5,a4
    80007974:	fcf42023          	sw	a5,-64(s0)
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    80007978:	fe042623          	sw	zero,-20(s0)
    8000797c:	a05d                	j	80007a22 <loadseg+0xca>
    pa = walkaddr(pagetable, va + i);
    8000797e:	fec46703          	lwu	a4,-20(s0)
    80007982:	fd043783          	ld	a5,-48(s0)
    80007986:	97ba                	add	a5,a5,a4
    80007988:	85be                	mv	a1,a5
    8000798a:	fd843503          	ld	a0,-40(s0)
    8000798e:	ffffa097          	auipc	ra,0xffffa
    80007992:	206080e7          	jalr	518(ra) # 80001b94 <walkaddr>
    80007996:	fea43023          	sd	a0,-32(s0)
    if(pa == 0)
    8000799a:	fe043783          	ld	a5,-32(s0)
    8000799e:	eb89                	bnez	a5,800079b0 <loadseg+0x58>
      panic("loadseg: address should exist");
    800079a0:	00004517          	auipc	a0,0x4
    800079a4:	c4850513          	addi	a0,a0,-952 # 8000b5e8 <etext+0x5e8>
    800079a8:	ffff9097          	auipc	ra,0xffff9
    800079ac:	2d6080e7          	jalr	726(ra) # 80000c7e <panic>
    if(sz - i < PGSIZE)
    800079b0:	fc042703          	lw	a4,-64(s0)
    800079b4:	fec42783          	lw	a5,-20(s0)
    800079b8:	40f707bb          	subw	a5,a4,a5
    800079bc:	2781                	sext.w	a5,a5
    800079be:	873e                	mv	a4,a5
    800079c0:	6785                	lui	a5,0x1
    800079c2:	00f77b63          	bgeu	a4,a5,800079d8 <loadseg+0x80>
      n = sz - i;
    800079c6:	fc042703          	lw	a4,-64(s0)
    800079ca:	fec42783          	lw	a5,-20(s0)
    800079ce:	40f707bb          	subw	a5,a4,a5
    800079d2:	fef42423          	sw	a5,-24(s0)
    800079d6:	a021                	j	800079de <loadseg+0x86>
    else
      n = PGSIZE;
    800079d8:	6785                	lui	a5,0x1
    800079da:	fef42423          	sw	a5,-24(s0)
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800079de:	fc442703          	lw	a4,-60(s0)
    800079e2:	fec42783          	lw	a5,-20(s0)
    800079e6:	9fb9                	addw	a5,a5,a4
    800079e8:	2781                	sext.w	a5,a5
    800079ea:	fe842703          	lw	a4,-24(s0)
    800079ee:	86be                	mv	a3,a5
    800079f0:	fe043603          	ld	a2,-32(s0)
    800079f4:	4581                	li	a1,0
    800079f6:	fc843503          	ld	a0,-56(s0)
    800079fa:	ffffe097          	auipc	ra,0xffffe
    800079fe:	fbe080e7          	jalr	-66(ra) # 800059b8 <readi>
    80007a02:	87aa                	mv	a5,a0
    80007a04:	0007871b          	sext.w	a4,a5
    80007a08:	fe842783          	lw	a5,-24(s0)
    80007a0c:	2781                	sext.w	a5,a5
    80007a0e:	00e78463          	beq	a5,a4,80007a16 <loadseg+0xbe>
      return -1;
    80007a12:	57fd                	li	a5,-1
    80007a14:	a005                	j	80007a34 <loadseg+0xdc>
  for(i = 0; i < sz; i += PGSIZE){
    80007a16:	fec42703          	lw	a4,-20(s0)
    80007a1a:	6785                	lui	a5,0x1
    80007a1c:	9fb9                	addw	a5,a5,a4
    80007a1e:	fef42623          	sw	a5,-20(s0)
    80007a22:	fec42703          	lw	a4,-20(s0)
    80007a26:	fc042783          	lw	a5,-64(s0)
    80007a2a:	2701                	sext.w	a4,a4
    80007a2c:	2781                	sext.w	a5,a5
    80007a2e:	f4f768e3          	bltu	a4,a5,8000797e <loadseg+0x26>
  }
  
  return 0;
    80007a32:	4781                	li	a5,0
}
    80007a34:	853e                	mv	a0,a5
    80007a36:	70e2                	ld	ra,56(sp)
    80007a38:	7442                	ld	s0,48(sp)
    80007a3a:	6121                	addi	sp,sp,64
    80007a3c:	8082                	ret

0000000080007a3e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80007a3e:	7139                	addi	sp,sp,-64
    80007a40:	fc06                	sd	ra,56(sp)
    80007a42:	f822                	sd	s0,48(sp)
    80007a44:	0080                	addi	s0,sp,64
    80007a46:	87aa                	mv	a5,a0
    80007a48:	fcb43823          	sd	a1,-48(s0)
    80007a4c:	fcc43423          	sd	a2,-56(s0)
    80007a50:	fcf42e23          	sw	a5,-36(s0)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80007a54:	fe440713          	addi	a4,s0,-28
    80007a58:	fdc42783          	lw	a5,-36(s0)
    80007a5c:	85ba                	mv	a1,a4
    80007a5e:	853e                	mv	a0,a5
    80007a60:	ffffd097          	auipc	ra,0xffffd
    80007a64:	956080e7          	jalr	-1706(ra) # 800043b6 <argint>
    80007a68:	87aa                	mv	a5,a0
    80007a6a:	0007d463          	bgez	a5,80007a72 <argfd+0x34>
    return -1;
    80007a6e:	57fd                	li	a5,-1
    80007a70:	a8b1                	j	80007acc <argfd+0x8e>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80007a72:	fe442783          	lw	a5,-28(s0)
    80007a76:	0207c863          	bltz	a5,80007aa6 <argfd+0x68>
    80007a7a:	fe442783          	lw	a5,-28(s0)
    80007a7e:	873e                	mv	a4,a5
    80007a80:	47bd                	li	a5,15
    80007a82:	02e7c263          	blt	a5,a4,80007aa6 <argfd+0x68>
    80007a86:	ffffb097          	auipc	ra,0xffffb
    80007a8a:	d8e080e7          	jalr	-626(ra) # 80002814 <myproc>
    80007a8e:	872a                	mv	a4,a0
    80007a90:	fe442783          	lw	a5,-28(s0)
    80007a94:	07e9                	addi	a5,a5,26
    80007a96:	078e                	slli	a5,a5,0x3
    80007a98:	97ba                	add	a5,a5,a4
    80007a9a:	679c                	ld	a5,8(a5)
    80007a9c:	fef43423          	sd	a5,-24(s0)
    80007aa0:	fe843783          	ld	a5,-24(s0)
    80007aa4:	e399                	bnez	a5,80007aaa <argfd+0x6c>
    return -1;
    80007aa6:	57fd                	li	a5,-1
    80007aa8:	a015                	j	80007acc <argfd+0x8e>
  if(pfd)
    80007aaa:	fd043783          	ld	a5,-48(s0)
    80007aae:	c791                	beqz	a5,80007aba <argfd+0x7c>
    *pfd = fd;
    80007ab0:	fe442703          	lw	a4,-28(s0)
    80007ab4:	fd043783          	ld	a5,-48(s0)
    80007ab8:	c398                	sw	a4,0(a5)
  if(pf)
    80007aba:	fc843783          	ld	a5,-56(s0)
    80007abe:	c791                	beqz	a5,80007aca <argfd+0x8c>
    *pf = f;
    80007ac0:	fc843783          	ld	a5,-56(s0)
    80007ac4:	fe843703          	ld	a4,-24(s0)
    80007ac8:	e398                	sd	a4,0(a5)
  return 0;
    80007aca:	4781                	li	a5,0
}
    80007acc:	853e                	mv	a0,a5
    80007ace:	70e2                	ld	ra,56(sp)
    80007ad0:	7442                	ld	s0,48(sp)
    80007ad2:	6121                	addi	sp,sp,64
    80007ad4:	8082                	ret

0000000080007ad6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80007ad6:	7179                	addi	sp,sp,-48
    80007ad8:	f406                	sd	ra,40(sp)
    80007ada:	f022                	sd	s0,32(sp)
    80007adc:	1800                	addi	s0,sp,48
    80007ade:	fca43c23          	sd	a0,-40(s0)
  int fd;
  struct proc *p = myproc();
    80007ae2:	ffffb097          	auipc	ra,0xffffb
    80007ae6:	d32080e7          	jalr	-718(ra) # 80002814 <myproc>
    80007aea:	fea43023          	sd	a0,-32(s0)

  for(fd = 0; fd < NOFILE; fd++){
    80007aee:	fe042623          	sw	zero,-20(s0)
    80007af2:	a825                	j	80007b2a <fdalloc+0x54>
    if(p->ofile[fd] == 0){
    80007af4:	fe043703          	ld	a4,-32(s0)
    80007af8:	fec42783          	lw	a5,-20(s0)
    80007afc:	07e9                	addi	a5,a5,26
    80007afe:	078e                	slli	a5,a5,0x3
    80007b00:	97ba                	add	a5,a5,a4
    80007b02:	679c                	ld	a5,8(a5)
    80007b04:	ef91                	bnez	a5,80007b20 <fdalloc+0x4a>
      p->ofile[fd] = f;
    80007b06:	fe043703          	ld	a4,-32(s0)
    80007b0a:	fec42783          	lw	a5,-20(s0)
    80007b0e:	07e9                	addi	a5,a5,26
    80007b10:	078e                	slli	a5,a5,0x3
    80007b12:	97ba                	add	a5,a5,a4
    80007b14:	fd843703          	ld	a4,-40(s0)
    80007b18:	e798                	sd	a4,8(a5)
      return fd;
    80007b1a:	fec42783          	lw	a5,-20(s0)
    80007b1e:	a831                	j	80007b3a <fdalloc+0x64>
  for(fd = 0; fd < NOFILE; fd++){
    80007b20:	fec42783          	lw	a5,-20(s0)
    80007b24:	2785                	addiw	a5,a5,1
    80007b26:	fef42623          	sw	a5,-20(s0)
    80007b2a:	fec42783          	lw	a5,-20(s0)
    80007b2e:	0007871b          	sext.w	a4,a5
    80007b32:	47bd                	li	a5,15
    80007b34:	fce7d0e3          	bge	a5,a4,80007af4 <fdalloc+0x1e>
    }
  }
  return -1;
    80007b38:	57fd                	li	a5,-1
}
    80007b3a:	853e                	mv	a0,a5
    80007b3c:	70a2                	ld	ra,40(sp)
    80007b3e:	7402                	ld	s0,32(sp)
    80007b40:	6145                	addi	sp,sp,48
    80007b42:	8082                	ret

0000000080007b44 <sys_dup>:

uint64
sys_dup(void)
{
    80007b44:	1101                	addi	sp,sp,-32
    80007b46:	ec06                	sd	ra,24(sp)
    80007b48:	e822                	sd	s0,16(sp)
    80007b4a:	1000                	addi	s0,sp,32
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    80007b4c:	fe040793          	addi	a5,s0,-32
    80007b50:	863e                	mv	a2,a5
    80007b52:	4581                	li	a1,0
    80007b54:	4501                	li	a0,0
    80007b56:	00000097          	auipc	ra,0x0
    80007b5a:	ee8080e7          	jalr	-280(ra) # 80007a3e <argfd>
    80007b5e:	87aa                	mv	a5,a0
    80007b60:	0007d463          	bgez	a5,80007b68 <sys_dup+0x24>
    return -1;
    80007b64:	57fd                	li	a5,-1
    80007b66:	a81d                	j	80007b9c <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
    80007b68:	fe043783          	ld	a5,-32(s0)
    80007b6c:	853e                	mv	a0,a5
    80007b6e:	00000097          	auipc	ra,0x0
    80007b72:	f68080e7          	jalr	-152(ra) # 80007ad6 <fdalloc>
    80007b76:	87aa                	mv	a5,a0
    80007b78:	fef42623          	sw	a5,-20(s0)
    80007b7c:	fec42783          	lw	a5,-20(s0)
    80007b80:	2781                	sext.w	a5,a5
    80007b82:	0007d463          	bgez	a5,80007b8a <sys_dup+0x46>
    return -1;
    80007b86:	57fd                	li	a5,-1
    80007b88:	a811                	j	80007b9c <sys_dup+0x58>
  filedup(f);
    80007b8a:	fe043783          	ld	a5,-32(s0)
    80007b8e:	853e                	mv	a0,a5
    80007b90:	fffff097          	auipc	ra,0xfffff
    80007b94:	f20080e7          	jalr	-224(ra) # 80006ab0 <filedup>
  return fd;
    80007b98:	fec42783          	lw	a5,-20(s0)
}
    80007b9c:	853e                	mv	a0,a5
    80007b9e:	60e2                	ld	ra,24(sp)
    80007ba0:	6442                	ld	s0,16(sp)
    80007ba2:	6105                	addi	sp,sp,32
    80007ba4:	8082                	ret

0000000080007ba6 <sys_read>:

uint64
sys_read(void)
{
    80007ba6:	7179                	addi	sp,sp,-48
    80007ba8:	f406                	sd	ra,40(sp)
    80007baa:	f022                	sd	s0,32(sp)
    80007bac:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80007bae:	fe840793          	addi	a5,s0,-24
    80007bb2:	863e                	mv	a2,a5
    80007bb4:	4581                	li	a1,0
    80007bb6:	4501                	li	a0,0
    80007bb8:	00000097          	auipc	ra,0x0
    80007bbc:	e86080e7          	jalr	-378(ra) # 80007a3e <argfd>
    80007bc0:	87aa                	mv	a5,a0
    80007bc2:	0207c863          	bltz	a5,80007bf2 <sys_read+0x4c>
    80007bc6:	fe440793          	addi	a5,s0,-28
    80007bca:	85be                	mv	a1,a5
    80007bcc:	4509                	li	a0,2
    80007bce:	ffffc097          	auipc	ra,0xffffc
    80007bd2:	7e8080e7          	jalr	2024(ra) # 800043b6 <argint>
    80007bd6:	87aa                	mv	a5,a0
    80007bd8:	0007cd63          	bltz	a5,80007bf2 <sys_read+0x4c>
    80007bdc:	fd840793          	addi	a5,s0,-40
    80007be0:	85be                	mv	a1,a5
    80007be2:	4505                	li	a0,1
    80007be4:	ffffd097          	auipc	ra,0xffffd
    80007be8:	80a080e7          	jalr	-2038(ra) # 800043ee <argaddr>
    80007bec:	87aa                	mv	a5,a0
    80007bee:	0007d463          	bgez	a5,80007bf6 <sys_read+0x50>
    return -1;
    80007bf2:	57fd                	li	a5,-1
    80007bf4:	a839                	j	80007c12 <sys_read+0x6c>
  return fileread(f, p, n);
    80007bf6:	fe843783          	ld	a5,-24(s0)
    80007bfa:	fd843703          	ld	a4,-40(s0)
    80007bfe:	fe442683          	lw	a3,-28(s0)
    80007c02:	8636                	mv	a2,a3
    80007c04:	85ba                	mv	a1,a4
    80007c06:	853e                	mv	a0,a5
    80007c08:	fffff097          	auipc	ra,0xfffff
    80007c0c:	0ba080e7          	jalr	186(ra) # 80006cc2 <fileread>
    80007c10:	87aa                	mv	a5,a0
}
    80007c12:	853e                	mv	a0,a5
    80007c14:	70a2                	ld	ra,40(sp)
    80007c16:	7402                	ld	s0,32(sp)
    80007c18:	6145                	addi	sp,sp,48
    80007c1a:	8082                	ret

0000000080007c1c <sys_write>:

uint64
sys_write(void)
{
    80007c1c:	7179                	addi	sp,sp,-48
    80007c1e:	f406                	sd	ra,40(sp)
    80007c20:	f022                	sd	s0,32(sp)
    80007c22:	1800                	addi	s0,sp,48
  struct file *f;
  int n;
  uint64 p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80007c24:	fe840793          	addi	a5,s0,-24
    80007c28:	863e                	mv	a2,a5
    80007c2a:	4581                	li	a1,0
    80007c2c:	4501                	li	a0,0
    80007c2e:	00000097          	auipc	ra,0x0
    80007c32:	e10080e7          	jalr	-496(ra) # 80007a3e <argfd>
    80007c36:	87aa                	mv	a5,a0
    80007c38:	0207c863          	bltz	a5,80007c68 <sys_write+0x4c>
    80007c3c:	fe440793          	addi	a5,s0,-28
    80007c40:	85be                	mv	a1,a5
    80007c42:	4509                	li	a0,2
    80007c44:	ffffc097          	auipc	ra,0xffffc
    80007c48:	772080e7          	jalr	1906(ra) # 800043b6 <argint>
    80007c4c:	87aa                	mv	a5,a0
    80007c4e:	0007cd63          	bltz	a5,80007c68 <sys_write+0x4c>
    80007c52:	fd840793          	addi	a5,s0,-40
    80007c56:	85be                	mv	a1,a5
    80007c58:	4505                	li	a0,1
    80007c5a:	ffffc097          	auipc	ra,0xffffc
    80007c5e:	794080e7          	jalr	1940(ra) # 800043ee <argaddr>
    80007c62:	87aa                	mv	a5,a0
    80007c64:	0007d463          	bgez	a5,80007c6c <sys_write+0x50>
    return -1;
    80007c68:	57fd                	li	a5,-1
    80007c6a:	a839                	j	80007c88 <sys_write+0x6c>

  return filewrite(f, p, n);
    80007c6c:	fe843783          	ld	a5,-24(s0)
    80007c70:	fd843703          	ld	a4,-40(s0)
    80007c74:	fe442683          	lw	a3,-28(s0)
    80007c78:	8636                	mv	a2,a3
    80007c7a:	85ba                	mv	a1,a4
    80007c7c:	853e                	mv	a0,a5
    80007c7e:	fffff097          	auipc	ra,0xfffff
    80007c82:	1aa080e7          	jalr	426(ra) # 80006e28 <filewrite>
    80007c86:	87aa                	mv	a5,a0
}
    80007c88:	853e                	mv	a0,a5
    80007c8a:	70a2                	ld	ra,40(sp)
    80007c8c:	7402                	ld	s0,32(sp)
    80007c8e:	6145                	addi	sp,sp,48
    80007c90:	8082                	ret

0000000080007c92 <sys_close>:

uint64
sys_close(void)
{
    80007c92:	1101                	addi	sp,sp,-32
    80007c94:	ec06                	sd	ra,24(sp)
    80007c96:	e822                	sd	s0,16(sp)
    80007c98:	1000                	addi	s0,sp,32
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    80007c9a:	fe040713          	addi	a4,s0,-32
    80007c9e:	fec40793          	addi	a5,s0,-20
    80007ca2:	863a                	mv	a2,a4
    80007ca4:	85be                	mv	a1,a5
    80007ca6:	4501                	li	a0,0
    80007ca8:	00000097          	auipc	ra,0x0
    80007cac:	d96080e7          	jalr	-618(ra) # 80007a3e <argfd>
    80007cb0:	87aa                	mv	a5,a0
    80007cb2:	0007d463          	bgez	a5,80007cba <sys_close+0x28>
    return -1;
    80007cb6:	57fd                	li	a5,-1
    80007cb8:	a02d                	j	80007ce2 <sys_close+0x50>
  myproc()->ofile[fd] = 0;
    80007cba:	ffffb097          	auipc	ra,0xffffb
    80007cbe:	b5a080e7          	jalr	-1190(ra) # 80002814 <myproc>
    80007cc2:	872a                	mv	a4,a0
    80007cc4:	fec42783          	lw	a5,-20(s0)
    80007cc8:	07e9                	addi	a5,a5,26
    80007cca:	078e                	slli	a5,a5,0x3
    80007ccc:	97ba                	add	a5,a5,a4
    80007cce:	0007b423          	sd	zero,8(a5) # 1008 <_entry-0x7fffeff8>
  fileclose(f);
    80007cd2:	fe043783          	ld	a5,-32(s0)
    80007cd6:	853e                	mv	a0,a5
    80007cd8:	fffff097          	auipc	ra,0xfffff
    80007cdc:	e3e080e7          	jalr	-450(ra) # 80006b16 <fileclose>
  return 0;
    80007ce0:	4781                	li	a5,0
}
    80007ce2:	853e                	mv	a0,a5
    80007ce4:	60e2                	ld	ra,24(sp)
    80007ce6:	6442                	ld	s0,16(sp)
    80007ce8:	6105                	addi	sp,sp,32
    80007cea:	8082                	ret

0000000080007cec <sys_fstat>:

uint64
sys_fstat(void)
{
    80007cec:	1101                	addi	sp,sp,-32
    80007cee:	ec06                	sd	ra,24(sp)
    80007cf0:	e822                	sd	s0,16(sp)
    80007cf2:	1000                	addi	s0,sp,32
  struct file *f;
  uint64 st; // user pointer to struct stat

  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80007cf4:	fe840793          	addi	a5,s0,-24
    80007cf8:	863e                	mv	a2,a5
    80007cfa:	4581                	li	a1,0
    80007cfc:	4501                	li	a0,0
    80007cfe:	00000097          	auipc	ra,0x0
    80007d02:	d40080e7          	jalr	-704(ra) # 80007a3e <argfd>
    80007d06:	87aa                	mv	a5,a0
    80007d08:	0007cd63          	bltz	a5,80007d22 <sys_fstat+0x36>
    80007d0c:	fe040793          	addi	a5,s0,-32
    80007d10:	85be                	mv	a1,a5
    80007d12:	4505                	li	a0,1
    80007d14:	ffffc097          	auipc	ra,0xffffc
    80007d18:	6da080e7          	jalr	1754(ra) # 800043ee <argaddr>
    80007d1c:	87aa                	mv	a5,a0
    80007d1e:	0007d463          	bgez	a5,80007d26 <sys_fstat+0x3a>
    return -1;
    80007d22:	57fd                	li	a5,-1
    80007d24:	a821                	j	80007d3c <sys_fstat+0x50>
  return filestat(f, st);
    80007d26:	fe843783          	ld	a5,-24(s0)
    80007d2a:	fe043703          	ld	a4,-32(s0)
    80007d2e:	85ba                	mv	a1,a4
    80007d30:	853e                	mv	a0,a5
    80007d32:	fffff097          	auipc	ra,0xfffff
    80007d36:	eec080e7          	jalr	-276(ra) # 80006c1e <filestat>
    80007d3a:	87aa                	mv	a5,a0
}
    80007d3c:	853e                	mv	a0,a5
    80007d3e:	60e2                	ld	ra,24(sp)
    80007d40:	6442                	ld	s0,16(sp)
    80007d42:	6105                	addi	sp,sp,32
    80007d44:	8082                	ret

0000000080007d46 <sys_link>:

// Create the path new as a link to the same inode as old.
uint64
sys_link(void)
{
    80007d46:	7169                	addi	sp,sp,-304
    80007d48:	f606                	sd	ra,296(sp)
    80007d4a:	f222                	sd	s0,288(sp)
    80007d4c:	1a00                	addi	s0,sp,304
  char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
  struct inode *dp, *ip;

  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80007d4e:	ed040793          	addi	a5,s0,-304
    80007d52:	08000613          	li	a2,128
    80007d56:	85be                	mv	a1,a5
    80007d58:	4501                	li	a0,0
    80007d5a:	ffffc097          	auipc	ra,0xffffc
    80007d5e:	6c8080e7          	jalr	1736(ra) # 80004422 <argstr>
    80007d62:	87aa                	mv	a5,a0
    80007d64:	0007cf63          	bltz	a5,80007d82 <sys_link+0x3c>
    80007d68:	f5040793          	addi	a5,s0,-176
    80007d6c:	08000613          	li	a2,128
    80007d70:	85be                	mv	a1,a5
    80007d72:	4505                	li	a0,1
    80007d74:	ffffc097          	auipc	ra,0xffffc
    80007d78:	6ae080e7          	jalr	1710(ra) # 80004422 <argstr>
    80007d7c:	87aa                	mv	a5,a0
    80007d7e:	0007d463          	bgez	a5,80007d86 <sys_link+0x40>
    return -1;
    80007d82:	57fd                	li	a5,-1
    80007d84:	aab5                	j	80007f00 <sys_link+0x1ba>

  begin_op();
    80007d86:	ffffe097          	auipc	ra,0xffffe
    80007d8a:	6f6080e7          	jalr	1782(ra) # 8000647c <begin_op>
  if((ip = namei(old)) == 0){
    80007d8e:	ed040793          	addi	a5,s0,-304
    80007d92:	853e                	mv	a0,a5
    80007d94:	ffffe097          	auipc	ra,0xffffe
    80007d98:	384080e7          	jalr	900(ra) # 80006118 <namei>
    80007d9c:	fea43423          	sd	a0,-24(s0)
    80007da0:	fe843783          	ld	a5,-24(s0)
    80007da4:	e799                	bnez	a5,80007db2 <sys_link+0x6c>
    end_op();
    80007da6:	ffffe097          	auipc	ra,0xffffe
    80007daa:	798080e7          	jalr	1944(ra) # 8000653e <end_op>
    return -1;
    80007dae:	57fd                	li	a5,-1
    80007db0:	aa81                	j	80007f00 <sys_link+0x1ba>
  }

  ilock(ip);
    80007db2:	fe843503          	ld	a0,-24(s0)
    80007db6:	ffffd097          	auipc	ra,0xffffd
    80007dba:	66c080e7          	jalr	1644(ra) # 80005422 <ilock>
  if(ip->type == T_DIR){
    80007dbe:	fe843783          	ld	a5,-24(s0)
    80007dc2:	04479783          	lh	a5,68(a5)
    80007dc6:	0007871b          	sext.w	a4,a5
    80007dca:	4785                	li	a5,1
    80007dcc:	00f71e63          	bne	a4,a5,80007de8 <sys_link+0xa2>
    iunlockput(ip);
    80007dd0:	fe843503          	ld	a0,-24(s0)
    80007dd4:	ffffe097          	auipc	ra,0xffffe
    80007dd8:	8ac080e7          	jalr	-1876(ra) # 80005680 <iunlockput>
    end_op();
    80007ddc:	ffffe097          	auipc	ra,0xffffe
    80007de0:	762080e7          	jalr	1890(ra) # 8000653e <end_op>
    return -1;
    80007de4:	57fd                	li	a5,-1
    80007de6:	aa29                	j	80007f00 <sys_link+0x1ba>
  }

  ip->nlink++;
    80007de8:	fe843783          	ld	a5,-24(s0)
    80007dec:	04a79783          	lh	a5,74(a5)
    80007df0:	17c2                	slli	a5,a5,0x30
    80007df2:	93c1                	srli	a5,a5,0x30
    80007df4:	2785                	addiw	a5,a5,1
    80007df6:	17c2                	slli	a5,a5,0x30
    80007df8:	93c1                	srli	a5,a5,0x30
    80007dfa:	0107971b          	slliw	a4,a5,0x10
    80007dfe:	4107571b          	sraiw	a4,a4,0x10
    80007e02:	fe843783          	ld	a5,-24(s0)
    80007e06:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007e0a:	fe843503          	ld	a0,-24(s0)
    80007e0e:	ffffd097          	auipc	ra,0xffffd
    80007e12:	3c4080e7          	jalr	964(ra) # 800051d2 <iupdate>
  iunlock(ip);
    80007e16:	fe843503          	ld	a0,-24(s0)
    80007e1a:	ffffd097          	auipc	ra,0xffffd
    80007e1e:	73c080e7          	jalr	1852(ra) # 80005556 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
    80007e22:	fd040713          	addi	a4,s0,-48
    80007e26:	f5040793          	addi	a5,s0,-176
    80007e2a:	85ba                	mv	a1,a4
    80007e2c:	853e                	mv	a0,a5
    80007e2e:	ffffe097          	auipc	ra,0xffffe
    80007e32:	316080e7          	jalr	790(ra) # 80006144 <nameiparent>
    80007e36:	fea43023          	sd	a0,-32(s0)
    80007e3a:	fe043783          	ld	a5,-32(s0)
    80007e3e:	cba5                	beqz	a5,80007eae <sys_link+0x168>
    goto bad;
  ilock(dp);
    80007e40:	fe043503          	ld	a0,-32(s0)
    80007e44:	ffffd097          	auipc	ra,0xffffd
    80007e48:	5de080e7          	jalr	1502(ra) # 80005422 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80007e4c:	fe043783          	ld	a5,-32(s0)
    80007e50:	4398                	lw	a4,0(a5)
    80007e52:	fe843783          	ld	a5,-24(s0)
    80007e56:	439c                	lw	a5,0(a5)
    80007e58:	02f71263          	bne	a4,a5,80007e7c <sys_link+0x136>
    80007e5c:	fe843783          	ld	a5,-24(s0)
    80007e60:	43d8                	lw	a4,4(a5)
    80007e62:	fd040793          	addi	a5,s0,-48
    80007e66:	863a                	mv	a2,a4
    80007e68:	85be                	mv	a1,a5
    80007e6a:	fe043503          	ld	a0,-32(s0)
    80007e6e:	ffffe097          	auipc	ra,0xffffe
    80007e72:	f90080e7          	jalr	-112(ra) # 80005dfe <dirlink>
    80007e76:	87aa                	mv	a5,a0
    80007e78:	0007d963          	bgez	a5,80007e8a <sys_link+0x144>
    iunlockput(dp);
    80007e7c:	fe043503          	ld	a0,-32(s0)
    80007e80:	ffffe097          	auipc	ra,0xffffe
    80007e84:	800080e7          	jalr	-2048(ra) # 80005680 <iunlockput>
    goto bad;
    80007e88:	a025                	j	80007eb0 <sys_link+0x16a>
  }
  iunlockput(dp);
    80007e8a:	fe043503          	ld	a0,-32(s0)
    80007e8e:	ffffd097          	auipc	ra,0xffffd
    80007e92:	7f2080e7          	jalr	2034(ra) # 80005680 <iunlockput>
  iput(ip);
    80007e96:	fe843503          	ld	a0,-24(s0)
    80007e9a:	ffffd097          	auipc	ra,0xffffd
    80007e9e:	716080e7          	jalr	1814(ra) # 800055b0 <iput>

  end_op();
    80007ea2:	ffffe097          	auipc	ra,0xffffe
    80007ea6:	69c080e7          	jalr	1692(ra) # 8000653e <end_op>

  return 0;
    80007eaa:	4781                	li	a5,0
    80007eac:	a891                	j	80007f00 <sys_link+0x1ba>
    goto bad;
    80007eae:	0001                	nop

bad:
  ilock(ip);
    80007eb0:	fe843503          	ld	a0,-24(s0)
    80007eb4:	ffffd097          	auipc	ra,0xffffd
    80007eb8:	56e080e7          	jalr	1390(ra) # 80005422 <ilock>
  ip->nlink--;
    80007ebc:	fe843783          	ld	a5,-24(s0)
    80007ec0:	04a79783          	lh	a5,74(a5)
    80007ec4:	17c2                	slli	a5,a5,0x30
    80007ec6:	93c1                	srli	a5,a5,0x30
    80007ec8:	37fd                	addiw	a5,a5,-1
    80007eca:	17c2                	slli	a5,a5,0x30
    80007ecc:	93c1                	srli	a5,a5,0x30
    80007ece:	0107971b          	slliw	a4,a5,0x10
    80007ed2:	4107571b          	sraiw	a4,a4,0x10
    80007ed6:	fe843783          	ld	a5,-24(s0)
    80007eda:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80007ede:	fe843503          	ld	a0,-24(s0)
    80007ee2:	ffffd097          	auipc	ra,0xffffd
    80007ee6:	2f0080e7          	jalr	752(ra) # 800051d2 <iupdate>
  iunlockput(ip);
    80007eea:	fe843503          	ld	a0,-24(s0)
    80007eee:	ffffd097          	auipc	ra,0xffffd
    80007ef2:	792080e7          	jalr	1938(ra) # 80005680 <iunlockput>
  end_op();
    80007ef6:	ffffe097          	auipc	ra,0xffffe
    80007efa:	648080e7          	jalr	1608(ra) # 8000653e <end_op>
  return -1;
    80007efe:	57fd                	li	a5,-1
}
    80007f00:	853e                	mv	a0,a5
    80007f02:	70b2                	ld	ra,296(sp)
    80007f04:	7412                	ld	s0,288(sp)
    80007f06:	6155                	addi	sp,sp,304
    80007f08:	8082                	ret

0000000080007f0a <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
    80007f0a:	7139                	addi	sp,sp,-64
    80007f0c:	fc06                	sd	ra,56(sp)
    80007f0e:	f822                	sd	s0,48(sp)
    80007f10:	0080                	addi	s0,sp,64
    80007f12:	fca43423          	sd	a0,-56(s0)
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007f16:	02000793          	li	a5,32
    80007f1a:	fef42623          	sw	a5,-20(s0)
    80007f1e:	a0b1                	j	80007f6a <isdirempty+0x60>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80007f20:	fd840793          	addi	a5,s0,-40
    80007f24:	fec42683          	lw	a3,-20(s0)
    80007f28:	4741                	li	a4,16
    80007f2a:	863e                	mv	a2,a5
    80007f2c:	4581                	li	a1,0
    80007f2e:	fc843503          	ld	a0,-56(s0)
    80007f32:	ffffe097          	auipc	ra,0xffffe
    80007f36:	a86080e7          	jalr	-1402(ra) # 800059b8 <readi>
    80007f3a:	87aa                	mv	a5,a0
    80007f3c:	873e                	mv	a4,a5
    80007f3e:	47c1                	li	a5,16
    80007f40:	00f70a63          	beq	a4,a5,80007f54 <isdirempty+0x4a>
      panic("isdirempty: readi");
    80007f44:	00003517          	auipc	a0,0x3
    80007f48:	6c450513          	addi	a0,a0,1732 # 8000b608 <etext+0x608>
    80007f4c:	ffff9097          	auipc	ra,0xffff9
    80007f50:	d32080e7          	jalr	-718(ra) # 80000c7e <panic>
    if(de.inum != 0)
    80007f54:	fd845783          	lhu	a5,-40(s0)
    80007f58:	c399                	beqz	a5,80007f5e <isdirempty+0x54>
      return 0;
    80007f5a:	4781                	li	a5,0
    80007f5c:	a839                	j	80007f7a <isdirempty+0x70>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80007f5e:	fec42783          	lw	a5,-20(s0)
    80007f62:	27c1                	addiw	a5,a5,16
    80007f64:	2781                	sext.w	a5,a5
    80007f66:	fef42623          	sw	a5,-20(s0)
    80007f6a:	fc843783          	ld	a5,-56(s0)
    80007f6e:	47f8                	lw	a4,76(a5)
    80007f70:	fec42783          	lw	a5,-20(s0)
    80007f74:	fae7e6e3          	bltu	a5,a4,80007f20 <isdirempty+0x16>
  }
  return 1;
    80007f78:	4785                	li	a5,1
}
    80007f7a:	853e                	mv	a0,a5
    80007f7c:	70e2                	ld	ra,56(sp)
    80007f7e:	7442                	ld	s0,48(sp)
    80007f80:	6121                	addi	sp,sp,64
    80007f82:	8082                	ret

0000000080007f84 <sys_unlink>:

uint64
sys_unlink(void)
{
    80007f84:	7155                	addi	sp,sp,-208
    80007f86:	e586                	sd	ra,200(sp)
    80007f88:	e1a2                	sd	s0,192(sp)
    80007f8a:	0980                	addi	s0,sp,208
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], path[MAXPATH];
  uint off;

  if(argstr(0, path, MAXPATH) < 0)
    80007f8c:	f4040793          	addi	a5,s0,-192
    80007f90:	08000613          	li	a2,128
    80007f94:	85be                	mv	a1,a5
    80007f96:	4501                	li	a0,0
    80007f98:	ffffc097          	auipc	ra,0xffffc
    80007f9c:	48a080e7          	jalr	1162(ra) # 80004422 <argstr>
    80007fa0:	87aa                	mv	a5,a0
    80007fa2:	0007d463          	bgez	a5,80007faa <sys_unlink+0x26>
    return -1;
    80007fa6:	57fd                	li	a5,-1
    80007fa8:	a2ed                	j	80008192 <sys_unlink+0x20e>

  begin_op();
    80007faa:	ffffe097          	auipc	ra,0xffffe
    80007fae:	4d2080e7          	jalr	1234(ra) # 8000647c <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80007fb2:	fc040713          	addi	a4,s0,-64
    80007fb6:	f4040793          	addi	a5,s0,-192
    80007fba:	85ba                	mv	a1,a4
    80007fbc:	853e                	mv	a0,a5
    80007fbe:	ffffe097          	auipc	ra,0xffffe
    80007fc2:	186080e7          	jalr	390(ra) # 80006144 <nameiparent>
    80007fc6:	fea43423          	sd	a0,-24(s0)
    80007fca:	fe843783          	ld	a5,-24(s0)
    80007fce:	e799                	bnez	a5,80007fdc <sys_unlink+0x58>
    end_op();
    80007fd0:	ffffe097          	auipc	ra,0xffffe
    80007fd4:	56e080e7          	jalr	1390(ra) # 8000653e <end_op>
    return -1;
    80007fd8:	57fd                	li	a5,-1
    80007fda:	aa65                	j	80008192 <sys_unlink+0x20e>
  }

  ilock(dp);
    80007fdc:	fe843503          	ld	a0,-24(s0)
    80007fe0:	ffffd097          	auipc	ra,0xffffd
    80007fe4:	442080e7          	jalr	1090(ra) # 80005422 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80007fe8:	fc040793          	addi	a5,s0,-64
    80007fec:	00003597          	auipc	a1,0x3
    80007ff0:	63458593          	addi	a1,a1,1588 # 8000b620 <etext+0x620>
    80007ff4:	853e                	mv	a0,a5
    80007ff6:	ffffe097          	auipc	ra,0xffffe
    80007ffa:	cf2080e7          	jalr	-782(ra) # 80005ce8 <namecmp>
    80007ffe:	87aa                	mv	a5,a0
    80008000:	16078b63          	beqz	a5,80008176 <sys_unlink+0x1f2>
    80008004:	fc040793          	addi	a5,s0,-64
    80008008:	00003597          	auipc	a1,0x3
    8000800c:	62058593          	addi	a1,a1,1568 # 8000b628 <etext+0x628>
    80008010:	853e                	mv	a0,a5
    80008012:	ffffe097          	auipc	ra,0xffffe
    80008016:	cd6080e7          	jalr	-810(ra) # 80005ce8 <namecmp>
    8000801a:	87aa                	mv	a5,a0
    8000801c:	14078d63          	beqz	a5,80008176 <sys_unlink+0x1f2>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    80008020:	f3c40713          	addi	a4,s0,-196
    80008024:	fc040793          	addi	a5,s0,-64
    80008028:	863a                	mv	a2,a4
    8000802a:	85be                	mv	a1,a5
    8000802c:	fe843503          	ld	a0,-24(s0)
    80008030:	ffffe097          	auipc	ra,0xffffe
    80008034:	ce6080e7          	jalr	-794(ra) # 80005d16 <dirlookup>
    80008038:	fea43023          	sd	a0,-32(s0)
    8000803c:	fe043783          	ld	a5,-32(s0)
    80008040:	12078d63          	beqz	a5,8000817a <sys_unlink+0x1f6>
    goto bad;
  ilock(ip);
    80008044:	fe043503          	ld	a0,-32(s0)
    80008048:	ffffd097          	auipc	ra,0xffffd
    8000804c:	3da080e7          	jalr	986(ra) # 80005422 <ilock>

  if(ip->nlink < 1)
    80008050:	fe043783          	ld	a5,-32(s0)
    80008054:	04a79783          	lh	a5,74(a5)
    80008058:	2781                	sext.w	a5,a5
    8000805a:	00f04a63          	bgtz	a5,8000806e <sys_unlink+0xea>
    panic("unlink: nlink < 1");
    8000805e:	00003517          	auipc	a0,0x3
    80008062:	5d250513          	addi	a0,a0,1490 # 8000b630 <etext+0x630>
    80008066:	ffff9097          	auipc	ra,0xffff9
    8000806a:	c18080e7          	jalr	-1000(ra) # 80000c7e <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
    8000806e:	fe043783          	ld	a5,-32(s0)
    80008072:	04479783          	lh	a5,68(a5)
    80008076:	0007871b          	sext.w	a4,a5
    8000807a:	4785                	li	a5,1
    8000807c:	02f71163          	bne	a4,a5,8000809e <sys_unlink+0x11a>
    80008080:	fe043503          	ld	a0,-32(s0)
    80008084:	00000097          	auipc	ra,0x0
    80008088:	e86080e7          	jalr	-378(ra) # 80007f0a <isdirempty>
    8000808c:	87aa                	mv	a5,a0
    8000808e:	eb81                	bnez	a5,8000809e <sys_unlink+0x11a>
    iunlockput(ip);
    80008090:	fe043503          	ld	a0,-32(s0)
    80008094:	ffffd097          	auipc	ra,0xffffd
    80008098:	5ec080e7          	jalr	1516(ra) # 80005680 <iunlockput>
    goto bad;
    8000809c:	a0c5                	j	8000817c <sys_unlink+0x1f8>
  }

  memset(&de, 0, sizeof(de));
    8000809e:	fd040793          	addi	a5,s0,-48
    800080a2:	4641                	li	a2,16
    800080a4:	4581                	li	a1,0
    800080a6:	853e                	mv	a0,a5
    800080a8:	ffff9097          	auipc	ra,0xffff9
    800080ac:	39a080e7          	jalr	922(ra) # 80001442 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800080b0:	fd040793          	addi	a5,s0,-48
    800080b4:	f3c42683          	lw	a3,-196(s0)
    800080b8:	4741                	li	a4,16
    800080ba:	863e                	mv	a2,a5
    800080bc:	4581                	li	a1,0
    800080be:	fe843503          	ld	a0,-24(s0)
    800080c2:	ffffe097          	auipc	ra,0xffffe
    800080c6:	a80080e7          	jalr	-1408(ra) # 80005b42 <writei>
    800080ca:	87aa                	mv	a5,a0
    800080cc:	873e                	mv	a4,a5
    800080ce:	47c1                	li	a5,16
    800080d0:	00f70a63          	beq	a4,a5,800080e4 <sys_unlink+0x160>
    panic("unlink: writei");
    800080d4:	00003517          	auipc	a0,0x3
    800080d8:	57450513          	addi	a0,a0,1396 # 8000b648 <etext+0x648>
    800080dc:	ffff9097          	auipc	ra,0xffff9
    800080e0:	ba2080e7          	jalr	-1118(ra) # 80000c7e <panic>
  if(ip->type == T_DIR){
    800080e4:	fe043783          	ld	a5,-32(s0)
    800080e8:	04479783          	lh	a5,68(a5)
    800080ec:	0007871b          	sext.w	a4,a5
    800080f0:	4785                	li	a5,1
    800080f2:	02f71963          	bne	a4,a5,80008124 <sys_unlink+0x1a0>
    dp->nlink--;
    800080f6:	fe843783          	ld	a5,-24(s0)
    800080fa:	04a79783          	lh	a5,74(a5)
    800080fe:	17c2                	slli	a5,a5,0x30
    80008100:	93c1                	srli	a5,a5,0x30
    80008102:	37fd                	addiw	a5,a5,-1
    80008104:	17c2                	slli	a5,a5,0x30
    80008106:	93c1                	srli	a5,a5,0x30
    80008108:	0107971b          	slliw	a4,a5,0x10
    8000810c:	4107571b          	sraiw	a4,a4,0x10
    80008110:	fe843783          	ld	a5,-24(s0)
    80008114:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008118:	fe843503          	ld	a0,-24(s0)
    8000811c:	ffffd097          	auipc	ra,0xffffd
    80008120:	0b6080e7          	jalr	182(ra) # 800051d2 <iupdate>
  }
  iunlockput(dp);
    80008124:	fe843503          	ld	a0,-24(s0)
    80008128:	ffffd097          	auipc	ra,0xffffd
    8000812c:	558080e7          	jalr	1368(ra) # 80005680 <iunlockput>

  ip->nlink--;
    80008130:	fe043783          	ld	a5,-32(s0)
    80008134:	04a79783          	lh	a5,74(a5)
    80008138:	17c2                	slli	a5,a5,0x30
    8000813a:	93c1                	srli	a5,a5,0x30
    8000813c:	37fd                	addiw	a5,a5,-1
    8000813e:	17c2                	slli	a5,a5,0x30
    80008140:	93c1                	srli	a5,a5,0x30
    80008142:	0107971b          	slliw	a4,a5,0x10
    80008146:	4107571b          	sraiw	a4,a4,0x10
    8000814a:	fe043783          	ld	a5,-32(s0)
    8000814e:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    80008152:	fe043503          	ld	a0,-32(s0)
    80008156:	ffffd097          	auipc	ra,0xffffd
    8000815a:	07c080e7          	jalr	124(ra) # 800051d2 <iupdate>
  iunlockput(ip);
    8000815e:	fe043503          	ld	a0,-32(s0)
    80008162:	ffffd097          	auipc	ra,0xffffd
    80008166:	51e080e7          	jalr	1310(ra) # 80005680 <iunlockput>

  end_op();
    8000816a:	ffffe097          	auipc	ra,0xffffe
    8000816e:	3d4080e7          	jalr	980(ra) # 8000653e <end_op>

  return 0;
    80008172:	4781                	li	a5,0
    80008174:	a839                	j	80008192 <sys_unlink+0x20e>
    goto bad;
    80008176:	0001                	nop
    80008178:	a011                	j	8000817c <sys_unlink+0x1f8>
    goto bad;
    8000817a:	0001                	nop

bad:
  iunlockput(dp);
    8000817c:	fe843503          	ld	a0,-24(s0)
    80008180:	ffffd097          	auipc	ra,0xffffd
    80008184:	500080e7          	jalr	1280(ra) # 80005680 <iunlockput>
  end_op();
    80008188:	ffffe097          	auipc	ra,0xffffe
    8000818c:	3b6080e7          	jalr	950(ra) # 8000653e <end_op>
  return -1;
    80008190:	57fd                	li	a5,-1
}
    80008192:	853e                	mv	a0,a5
    80008194:	60ae                	ld	ra,200(sp)
    80008196:	640e                	ld	s0,192(sp)
    80008198:	6169                	addi	sp,sp,208
    8000819a:	8082                	ret

000000008000819c <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000819c:	7139                	addi	sp,sp,-64
    8000819e:	fc06                	sd	ra,56(sp)
    800081a0:	f822                	sd	s0,48(sp)
    800081a2:	0080                	addi	s0,sp,64
    800081a4:	fca43423          	sd	a0,-56(s0)
    800081a8:	87ae                	mv	a5,a1
    800081aa:	8736                	mv	a4,a3
    800081ac:	fcf41323          	sh	a5,-58(s0)
    800081b0:	87b2                	mv	a5,a2
    800081b2:	fcf41223          	sh	a5,-60(s0)
    800081b6:	87ba                	mv	a5,a4
    800081b8:	fcf41123          	sh	a5,-62(s0)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800081bc:	fd040793          	addi	a5,s0,-48
    800081c0:	85be                	mv	a1,a5
    800081c2:	fc843503          	ld	a0,-56(s0)
    800081c6:	ffffe097          	auipc	ra,0xffffe
    800081ca:	f7e080e7          	jalr	-130(ra) # 80006144 <nameiparent>
    800081ce:	fea43423          	sd	a0,-24(s0)
    800081d2:	fe843783          	ld	a5,-24(s0)
    800081d6:	e399                	bnez	a5,800081dc <create+0x40>
    return 0;
    800081d8:	4781                	li	a5,0
    800081da:	a2d9                	j	800083a0 <create+0x204>

  ilock(dp);
    800081dc:	fe843503          	ld	a0,-24(s0)
    800081e0:	ffffd097          	auipc	ra,0xffffd
    800081e4:	242080e7          	jalr	578(ra) # 80005422 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800081e8:	fd040793          	addi	a5,s0,-48
    800081ec:	4601                	li	a2,0
    800081ee:	85be                	mv	a1,a5
    800081f0:	fe843503          	ld	a0,-24(s0)
    800081f4:	ffffe097          	auipc	ra,0xffffe
    800081f8:	b22080e7          	jalr	-1246(ra) # 80005d16 <dirlookup>
    800081fc:	fea43023          	sd	a0,-32(s0)
    80008200:	fe043783          	ld	a5,-32(s0)
    80008204:	c3ad                	beqz	a5,80008266 <create+0xca>
    iunlockput(dp);
    80008206:	fe843503          	ld	a0,-24(s0)
    8000820a:	ffffd097          	auipc	ra,0xffffd
    8000820e:	476080e7          	jalr	1142(ra) # 80005680 <iunlockput>
    ilock(ip);
    80008212:	fe043503          	ld	a0,-32(s0)
    80008216:	ffffd097          	auipc	ra,0xffffd
    8000821a:	20c080e7          	jalr	524(ra) # 80005422 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    8000821e:	fc641783          	lh	a5,-58(s0)
    80008222:	0007871b          	sext.w	a4,a5
    80008226:	4789                	li	a5,2
    80008228:	02f71763          	bne	a4,a5,80008256 <create+0xba>
    8000822c:	fe043783          	ld	a5,-32(s0)
    80008230:	04479783          	lh	a5,68(a5)
    80008234:	0007871b          	sext.w	a4,a5
    80008238:	4789                	li	a5,2
    8000823a:	00f70b63          	beq	a4,a5,80008250 <create+0xb4>
    8000823e:	fe043783          	ld	a5,-32(s0)
    80008242:	04479783          	lh	a5,68(a5)
    80008246:	0007871b          	sext.w	a4,a5
    8000824a:	478d                	li	a5,3
    8000824c:	00f71563          	bne	a4,a5,80008256 <create+0xba>
      return ip;
    80008250:	fe043783          	ld	a5,-32(s0)
    80008254:	a2b1                	j	800083a0 <create+0x204>
    iunlockput(ip);
    80008256:	fe043503          	ld	a0,-32(s0)
    8000825a:	ffffd097          	auipc	ra,0xffffd
    8000825e:	426080e7          	jalr	1062(ra) # 80005680 <iunlockput>
    return 0;
    80008262:	4781                	li	a5,0
    80008264:	aa35                	j	800083a0 <create+0x204>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    80008266:	fe843783          	ld	a5,-24(s0)
    8000826a:	439c                	lw	a5,0(a5)
    8000826c:	fc641703          	lh	a4,-58(s0)
    80008270:	85ba                	mv	a1,a4
    80008272:	853e                	mv	a0,a5
    80008274:	ffffd097          	auipc	ra,0xffffd
    80008278:	e62080e7          	jalr	-414(ra) # 800050d6 <ialloc>
    8000827c:	fea43023          	sd	a0,-32(s0)
    80008280:	fe043783          	ld	a5,-32(s0)
    80008284:	eb89                	bnez	a5,80008296 <create+0xfa>
    panic("create: ialloc");
    80008286:	00003517          	auipc	a0,0x3
    8000828a:	3d250513          	addi	a0,a0,978 # 8000b658 <etext+0x658>
    8000828e:	ffff9097          	auipc	ra,0xffff9
    80008292:	9f0080e7          	jalr	-1552(ra) # 80000c7e <panic>

  ilock(ip);
    80008296:	fe043503          	ld	a0,-32(s0)
    8000829a:	ffffd097          	auipc	ra,0xffffd
    8000829e:	188080e7          	jalr	392(ra) # 80005422 <ilock>
  ip->major = major;
    800082a2:	fe043783          	ld	a5,-32(s0)
    800082a6:	fc445703          	lhu	a4,-60(s0)
    800082aa:	04e79323          	sh	a4,70(a5)
  ip->minor = minor;
    800082ae:	fe043783          	ld	a5,-32(s0)
    800082b2:	fc245703          	lhu	a4,-62(s0)
    800082b6:	04e79423          	sh	a4,72(a5)
  ip->nlink = 1;
    800082ba:	fe043783          	ld	a5,-32(s0)
    800082be:	4705                	li	a4,1
    800082c0:	04e79523          	sh	a4,74(a5)
  iupdate(ip);
    800082c4:	fe043503          	ld	a0,-32(s0)
    800082c8:	ffffd097          	auipc	ra,0xffffd
    800082cc:	f0a080e7          	jalr	-246(ra) # 800051d2 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
    800082d0:	fc641783          	lh	a5,-58(s0)
    800082d4:	0007871b          	sext.w	a4,a5
    800082d8:	4785                	li	a5,1
    800082da:	08f71363          	bne	a4,a5,80008360 <create+0x1c4>
    dp->nlink++;  // for ".."
    800082de:	fe843783          	ld	a5,-24(s0)
    800082e2:	04a79783          	lh	a5,74(a5)
    800082e6:	17c2                	slli	a5,a5,0x30
    800082e8:	93c1                	srli	a5,a5,0x30
    800082ea:	2785                	addiw	a5,a5,1
    800082ec:	17c2                	slli	a5,a5,0x30
    800082ee:	93c1                	srli	a5,a5,0x30
    800082f0:	0107971b          	slliw	a4,a5,0x10
    800082f4:	4107571b          	sraiw	a4,a4,0x10
    800082f8:	fe843783          	ld	a5,-24(s0)
    800082fc:	04e79523          	sh	a4,74(a5)
    iupdate(dp);
    80008300:	fe843503          	ld	a0,-24(s0)
    80008304:	ffffd097          	auipc	ra,0xffffd
    80008308:	ece080e7          	jalr	-306(ra) # 800051d2 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000830c:	fe043783          	ld	a5,-32(s0)
    80008310:	43dc                	lw	a5,4(a5)
    80008312:	863e                	mv	a2,a5
    80008314:	00003597          	auipc	a1,0x3
    80008318:	30c58593          	addi	a1,a1,780 # 8000b620 <etext+0x620>
    8000831c:	fe043503          	ld	a0,-32(s0)
    80008320:	ffffe097          	auipc	ra,0xffffe
    80008324:	ade080e7          	jalr	-1314(ra) # 80005dfe <dirlink>
    80008328:	87aa                	mv	a5,a0
    8000832a:	0207c363          	bltz	a5,80008350 <create+0x1b4>
    8000832e:	fe843783          	ld	a5,-24(s0)
    80008332:	43dc                	lw	a5,4(a5)
    80008334:	863e                	mv	a2,a5
    80008336:	00003597          	auipc	a1,0x3
    8000833a:	2f258593          	addi	a1,a1,754 # 8000b628 <etext+0x628>
    8000833e:	fe043503          	ld	a0,-32(s0)
    80008342:	ffffe097          	auipc	ra,0xffffe
    80008346:	abc080e7          	jalr	-1348(ra) # 80005dfe <dirlink>
    8000834a:	87aa                	mv	a5,a0
    8000834c:	0007da63          	bgez	a5,80008360 <create+0x1c4>
      panic("create dots");
    80008350:	00003517          	auipc	a0,0x3
    80008354:	31850513          	addi	a0,a0,792 # 8000b668 <etext+0x668>
    80008358:	ffff9097          	auipc	ra,0xffff9
    8000835c:	926080e7          	jalr	-1754(ra) # 80000c7e <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    80008360:	fe043783          	ld	a5,-32(s0)
    80008364:	43d8                	lw	a4,4(a5)
    80008366:	fd040793          	addi	a5,s0,-48
    8000836a:	863a                	mv	a2,a4
    8000836c:	85be                	mv	a1,a5
    8000836e:	fe843503          	ld	a0,-24(s0)
    80008372:	ffffe097          	auipc	ra,0xffffe
    80008376:	a8c080e7          	jalr	-1396(ra) # 80005dfe <dirlink>
    8000837a:	87aa                	mv	a5,a0
    8000837c:	0007da63          	bgez	a5,80008390 <create+0x1f4>
    panic("create: dirlink");
    80008380:	00003517          	auipc	a0,0x3
    80008384:	2f850513          	addi	a0,a0,760 # 8000b678 <etext+0x678>
    80008388:	ffff9097          	auipc	ra,0xffff9
    8000838c:	8f6080e7          	jalr	-1802(ra) # 80000c7e <panic>

  iunlockput(dp);
    80008390:	fe843503          	ld	a0,-24(s0)
    80008394:	ffffd097          	auipc	ra,0xffffd
    80008398:	2ec080e7          	jalr	748(ra) # 80005680 <iunlockput>

  return ip;
    8000839c:	fe043783          	ld	a5,-32(s0)
}
    800083a0:	853e                	mv	a0,a5
    800083a2:	70e2                	ld	ra,56(sp)
    800083a4:	7442                	ld	s0,48(sp)
    800083a6:	6121                	addi	sp,sp,64
    800083a8:	8082                	ret

00000000800083aa <sys_open>:

uint64
sys_open(void)
{
    800083aa:	7131                	addi	sp,sp,-192
    800083ac:	fd06                	sd	ra,184(sp)
    800083ae:	f922                	sd	s0,176(sp)
    800083b0:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800083b2:	f5040793          	addi	a5,s0,-176
    800083b6:	08000613          	li	a2,128
    800083ba:	85be                	mv	a1,a5
    800083bc:	4501                	li	a0,0
    800083be:	ffffc097          	auipc	ra,0xffffc
    800083c2:	064080e7          	jalr	100(ra) # 80004422 <argstr>
    800083c6:	87aa                	mv	a5,a0
    800083c8:	fef42223          	sw	a5,-28(s0)
    800083cc:	fe442783          	lw	a5,-28(s0)
    800083d0:	2781                	sext.w	a5,a5
    800083d2:	0007cd63          	bltz	a5,800083ec <sys_open+0x42>
    800083d6:	f4c40793          	addi	a5,s0,-180
    800083da:	85be                	mv	a1,a5
    800083dc:	4505                	li	a0,1
    800083de:	ffffc097          	auipc	ra,0xffffc
    800083e2:	fd8080e7          	jalr	-40(ra) # 800043b6 <argint>
    800083e6:	87aa                	mv	a5,a0
    800083e8:	0007d463          	bgez	a5,800083f0 <sys_open+0x46>
    return -1;
    800083ec:	57fd                	li	a5,-1
    800083ee:	a429                	j	800085f8 <sys_open+0x24e>

  begin_op();
    800083f0:	ffffe097          	auipc	ra,0xffffe
    800083f4:	08c080e7          	jalr	140(ra) # 8000647c <begin_op>

  if(omode & O_CREATE){
    800083f8:	f4c42783          	lw	a5,-180(s0)
    800083fc:	2007f793          	andi	a5,a5,512
    80008400:	2781                	sext.w	a5,a5
    80008402:	c795                	beqz	a5,8000842e <sys_open+0x84>
    ip = create(path, T_FILE, 0, 0);
    80008404:	f5040793          	addi	a5,s0,-176
    80008408:	4681                	li	a3,0
    8000840a:	4601                	li	a2,0
    8000840c:	4589                	li	a1,2
    8000840e:	853e                	mv	a0,a5
    80008410:	00000097          	auipc	ra,0x0
    80008414:	d8c080e7          	jalr	-628(ra) # 8000819c <create>
    80008418:	fea43423          	sd	a0,-24(s0)
    if(ip == 0){
    8000841c:	fe843783          	ld	a5,-24(s0)
    80008420:	e7bd                	bnez	a5,8000848e <sys_open+0xe4>
      end_op();
    80008422:	ffffe097          	auipc	ra,0xffffe
    80008426:	11c080e7          	jalr	284(ra) # 8000653e <end_op>
      return -1;
    8000842a:	57fd                	li	a5,-1
    8000842c:	a2f1                	j	800085f8 <sys_open+0x24e>
    }
  } else {
    if((ip = namei(path)) == 0){
    8000842e:	f5040793          	addi	a5,s0,-176
    80008432:	853e                	mv	a0,a5
    80008434:	ffffe097          	auipc	ra,0xffffe
    80008438:	ce4080e7          	jalr	-796(ra) # 80006118 <namei>
    8000843c:	fea43423          	sd	a0,-24(s0)
    80008440:	fe843783          	ld	a5,-24(s0)
    80008444:	e799                	bnez	a5,80008452 <sys_open+0xa8>
      end_op();
    80008446:	ffffe097          	auipc	ra,0xffffe
    8000844a:	0f8080e7          	jalr	248(ra) # 8000653e <end_op>
      return -1;
    8000844e:	57fd                	li	a5,-1
    80008450:	a265                	j	800085f8 <sys_open+0x24e>
    }
    ilock(ip);
    80008452:	fe843503          	ld	a0,-24(s0)
    80008456:	ffffd097          	auipc	ra,0xffffd
    8000845a:	fcc080e7          	jalr	-52(ra) # 80005422 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000845e:	fe843783          	ld	a5,-24(s0)
    80008462:	04479783          	lh	a5,68(a5)
    80008466:	0007871b          	sext.w	a4,a5
    8000846a:	4785                	li	a5,1
    8000846c:	02f71163          	bne	a4,a5,8000848e <sys_open+0xe4>
    80008470:	f4c42783          	lw	a5,-180(s0)
    80008474:	cf89                	beqz	a5,8000848e <sys_open+0xe4>
      iunlockput(ip);
    80008476:	fe843503          	ld	a0,-24(s0)
    8000847a:	ffffd097          	auipc	ra,0xffffd
    8000847e:	206080e7          	jalr	518(ra) # 80005680 <iunlockput>
      end_op();
    80008482:	ffffe097          	auipc	ra,0xffffe
    80008486:	0bc080e7          	jalr	188(ra) # 8000653e <end_op>
      return -1;
    8000848a:	57fd                	li	a5,-1
    8000848c:	a2b5                	j	800085f8 <sys_open+0x24e>
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    8000848e:	fe843783          	ld	a5,-24(s0)
    80008492:	04479783          	lh	a5,68(a5)
    80008496:	0007871b          	sext.w	a4,a5
    8000849a:	478d                	li	a5,3
    8000849c:	02f71e63          	bne	a4,a5,800084d8 <sys_open+0x12e>
    800084a0:	fe843783          	ld	a5,-24(s0)
    800084a4:	04679783          	lh	a5,70(a5)
    800084a8:	2781                	sext.w	a5,a5
    800084aa:	0007cb63          	bltz	a5,800084c0 <sys_open+0x116>
    800084ae:	fe843783          	ld	a5,-24(s0)
    800084b2:	04679783          	lh	a5,70(a5)
    800084b6:	0007871b          	sext.w	a4,a5
    800084ba:	47a5                	li	a5,9
    800084bc:	00e7de63          	bge	a5,a4,800084d8 <sys_open+0x12e>
    iunlockput(ip);
    800084c0:	fe843503          	ld	a0,-24(s0)
    800084c4:	ffffd097          	auipc	ra,0xffffd
    800084c8:	1bc080e7          	jalr	444(ra) # 80005680 <iunlockput>
    end_op();
    800084cc:	ffffe097          	auipc	ra,0xffffe
    800084d0:	072080e7          	jalr	114(ra) # 8000653e <end_op>
    return -1;
    800084d4:	57fd                	li	a5,-1
    800084d6:	a20d                	j	800085f8 <sys_open+0x24e>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800084d8:	ffffe097          	auipc	ra,0xffffe
    800084dc:	554080e7          	jalr	1364(ra) # 80006a2c <filealloc>
    800084e0:	fca43c23          	sd	a0,-40(s0)
    800084e4:	fd843783          	ld	a5,-40(s0)
    800084e8:	cf99                	beqz	a5,80008506 <sys_open+0x15c>
    800084ea:	fd843503          	ld	a0,-40(s0)
    800084ee:	fffff097          	auipc	ra,0xfffff
    800084f2:	5e8080e7          	jalr	1512(ra) # 80007ad6 <fdalloc>
    800084f6:	87aa                	mv	a5,a0
    800084f8:	fcf42a23          	sw	a5,-44(s0)
    800084fc:	fd442783          	lw	a5,-44(s0)
    80008500:	2781                	sext.w	a5,a5
    80008502:	0207d763          	bgez	a5,80008530 <sys_open+0x186>
    if(f)
    80008506:	fd843783          	ld	a5,-40(s0)
    8000850a:	c799                	beqz	a5,80008518 <sys_open+0x16e>
      fileclose(f);
    8000850c:	fd843503          	ld	a0,-40(s0)
    80008510:	ffffe097          	auipc	ra,0xffffe
    80008514:	606080e7          	jalr	1542(ra) # 80006b16 <fileclose>
    iunlockput(ip);
    80008518:	fe843503          	ld	a0,-24(s0)
    8000851c:	ffffd097          	auipc	ra,0xffffd
    80008520:	164080e7          	jalr	356(ra) # 80005680 <iunlockput>
    end_op();
    80008524:	ffffe097          	auipc	ra,0xffffe
    80008528:	01a080e7          	jalr	26(ra) # 8000653e <end_op>
    return -1;
    8000852c:	57fd                	li	a5,-1
    8000852e:	a0e9                	j	800085f8 <sys_open+0x24e>
  }

  if(ip->type == T_DEVICE){
    80008530:	fe843783          	ld	a5,-24(s0)
    80008534:	04479783          	lh	a5,68(a5)
    80008538:	0007871b          	sext.w	a4,a5
    8000853c:	478d                	li	a5,3
    8000853e:	00f71f63          	bne	a4,a5,8000855c <sys_open+0x1b2>
    f->type = FD_DEVICE;
    80008542:	fd843783          	ld	a5,-40(s0)
    80008546:	470d                	li	a4,3
    80008548:	c398                	sw	a4,0(a5)
    f->major = ip->major;
    8000854a:	fe843783          	ld	a5,-24(s0)
    8000854e:	04679703          	lh	a4,70(a5)
    80008552:	fd843783          	ld	a5,-40(s0)
    80008556:	02e79223          	sh	a4,36(a5)
    8000855a:	a809                	j	8000856c <sys_open+0x1c2>
  } else {
    f->type = FD_INODE;
    8000855c:	fd843783          	ld	a5,-40(s0)
    80008560:	4709                	li	a4,2
    80008562:	c398                	sw	a4,0(a5)
    f->off = 0;
    80008564:	fd843783          	ld	a5,-40(s0)
    80008568:	0207a023          	sw	zero,32(a5)
  }
  f->ip = ip;
    8000856c:	fd843783          	ld	a5,-40(s0)
    80008570:	fe843703          	ld	a4,-24(s0)
    80008574:	ef98                	sd	a4,24(a5)
  f->readable = !(omode & O_WRONLY);
    80008576:	f4c42783          	lw	a5,-180(s0)
    8000857a:	8b85                	andi	a5,a5,1
    8000857c:	2781                	sext.w	a5,a5
    8000857e:	0017b793          	seqz	a5,a5
    80008582:	0ff7f793          	andi	a5,a5,255
    80008586:	873e                	mv	a4,a5
    80008588:	fd843783          	ld	a5,-40(s0)
    8000858c:	00e78423          	sb	a4,8(a5)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80008590:	f4c42783          	lw	a5,-180(s0)
    80008594:	8b85                	andi	a5,a5,1
    80008596:	2781                	sext.w	a5,a5
    80008598:	e791                	bnez	a5,800085a4 <sys_open+0x1fa>
    8000859a:	f4c42783          	lw	a5,-180(s0)
    8000859e:	8b89                	andi	a5,a5,2
    800085a0:	2781                	sext.w	a5,a5
    800085a2:	c399                	beqz	a5,800085a8 <sys_open+0x1fe>
    800085a4:	4785                	li	a5,1
    800085a6:	a011                	j	800085aa <sys_open+0x200>
    800085a8:	4781                	li	a5,0
    800085aa:	0ff7f713          	andi	a4,a5,255
    800085ae:	fd843783          	ld	a5,-40(s0)
    800085b2:	00e784a3          	sb	a4,9(a5)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    800085b6:	f4c42783          	lw	a5,-180(s0)
    800085ba:	4007f793          	andi	a5,a5,1024
    800085be:	2781                	sext.w	a5,a5
    800085c0:	c385                	beqz	a5,800085e0 <sys_open+0x236>
    800085c2:	fe843783          	ld	a5,-24(s0)
    800085c6:	04479783          	lh	a5,68(a5)
    800085ca:	0007871b          	sext.w	a4,a5
    800085ce:	4789                	li	a5,2
    800085d0:	00f71863          	bne	a4,a5,800085e0 <sys_open+0x236>
    itrunc(ip);
    800085d4:	fe843503          	ld	a0,-24(s0)
    800085d8:	ffffd097          	auipc	ra,0xffffd
    800085dc:	232080e7          	jalr	562(ra) # 8000580a <itrunc>
  }

  iunlock(ip);
    800085e0:	fe843503          	ld	a0,-24(s0)
    800085e4:	ffffd097          	auipc	ra,0xffffd
    800085e8:	f72080e7          	jalr	-142(ra) # 80005556 <iunlock>
  end_op();
    800085ec:	ffffe097          	auipc	ra,0xffffe
    800085f0:	f52080e7          	jalr	-174(ra) # 8000653e <end_op>

  return fd;
    800085f4:	fd442783          	lw	a5,-44(s0)
}
    800085f8:	853e                	mv	a0,a5
    800085fa:	70ea                	ld	ra,184(sp)
    800085fc:	744a                	ld	s0,176(sp)
    800085fe:	6129                	addi	sp,sp,192
    80008600:	8082                	ret

0000000080008602 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80008602:	7135                	addi	sp,sp,-160
    80008604:	ed06                	sd	ra,152(sp)
    80008606:	e922                	sd	s0,144(sp)
    80008608:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    8000860a:	ffffe097          	auipc	ra,0xffffe
    8000860e:	e72080e7          	jalr	-398(ra) # 8000647c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80008612:	f6840793          	addi	a5,s0,-152
    80008616:	08000613          	li	a2,128
    8000861a:	85be                	mv	a1,a5
    8000861c:	4501                	li	a0,0
    8000861e:	ffffc097          	auipc	ra,0xffffc
    80008622:	e04080e7          	jalr	-508(ra) # 80004422 <argstr>
    80008626:	87aa                	mv	a5,a0
    80008628:	0207c163          	bltz	a5,8000864a <sys_mkdir+0x48>
    8000862c:	f6840793          	addi	a5,s0,-152
    80008630:	4681                	li	a3,0
    80008632:	4601                	li	a2,0
    80008634:	4585                	li	a1,1
    80008636:	853e                	mv	a0,a5
    80008638:	00000097          	auipc	ra,0x0
    8000863c:	b64080e7          	jalr	-1180(ra) # 8000819c <create>
    80008640:	fea43423          	sd	a0,-24(s0)
    80008644:	fe843783          	ld	a5,-24(s0)
    80008648:	e799                	bnez	a5,80008656 <sys_mkdir+0x54>
    end_op();
    8000864a:	ffffe097          	auipc	ra,0xffffe
    8000864e:	ef4080e7          	jalr	-268(ra) # 8000653e <end_op>
    return -1;
    80008652:	57fd                	li	a5,-1
    80008654:	a821                	j	8000866c <sys_mkdir+0x6a>
  }
  iunlockput(ip);
    80008656:	fe843503          	ld	a0,-24(s0)
    8000865a:	ffffd097          	auipc	ra,0xffffd
    8000865e:	026080e7          	jalr	38(ra) # 80005680 <iunlockput>
  end_op();
    80008662:	ffffe097          	auipc	ra,0xffffe
    80008666:	edc080e7          	jalr	-292(ra) # 8000653e <end_op>
  return 0;
    8000866a:	4781                	li	a5,0
}
    8000866c:	853e                	mv	a0,a5
    8000866e:	60ea                	ld	ra,152(sp)
    80008670:	644a                	ld	s0,144(sp)
    80008672:	610d                	addi	sp,sp,160
    80008674:	8082                	ret

0000000080008676 <sys_mknod>:

uint64
sys_mknod(void)
{
    80008676:	7135                	addi	sp,sp,-160
    80008678:	ed06                	sd	ra,152(sp)
    8000867a:	e922                	sd	s0,144(sp)
    8000867c:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    8000867e:	ffffe097          	auipc	ra,0xffffe
    80008682:	dfe080e7          	jalr	-514(ra) # 8000647c <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80008686:	f6840793          	addi	a5,s0,-152
    8000868a:	08000613          	li	a2,128
    8000868e:	85be                	mv	a1,a5
    80008690:	4501                	li	a0,0
    80008692:	ffffc097          	auipc	ra,0xffffc
    80008696:	d90080e7          	jalr	-624(ra) # 80004422 <argstr>
    8000869a:	87aa                	mv	a5,a0
    8000869c:	0607c263          	bltz	a5,80008700 <sys_mknod+0x8a>
     argint(1, &major) < 0 ||
    800086a0:	f6440793          	addi	a5,s0,-156
    800086a4:	85be                	mv	a1,a5
    800086a6:	4505                	li	a0,1
    800086a8:	ffffc097          	auipc	ra,0xffffc
    800086ac:	d0e080e7          	jalr	-754(ra) # 800043b6 <argint>
    800086b0:	87aa                	mv	a5,a0
  if((argstr(0, path, MAXPATH)) < 0 ||
    800086b2:	0407c763          	bltz	a5,80008700 <sys_mknod+0x8a>
     argint(2, &minor) < 0 ||
    800086b6:	f6040793          	addi	a5,s0,-160
    800086ba:	85be                	mv	a1,a5
    800086bc:	4509                	li	a0,2
    800086be:	ffffc097          	auipc	ra,0xffffc
    800086c2:	cf8080e7          	jalr	-776(ra) # 800043b6 <argint>
    800086c6:	87aa                	mv	a5,a0
     argint(1, &major) < 0 ||
    800086c8:	0207cc63          	bltz	a5,80008700 <sys_mknod+0x8a>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800086cc:	f6442783          	lw	a5,-156(s0)
    800086d0:	0107971b          	slliw	a4,a5,0x10
    800086d4:	4107571b          	sraiw	a4,a4,0x10
    800086d8:	f6042783          	lw	a5,-160(s0)
    800086dc:	0107969b          	slliw	a3,a5,0x10
    800086e0:	4106d69b          	sraiw	a3,a3,0x10
    800086e4:	f6840793          	addi	a5,s0,-152
    800086e8:	863a                	mv	a2,a4
    800086ea:	458d                	li	a1,3
    800086ec:	853e                	mv	a0,a5
    800086ee:	00000097          	auipc	ra,0x0
    800086f2:	aae080e7          	jalr	-1362(ra) # 8000819c <create>
    800086f6:	fea43423          	sd	a0,-24(s0)
     argint(2, &minor) < 0 ||
    800086fa:	fe843783          	ld	a5,-24(s0)
    800086fe:	e799                	bnez	a5,8000870c <sys_mknod+0x96>
    end_op();
    80008700:	ffffe097          	auipc	ra,0xffffe
    80008704:	e3e080e7          	jalr	-450(ra) # 8000653e <end_op>
    return -1;
    80008708:	57fd                	li	a5,-1
    8000870a:	a821                	j	80008722 <sys_mknod+0xac>
  }
  iunlockput(ip);
    8000870c:	fe843503          	ld	a0,-24(s0)
    80008710:	ffffd097          	auipc	ra,0xffffd
    80008714:	f70080e7          	jalr	-144(ra) # 80005680 <iunlockput>
  end_op();
    80008718:	ffffe097          	auipc	ra,0xffffe
    8000871c:	e26080e7          	jalr	-474(ra) # 8000653e <end_op>
  return 0;
    80008720:	4781                	li	a5,0
}
    80008722:	853e                	mv	a0,a5
    80008724:	60ea                	ld	ra,152(sp)
    80008726:	644a                	ld	s0,144(sp)
    80008728:	610d                	addi	sp,sp,160
    8000872a:	8082                	ret

000000008000872c <sys_chdir>:

uint64
sys_chdir(void)
{
    8000872c:	7135                	addi	sp,sp,-160
    8000872e:	ed06                	sd	ra,152(sp)
    80008730:	e922                	sd	s0,144(sp)
    80008732:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80008734:	ffffa097          	auipc	ra,0xffffa
    80008738:	0e0080e7          	jalr	224(ra) # 80002814 <myproc>
    8000873c:	fea43423          	sd	a0,-24(s0)
  
  begin_op();
    80008740:	ffffe097          	auipc	ra,0xffffe
    80008744:	d3c080e7          	jalr	-708(ra) # 8000647c <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80008748:	f6040793          	addi	a5,s0,-160
    8000874c:	08000613          	li	a2,128
    80008750:	85be                	mv	a1,a5
    80008752:	4501                	li	a0,0
    80008754:	ffffc097          	auipc	ra,0xffffc
    80008758:	cce080e7          	jalr	-818(ra) # 80004422 <argstr>
    8000875c:	87aa                	mv	a5,a0
    8000875e:	0007ce63          	bltz	a5,8000877a <sys_chdir+0x4e>
    80008762:	f6040793          	addi	a5,s0,-160
    80008766:	853e                	mv	a0,a5
    80008768:	ffffe097          	auipc	ra,0xffffe
    8000876c:	9b0080e7          	jalr	-1616(ra) # 80006118 <namei>
    80008770:	fea43023          	sd	a0,-32(s0)
    80008774:	fe043783          	ld	a5,-32(s0)
    80008778:	e799                	bnez	a5,80008786 <sys_chdir+0x5a>
    end_op();
    8000877a:	ffffe097          	auipc	ra,0xffffe
    8000877e:	dc4080e7          	jalr	-572(ra) # 8000653e <end_op>
    return -1;
    80008782:	57fd                	li	a5,-1
    80008784:	a0b5                	j	800087f0 <sys_chdir+0xc4>
  }
  ilock(ip);
    80008786:	fe043503          	ld	a0,-32(s0)
    8000878a:	ffffd097          	auipc	ra,0xffffd
    8000878e:	c98080e7          	jalr	-872(ra) # 80005422 <ilock>
  if(ip->type != T_DIR){
    80008792:	fe043783          	ld	a5,-32(s0)
    80008796:	04479783          	lh	a5,68(a5)
    8000879a:	0007871b          	sext.w	a4,a5
    8000879e:	4785                	li	a5,1
    800087a0:	00f70e63          	beq	a4,a5,800087bc <sys_chdir+0x90>
    iunlockput(ip);
    800087a4:	fe043503          	ld	a0,-32(s0)
    800087a8:	ffffd097          	auipc	ra,0xffffd
    800087ac:	ed8080e7          	jalr	-296(ra) # 80005680 <iunlockput>
    end_op();
    800087b0:	ffffe097          	auipc	ra,0xffffe
    800087b4:	d8e080e7          	jalr	-626(ra) # 8000653e <end_op>
    return -1;
    800087b8:	57fd                	li	a5,-1
    800087ba:	a81d                	j	800087f0 <sys_chdir+0xc4>
  }
  iunlock(ip);
    800087bc:	fe043503          	ld	a0,-32(s0)
    800087c0:	ffffd097          	auipc	ra,0xffffd
    800087c4:	d96080e7          	jalr	-618(ra) # 80005556 <iunlock>
  iput(p->cwd);
    800087c8:	fe843783          	ld	a5,-24(s0)
    800087cc:	1587b783          	ld	a5,344(a5)
    800087d0:	853e                	mv	a0,a5
    800087d2:	ffffd097          	auipc	ra,0xffffd
    800087d6:	dde080e7          	jalr	-546(ra) # 800055b0 <iput>
  end_op();
    800087da:	ffffe097          	auipc	ra,0xffffe
    800087de:	d64080e7          	jalr	-668(ra) # 8000653e <end_op>
  p->cwd = ip;
    800087e2:	fe843783          	ld	a5,-24(s0)
    800087e6:	fe043703          	ld	a4,-32(s0)
    800087ea:	14e7bc23          	sd	a4,344(a5)
  return 0;
    800087ee:	4781                	li	a5,0
}
    800087f0:	853e                	mv	a0,a5
    800087f2:	60ea                	ld	ra,152(sp)
    800087f4:	644a                	ld	s0,144(sp)
    800087f6:	610d                	addi	sp,sp,160
    800087f8:	8082                	ret

00000000800087fa <sys_exec>:

uint64
sys_exec(void)
{
    800087fa:	7161                	addi	sp,sp,-432
    800087fc:	f706                	sd	ra,424(sp)
    800087fe:	f322                	sd	s0,416(sp)
    80008800:	1b00                	addi	s0,sp,432
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80008802:	f6840793          	addi	a5,s0,-152
    80008806:	08000613          	li	a2,128
    8000880a:	85be                	mv	a1,a5
    8000880c:	4501                	li	a0,0
    8000880e:	ffffc097          	auipc	ra,0xffffc
    80008812:	c14080e7          	jalr	-1004(ra) # 80004422 <argstr>
    80008816:	87aa                	mv	a5,a0
    80008818:	0007cd63          	bltz	a5,80008832 <sys_exec+0x38>
    8000881c:	e6040793          	addi	a5,s0,-416
    80008820:	85be                	mv	a1,a5
    80008822:	4505                	li	a0,1
    80008824:	ffffc097          	auipc	ra,0xffffc
    80008828:	bca080e7          	jalr	-1078(ra) # 800043ee <argaddr>
    8000882c:	87aa                	mv	a5,a0
    8000882e:	0007d463          	bgez	a5,80008836 <sys_exec+0x3c>
    return -1;
    80008832:	57fd                	li	a5,-1
    80008834:	a249                	j	800089b6 <sys_exec+0x1bc>
  }
  memset(argv, 0, sizeof(argv));
    80008836:	e6840793          	addi	a5,s0,-408
    8000883a:	10000613          	li	a2,256
    8000883e:	4581                	li	a1,0
    80008840:	853e                	mv	a0,a5
    80008842:	ffff9097          	auipc	ra,0xffff9
    80008846:	c00080e7          	jalr	-1024(ra) # 80001442 <memset>
  for(i=0;; i++){
    8000884a:	fe042623          	sw	zero,-20(s0)
    if(i >= NELEM(argv)){
    8000884e:	fec42783          	lw	a5,-20(s0)
    80008852:	873e                	mv	a4,a5
    80008854:	47fd                	li	a5,31
    80008856:	10e7e463          	bltu	a5,a4,8000895e <sys_exec+0x164>
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000885a:	fec42783          	lw	a5,-20(s0)
    8000885e:	00379713          	slli	a4,a5,0x3
    80008862:	e6043783          	ld	a5,-416(s0)
    80008866:	97ba                	add	a5,a5,a4
    80008868:	e5840713          	addi	a4,s0,-424
    8000886c:	85ba                	mv	a1,a4
    8000886e:	853e                	mv	a0,a5
    80008870:	ffffc097          	auipc	ra,0xffffc
    80008874:	9c8080e7          	jalr	-1592(ra) # 80004238 <fetchaddr>
    80008878:	87aa                	mv	a5,a0
    8000887a:	0e07c463          	bltz	a5,80008962 <sys_exec+0x168>
      goto bad;
    }
    if(uarg == 0){
    8000887e:	e5843783          	ld	a5,-424(s0)
    80008882:	eb95                	bnez	a5,800088b6 <sys_exec+0xbc>
      argv[i] = 0;
    80008884:	fec42783          	lw	a5,-20(s0)
    80008888:	078e                	slli	a5,a5,0x3
    8000888a:	ff040713          	addi	a4,s0,-16
    8000888e:	97ba                	add	a5,a5,a4
    80008890:	e607bc23          	sd	zero,-392(a5)
      break;
    80008894:	0001                	nop
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
      goto bad;
  }

  int ret = exec(path, argv);
    80008896:	e6840713          	addi	a4,s0,-408
    8000889a:	f6840793          	addi	a5,s0,-152
    8000889e:	85ba                	mv	a1,a4
    800088a0:	853e                	mv	a0,a5
    800088a2:	fffff097          	auipc	ra,0xfffff
    800088a6:	c1a080e7          	jalr	-998(ra) # 800074bc <exec>
    800088aa:	87aa                	mv	a5,a0
    800088ac:	fef42423          	sw	a5,-24(s0)

  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800088b0:	fe042623          	sw	zero,-20(s0)
    800088b4:	a059                	j	8000893a <sys_exec+0x140>
    argv[i] = kalloc();
    800088b6:	ffff9097          	auipc	ra,0xffff9
    800088ba:	864080e7          	jalr	-1948(ra) # 8000111a <kalloc>
    800088be:	872a                	mv	a4,a0
    800088c0:	fec42783          	lw	a5,-20(s0)
    800088c4:	078e                	slli	a5,a5,0x3
    800088c6:	ff040693          	addi	a3,s0,-16
    800088ca:	97b6                	add	a5,a5,a3
    800088cc:	e6e7bc23          	sd	a4,-392(a5)
    if(argv[i] == 0)
    800088d0:	fec42783          	lw	a5,-20(s0)
    800088d4:	078e                	slli	a5,a5,0x3
    800088d6:	ff040713          	addi	a4,s0,-16
    800088da:	97ba                	add	a5,a5,a4
    800088dc:	e787b783          	ld	a5,-392(a5)
    800088e0:	c3d9                	beqz	a5,80008966 <sys_exec+0x16c>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800088e2:	e5843703          	ld	a4,-424(s0)
    800088e6:	fec42783          	lw	a5,-20(s0)
    800088ea:	078e                	slli	a5,a5,0x3
    800088ec:	ff040693          	addi	a3,s0,-16
    800088f0:	97b6                	add	a5,a5,a3
    800088f2:	e787b783          	ld	a5,-392(a5)
    800088f6:	6605                	lui	a2,0x1
    800088f8:	85be                	mv	a1,a5
    800088fa:	853a                	mv	a0,a4
    800088fc:	ffffc097          	auipc	ra,0xffffc
    80008900:	9aa080e7          	jalr	-1622(ra) # 800042a6 <fetchstr>
    80008904:	87aa                	mv	a5,a0
    80008906:	0607c263          	bltz	a5,8000896a <sys_exec+0x170>
  for(i=0;; i++){
    8000890a:	fec42783          	lw	a5,-20(s0)
    8000890e:	2785                	addiw	a5,a5,1
    80008910:	fef42623          	sw	a5,-20(s0)
    if(i >= NELEM(argv)){
    80008914:	bf2d                	j	8000884e <sys_exec+0x54>
    kfree(argv[i]);
    80008916:	fec42783          	lw	a5,-20(s0)
    8000891a:	078e                	slli	a5,a5,0x3
    8000891c:	ff040713          	addi	a4,s0,-16
    80008920:	97ba                	add	a5,a5,a4
    80008922:	e787b783          	ld	a5,-392(a5)
    80008926:	853e                	mv	a0,a5
    80008928:	ffff8097          	auipc	ra,0xffff8
    8000892c:	74e080e7          	jalr	1870(ra) # 80001076 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80008930:	fec42783          	lw	a5,-20(s0)
    80008934:	2785                	addiw	a5,a5,1
    80008936:	fef42623          	sw	a5,-20(s0)
    8000893a:	fec42783          	lw	a5,-20(s0)
    8000893e:	873e                	mv	a4,a5
    80008940:	47fd                	li	a5,31
    80008942:	00e7eb63          	bltu	a5,a4,80008958 <sys_exec+0x15e>
    80008946:	fec42783          	lw	a5,-20(s0)
    8000894a:	078e                	slli	a5,a5,0x3
    8000894c:	ff040713          	addi	a4,s0,-16
    80008950:	97ba                	add	a5,a5,a4
    80008952:	e787b783          	ld	a5,-392(a5)
    80008956:	f3e1                	bnez	a5,80008916 <sys_exec+0x11c>

  return ret;
    80008958:	fe842783          	lw	a5,-24(s0)
    8000895c:	a8a9                	j	800089b6 <sys_exec+0x1bc>
      goto bad;
    8000895e:	0001                	nop
    80008960:	a031                	j	8000896c <sys_exec+0x172>
      goto bad;
    80008962:	0001                	nop
    80008964:	a021                	j	8000896c <sys_exec+0x172>
      goto bad;
    80008966:	0001                	nop
    80008968:	a011                	j	8000896c <sys_exec+0x172>
      goto bad;
    8000896a:	0001                	nop

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000896c:	fe042623          	sw	zero,-20(s0)
    80008970:	a01d                	j	80008996 <sys_exec+0x19c>
    kfree(argv[i]);
    80008972:	fec42783          	lw	a5,-20(s0)
    80008976:	078e                	slli	a5,a5,0x3
    80008978:	ff040713          	addi	a4,s0,-16
    8000897c:	97ba                	add	a5,a5,a4
    8000897e:	e787b783          	ld	a5,-392(a5)
    80008982:	853e                	mv	a0,a5
    80008984:	ffff8097          	auipc	ra,0xffff8
    80008988:	6f2080e7          	jalr	1778(ra) # 80001076 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000898c:	fec42783          	lw	a5,-20(s0)
    80008990:	2785                	addiw	a5,a5,1
    80008992:	fef42623          	sw	a5,-20(s0)
    80008996:	fec42783          	lw	a5,-20(s0)
    8000899a:	873e                	mv	a4,a5
    8000899c:	47fd                	li	a5,31
    8000899e:	00e7eb63          	bltu	a5,a4,800089b4 <sys_exec+0x1ba>
    800089a2:	fec42783          	lw	a5,-20(s0)
    800089a6:	078e                	slli	a5,a5,0x3
    800089a8:	ff040713          	addi	a4,s0,-16
    800089ac:	97ba                	add	a5,a5,a4
    800089ae:	e787b783          	ld	a5,-392(a5)
    800089b2:	f3e1                	bnez	a5,80008972 <sys_exec+0x178>
  return -1;
    800089b4:	57fd                	li	a5,-1
}
    800089b6:	853e                	mv	a0,a5
    800089b8:	70ba                	ld	ra,424(sp)
    800089ba:	741a                	ld	s0,416(sp)
    800089bc:	615d                	addi	sp,sp,432
    800089be:	8082                	ret

00000000800089c0 <sys_pipe>:

uint64
sys_pipe(void)
{
    800089c0:	7139                	addi	sp,sp,-64
    800089c2:	fc06                	sd	ra,56(sp)
    800089c4:	f822                	sd	s0,48(sp)
    800089c6:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800089c8:	ffffa097          	auipc	ra,0xffffa
    800089cc:	e4c080e7          	jalr	-436(ra) # 80002814 <myproc>
    800089d0:	fea43423          	sd	a0,-24(s0)

  if(argaddr(0, &fdarray) < 0)
    800089d4:	fe040793          	addi	a5,s0,-32
    800089d8:	85be                	mv	a1,a5
    800089da:	4501                	li	a0,0
    800089dc:	ffffc097          	auipc	ra,0xffffc
    800089e0:	a12080e7          	jalr	-1518(ra) # 800043ee <argaddr>
    800089e4:	87aa                	mv	a5,a0
    800089e6:	0007d463          	bgez	a5,800089ee <sys_pipe+0x2e>
    return -1;
    800089ea:	57fd                	li	a5,-1
    800089ec:	a215                	j	80008b10 <sys_pipe+0x150>
  if(pipealloc(&rf, &wf) < 0)
    800089ee:	fd040713          	addi	a4,s0,-48
    800089f2:	fd840793          	addi	a5,s0,-40
    800089f6:	85ba                	mv	a1,a4
    800089f8:	853e                	mv	a0,a5
    800089fa:	ffffe097          	auipc	ra,0xffffe
    800089fe:	632080e7          	jalr	1586(ra) # 8000702c <pipealloc>
    80008a02:	87aa                	mv	a5,a0
    80008a04:	0007d463          	bgez	a5,80008a0c <sys_pipe+0x4c>
    return -1;
    80008a08:	57fd                	li	a5,-1
    80008a0a:	a219                	j	80008b10 <sys_pipe+0x150>
  fd0 = -1;
    80008a0c:	57fd                	li	a5,-1
    80008a0e:	fcf42623          	sw	a5,-52(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80008a12:	fd843783          	ld	a5,-40(s0)
    80008a16:	853e                	mv	a0,a5
    80008a18:	fffff097          	auipc	ra,0xfffff
    80008a1c:	0be080e7          	jalr	190(ra) # 80007ad6 <fdalloc>
    80008a20:	87aa                	mv	a5,a0
    80008a22:	fcf42623          	sw	a5,-52(s0)
    80008a26:	fcc42783          	lw	a5,-52(s0)
    80008a2a:	0207c063          	bltz	a5,80008a4a <sys_pipe+0x8a>
    80008a2e:	fd043783          	ld	a5,-48(s0)
    80008a32:	853e                	mv	a0,a5
    80008a34:	fffff097          	auipc	ra,0xfffff
    80008a38:	0a2080e7          	jalr	162(ra) # 80007ad6 <fdalloc>
    80008a3c:	87aa                	mv	a5,a0
    80008a3e:	fcf42423          	sw	a5,-56(s0)
    80008a42:	fc842783          	lw	a5,-56(s0)
    80008a46:	0207df63          	bgez	a5,80008a84 <sys_pipe+0xc4>
    if(fd0 >= 0)
    80008a4a:	fcc42783          	lw	a5,-52(s0)
    80008a4e:	0007cb63          	bltz	a5,80008a64 <sys_pipe+0xa4>
      p->ofile[fd0] = 0;
    80008a52:	fcc42783          	lw	a5,-52(s0)
    80008a56:	fe843703          	ld	a4,-24(s0)
    80008a5a:	07e9                	addi	a5,a5,26
    80008a5c:	078e                	slli	a5,a5,0x3
    80008a5e:	97ba                	add	a5,a5,a4
    80008a60:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    80008a64:	fd843783          	ld	a5,-40(s0)
    80008a68:	853e                	mv	a0,a5
    80008a6a:	ffffe097          	auipc	ra,0xffffe
    80008a6e:	0ac080e7          	jalr	172(ra) # 80006b16 <fileclose>
    fileclose(wf);
    80008a72:	fd043783          	ld	a5,-48(s0)
    80008a76:	853e                	mv	a0,a5
    80008a78:	ffffe097          	auipc	ra,0xffffe
    80008a7c:	09e080e7          	jalr	158(ra) # 80006b16 <fileclose>
    return -1;
    80008a80:	57fd                	li	a5,-1
    80008a82:	a079                	j	80008b10 <sys_pipe+0x150>
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008a84:	fe843783          	ld	a5,-24(s0)
    80008a88:	6fbc                	ld	a5,88(a5)
    80008a8a:	fe043703          	ld	a4,-32(s0)
    80008a8e:	fcc40613          	addi	a2,s0,-52
    80008a92:	4691                	li	a3,4
    80008a94:	85ba                	mv	a1,a4
    80008a96:	853e                	mv	a0,a5
    80008a98:	ffffa097          	auipc	ra,0xffffa
    80008a9c:	84e080e7          	jalr	-1970(ra) # 800022e6 <copyout>
    80008aa0:	87aa                	mv	a5,a0
    80008aa2:	0207c463          	bltz	a5,80008aca <sys_pipe+0x10a>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80008aa6:	fe843783          	ld	a5,-24(s0)
    80008aaa:	6fb8                	ld	a4,88(a5)
    80008aac:	fe043783          	ld	a5,-32(s0)
    80008ab0:	0791                	addi	a5,a5,4
    80008ab2:	fc840613          	addi	a2,s0,-56
    80008ab6:	4691                	li	a3,4
    80008ab8:	85be                	mv	a1,a5
    80008aba:	853a                	mv	a0,a4
    80008abc:	ffffa097          	auipc	ra,0xffffa
    80008ac0:	82a080e7          	jalr	-2006(ra) # 800022e6 <copyout>
    80008ac4:	87aa                	mv	a5,a0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80008ac6:	0407d463          	bgez	a5,80008b0e <sys_pipe+0x14e>
    p->ofile[fd0] = 0;
    80008aca:	fcc42783          	lw	a5,-52(s0)
    80008ace:	fe843703          	ld	a4,-24(s0)
    80008ad2:	07e9                	addi	a5,a5,26
    80008ad4:	078e                	slli	a5,a5,0x3
    80008ad6:	97ba                	add	a5,a5,a4
    80008ad8:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80008adc:	fc842783          	lw	a5,-56(s0)
    80008ae0:	fe843703          	ld	a4,-24(s0)
    80008ae4:	07e9                	addi	a5,a5,26
    80008ae6:	078e                	slli	a5,a5,0x3
    80008ae8:	97ba                	add	a5,a5,a4
    80008aea:	0007b423          	sd	zero,8(a5)
    fileclose(rf);
    80008aee:	fd843783          	ld	a5,-40(s0)
    80008af2:	853e                	mv	a0,a5
    80008af4:	ffffe097          	auipc	ra,0xffffe
    80008af8:	022080e7          	jalr	34(ra) # 80006b16 <fileclose>
    fileclose(wf);
    80008afc:	fd043783          	ld	a5,-48(s0)
    80008b00:	853e                	mv	a0,a5
    80008b02:	ffffe097          	auipc	ra,0xffffe
    80008b06:	014080e7          	jalr	20(ra) # 80006b16 <fileclose>
    return -1;
    80008b0a:	57fd                	li	a5,-1
    80008b0c:	a011                	j	80008b10 <sys_pipe+0x150>
  }
  return 0;
    80008b0e:	4781                	li	a5,0
}
    80008b10:	853e                	mv	a0,a5
    80008b12:	70e2                	ld	ra,56(sp)
    80008b14:	7442                	ld	s0,48(sp)
    80008b16:	6121                	addi	sp,sp,64
    80008b18:	8082                	ret
    80008b1a:	0000                	unimp
    80008b1c:	0000                	unimp
	...

0000000080008b20 <kernelvec>:
    80008b20:	7111                	addi	sp,sp,-256
    80008b22:	e006                	sd	ra,0(sp)
    80008b24:	e40a                	sd	sp,8(sp)
    80008b26:	e80e                	sd	gp,16(sp)
    80008b28:	ec12                	sd	tp,24(sp)
    80008b2a:	f016                	sd	t0,32(sp)
    80008b2c:	f41a                	sd	t1,40(sp)
    80008b2e:	f81e                	sd	t2,48(sp)
    80008b30:	fc22                	sd	s0,56(sp)
    80008b32:	e0a6                	sd	s1,64(sp)
    80008b34:	e4aa                	sd	a0,72(sp)
    80008b36:	e8ae                	sd	a1,80(sp)
    80008b38:	ecb2                	sd	a2,88(sp)
    80008b3a:	f0b6                	sd	a3,96(sp)
    80008b3c:	f4ba                	sd	a4,104(sp)
    80008b3e:	f8be                	sd	a5,112(sp)
    80008b40:	fcc2                	sd	a6,120(sp)
    80008b42:	e146                	sd	a7,128(sp)
    80008b44:	e54a                	sd	s2,136(sp)
    80008b46:	e94e                	sd	s3,144(sp)
    80008b48:	ed52                	sd	s4,152(sp)
    80008b4a:	f156                	sd	s5,160(sp)
    80008b4c:	f55a                	sd	s6,168(sp)
    80008b4e:	f95e                	sd	s7,176(sp)
    80008b50:	fd62                	sd	s8,184(sp)
    80008b52:	e1e6                	sd	s9,192(sp)
    80008b54:	e5ea                	sd	s10,200(sp)
    80008b56:	e9ee                	sd	s11,208(sp)
    80008b58:	edf2                	sd	t3,216(sp)
    80008b5a:	f1f6                	sd	t4,224(sp)
    80008b5c:	f5fa                	sd	t5,232(sp)
    80008b5e:	f9fe                	sd	t6,240(sp)
    80008b60:	c70fb0ef          	jal	ra,80003fd0 <kerneltrap>
    80008b64:	6082                	ld	ra,0(sp)
    80008b66:	6122                	ld	sp,8(sp)
    80008b68:	61c2                	ld	gp,16(sp)
    80008b6a:	7282                	ld	t0,32(sp)
    80008b6c:	7322                	ld	t1,40(sp)
    80008b6e:	73c2                	ld	t2,48(sp)
    80008b70:	7462                	ld	s0,56(sp)
    80008b72:	6486                	ld	s1,64(sp)
    80008b74:	6526                	ld	a0,72(sp)
    80008b76:	65c6                	ld	a1,80(sp)
    80008b78:	6666                	ld	a2,88(sp)
    80008b7a:	7686                	ld	a3,96(sp)
    80008b7c:	7726                	ld	a4,104(sp)
    80008b7e:	77c6                	ld	a5,112(sp)
    80008b80:	7866                	ld	a6,120(sp)
    80008b82:	688a                	ld	a7,128(sp)
    80008b84:	692a                	ld	s2,136(sp)
    80008b86:	69ca                	ld	s3,144(sp)
    80008b88:	6a6a                	ld	s4,152(sp)
    80008b8a:	7a8a                	ld	s5,160(sp)
    80008b8c:	7b2a                	ld	s6,168(sp)
    80008b8e:	7bca                	ld	s7,176(sp)
    80008b90:	7c6a                	ld	s8,184(sp)
    80008b92:	6c8e                	ld	s9,192(sp)
    80008b94:	6d2e                	ld	s10,200(sp)
    80008b96:	6dce                	ld	s11,208(sp)
    80008b98:	6e6e                	ld	t3,216(sp)
    80008b9a:	7e8e                	ld	t4,224(sp)
    80008b9c:	7f2e                	ld	t5,232(sp)
    80008b9e:	7fce                	ld	t6,240(sp)
    80008ba0:	6111                	addi	sp,sp,256
    80008ba2:	10200073          	sret
    80008ba6:	00000013          	nop
    80008baa:	00000013          	nop
    80008bae:	0001                	nop

0000000080008bb0 <timervec>:
    80008bb0:	34051573          	csrrw	a0,mscratch,a0
    80008bb4:	e10c                	sd	a1,0(a0)
    80008bb6:	e510                	sd	a2,8(a0)
    80008bb8:	e914                	sd	a3,16(a0)
    80008bba:	6d0c                	ld	a1,24(a0)
    80008bbc:	7110                	ld	a2,32(a0)
    80008bbe:	6194                	ld	a3,0(a1)
    80008bc0:	96b2                	add	a3,a3,a2
    80008bc2:	e194                	sd	a3,0(a1)
    80008bc4:	4589                	li	a1,2
    80008bc6:	14459073          	csrw	sip,a1
    80008bca:	6914                	ld	a3,16(a0)
    80008bcc:	6510                	ld	a2,8(a0)
    80008bce:	610c                	ld	a1,0(a0)
    80008bd0:	34051573          	csrrw	a0,mscratch,a0
    80008bd4:	30200073          	mret
	...

0000000080008bda <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80008bda:	1141                	addi	sp,sp,-16
    80008bdc:	e422                	sd	s0,8(sp)
    80008bde:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80008be0:	0c0007b7          	lui	a5,0xc000
    80008be4:	02878793          	addi	a5,a5,40 # c000028 <_entry-0x73ffffd8>
    80008be8:	4705                	li	a4,1
    80008bea:	c398                	sw	a4,0(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80008bec:	0c0007b7          	lui	a5,0xc000
    80008bf0:	0791                	addi	a5,a5,4
    80008bf2:	4705                	li	a4,1
    80008bf4:	c398                	sw	a4,0(a5)
}
    80008bf6:	0001                	nop
    80008bf8:	6422                	ld	s0,8(sp)
    80008bfa:	0141                	addi	sp,sp,16
    80008bfc:	8082                	ret

0000000080008bfe <plicinithart>:

void
plicinithart(void)
{
    80008bfe:	1101                	addi	sp,sp,-32
    80008c00:	ec06                	sd	ra,24(sp)
    80008c02:	e822                	sd	s0,16(sp)
    80008c04:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008c06:	ffffa097          	auipc	ra,0xffffa
    80008c0a:	bb0080e7          	jalr	-1104(ra) # 800027b6 <cpuid>
    80008c0e:	87aa                	mv	a5,a0
    80008c10:	fef42623          	sw	a5,-20(s0)
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80008c14:	fec42783          	lw	a5,-20(s0)
    80008c18:	0087979b          	slliw	a5,a5,0x8
    80008c1c:	2781                	sext.w	a5,a5
    80008c1e:	873e                	mv	a4,a5
    80008c20:	0c0027b7          	lui	a5,0xc002
    80008c24:	08078793          	addi	a5,a5,128 # c002080 <_entry-0x73ffdf80>
    80008c28:	97ba                	add	a5,a5,a4
    80008c2a:	873e                	mv	a4,a5
    80008c2c:	40200793          	li	a5,1026
    80008c30:	c31c                	sw	a5,0(a4)

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80008c32:	fec42783          	lw	a5,-20(s0)
    80008c36:	00d7979b          	slliw	a5,a5,0xd
    80008c3a:	2781                	sext.w	a5,a5
    80008c3c:	873e                	mv	a4,a5
    80008c3e:	0c2017b7          	lui	a5,0xc201
    80008c42:	97ba                	add	a5,a5,a4
    80008c44:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80008c48:	0001                	nop
    80008c4a:	60e2                	ld	ra,24(sp)
    80008c4c:	6442                	ld	s0,16(sp)
    80008c4e:	6105                	addi	sp,sp,32
    80008c50:	8082                	ret

0000000080008c52 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80008c52:	1101                	addi	sp,sp,-32
    80008c54:	ec06                	sd	ra,24(sp)
    80008c56:	e822                	sd	s0,16(sp)
    80008c58:	1000                	addi	s0,sp,32
  int hart = cpuid();
    80008c5a:	ffffa097          	auipc	ra,0xffffa
    80008c5e:	b5c080e7          	jalr	-1188(ra) # 800027b6 <cpuid>
    80008c62:	87aa                	mv	a5,a0
    80008c64:	fef42623          	sw	a5,-20(s0)
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80008c68:	fec42783          	lw	a5,-20(s0)
    80008c6c:	00d7979b          	slliw	a5,a5,0xd
    80008c70:	2781                	sext.w	a5,a5
    80008c72:	873e                	mv	a4,a5
    80008c74:	0c2017b7          	lui	a5,0xc201
    80008c78:	0791                	addi	a5,a5,4
    80008c7a:	97ba                	add	a5,a5,a4
    80008c7c:	439c                	lw	a5,0(a5)
    80008c7e:	fef42423          	sw	a5,-24(s0)
  return irq;
    80008c82:	fe842783          	lw	a5,-24(s0)
}
    80008c86:	853e                	mv	a0,a5
    80008c88:	60e2                	ld	ra,24(sp)
    80008c8a:	6442                	ld	s0,16(sp)
    80008c8c:	6105                	addi	sp,sp,32
    80008c8e:	8082                	ret

0000000080008c90 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80008c90:	7179                	addi	sp,sp,-48
    80008c92:	f406                	sd	ra,40(sp)
    80008c94:	f022                	sd	s0,32(sp)
    80008c96:	1800                	addi	s0,sp,48
    80008c98:	87aa                	mv	a5,a0
    80008c9a:	fcf42e23          	sw	a5,-36(s0)
  int hart = cpuid();
    80008c9e:	ffffa097          	auipc	ra,0xffffa
    80008ca2:	b18080e7          	jalr	-1256(ra) # 800027b6 <cpuid>
    80008ca6:	87aa                	mv	a5,a0
    80008ca8:	fef42623          	sw	a5,-20(s0)
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80008cac:	fec42783          	lw	a5,-20(s0)
    80008cb0:	00d7979b          	slliw	a5,a5,0xd
    80008cb4:	2781                	sext.w	a5,a5
    80008cb6:	873e                	mv	a4,a5
    80008cb8:	0c2017b7          	lui	a5,0xc201
    80008cbc:	0791                	addi	a5,a5,4
    80008cbe:	97ba                	add	a5,a5,a4
    80008cc0:	873e                	mv	a4,a5
    80008cc2:	fdc42783          	lw	a5,-36(s0)
    80008cc6:	c31c                	sw	a5,0(a4)
}
    80008cc8:	0001                	nop
    80008cca:	70a2                	ld	ra,40(sp)
    80008ccc:	7402                	ld	s0,32(sp)
    80008cce:	6145                	addi	sp,sp,48
    80008cd0:	8082                	ret

0000000080008cd2 <virtio_disk_init>:
  
} __attribute__ ((aligned (PGSIZE))) disk;

void
virtio_disk_init(void)
{
    80008cd2:	7179                	addi	sp,sp,-48
    80008cd4:	f406                	sd	ra,40(sp)
    80008cd6:	f022                	sd	s0,32(sp)
    80008cd8:	1800                	addi	s0,sp,48
  uint32 status = 0;
    80008cda:	fe042423          	sw	zero,-24(s0)

  initlock(&disk.vdisk_lock, "virtio_disk");
    80008cde:	00003597          	auipc	a1,0x3
    80008ce2:	9aa58593          	addi	a1,a1,-1622 # 8000b688 <etext+0x688>
    80008ce6:	0001f517          	auipc	a0,0x1f
    80008cea:	44250513          	addi	a0,a0,1090 # 80028128 <disk+0x2128>
    80008cee:	ffff8097          	auipc	ra,0xffff8
    80008cf2:	550080e7          	jalr	1360(ra) # 8000123e <initlock>

  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008cf6:	100017b7          	lui	a5,0x10001
    80008cfa:	439c                	lw	a5,0(a5)
    80008cfc:	2781                	sext.w	a5,a5
    80008cfe:	873e                	mv	a4,a5
    80008d00:	747277b7          	lui	a5,0x74727
    80008d04:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80008d08:	04f71063          	bne	a4,a5,80008d48 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80008d0c:	100017b7          	lui	a5,0x10001
    80008d10:	0791                	addi	a5,a5,4
    80008d12:	439c                	lw	a5,0(a5)
    80008d14:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80008d16:	873e                	mv	a4,a5
    80008d18:	4785                	li	a5,1
    80008d1a:	02f71763          	bne	a4,a5,80008d48 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008d1e:	100017b7          	lui	a5,0x10001
    80008d22:	07a1                	addi	a5,a5,8
    80008d24:	439c                	lw	a5,0(a5)
    80008d26:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80008d28:	873e                	mv	a4,a5
    80008d2a:	4789                	li	a5,2
    80008d2c:	00f71e63          	bne	a4,a5,80008d48 <virtio_disk_init+0x76>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80008d30:	100017b7          	lui	a5,0x10001
    80008d34:	07b1                	addi	a5,a5,12
    80008d36:	439c                	lw	a5,0(a5)
    80008d38:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80008d3a:	873e                	mv	a4,a5
    80008d3c:	554d47b7          	lui	a5,0x554d4
    80008d40:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80008d44:	00f70a63          	beq	a4,a5,80008d58 <virtio_disk_init+0x86>
    panic("could not find virtio disk");
    80008d48:	00003517          	auipc	a0,0x3
    80008d4c:	95050513          	addi	a0,a0,-1712 # 8000b698 <etext+0x698>
    80008d50:	ffff8097          	auipc	ra,0xffff8
    80008d54:	f2e080e7          	jalr	-210(ra) # 80000c7e <panic>
  }
  
  status |= VIRTIO_CONFIG_S_ACKNOWLEDGE;
    80008d58:	fe842783          	lw	a5,-24(s0)
    80008d5c:	0017e793          	ori	a5,a5,1
    80008d60:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008d64:	100017b7          	lui	a5,0x10001
    80008d68:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008d6c:	fe842703          	lw	a4,-24(s0)
    80008d70:	c398                	sw	a4,0(a5)

  status |= VIRTIO_CONFIG_S_DRIVER;
    80008d72:	fe842783          	lw	a5,-24(s0)
    80008d76:	0027e793          	ori	a5,a5,2
    80008d7a:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008d7e:	100017b7          	lui	a5,0x10001
    80008d82:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008d86:	fe842703          	lw	a4,-24(s0)
    80008d8a:	c398                	sw	a4,0(a5)

  // negotiate features
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80008d8c:	100017b7          	lui	a5,0x10001
    80008d90:	07c1                	addi	a5,a5,16
    80008d92:	439c                	lw	a5,0(a5)
    80008d94:	2781                	sext.w	a5,a5
    80008d96:	1782                	slli	a5,a5,0x20
    80008d98:	9381                	srli	a5,a5,0x20
    80008d9a:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_RO);
    80008d9e:	fe043783          	ld	a5,-32(s0)
    80008da2:	fdf7f793          	andi	a5,a5,-33
    80008da6:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_SCSI);
    80008daa:	fe043783          	ld	a5,-32(s0)
    80008dae:	f7f7f793          	andi	a5,a5,-129
    80008db2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
    80008db6:	fe043703          	ld	a4,-32(s0)
    80008dba:	77fd                	lui	a5,0xfffff
    80008dbc:	7ff78793          	addi	a5,a5,2047 # fffffffffffff7ff <end+0xffffffff7ffd67ff>
    80008dc0:	8ff9                	and	a5,a5,a4
    80008dc2:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_BLK_F_MQ);
    80008dc6:	fe043703          	ld	a4,-32(s0)
    80008dca:	77fd                	lui	a5,0xfffff
    80008dcc:	17fd                	addi	a5,a5,-1
    80008dce:	8ff9                	and	a5,a5,a4
    80008dd0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_F_ANY_LAYOUT);
    80008dd4:	fe043703          	ld	a4,-32(s0)
    80008dd8:	f80007b7          	lui	a5,0xf8000
    80008ddc:	17fd                	addi	a5,a5,-1
    80008dde:	8ff9                	and	a5,a5,a4
    80008de0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
    80008de4:	fe043703          	ld	a4,-32(s0)
    80008de8:	e00007b7          	lui	a5,0xe0000
    80008dec:	17fd                	addi	a5,a5,-1
    80008dee:	8ff9                	and	a5,a5,a4
    80008df0:	fef43023          	sd	a5,-32(s0)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80008df4:	fe043703          	ld	a4,-32(s0)
    80008df8:	f00007b7          	lui	a5,0xf0000
    80008dfc:	17fd                	addi	a5,a5,-1
    80008dfe:	8ff9                	and	a5,a5,a4
    80008e00:	fef43023          	sd	a5,-32(s0)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80008e04:	100017b7          	lui	a5,0x10001
    80008e08:	02078793          	addi	a5,a5,32 # 10001020 <_entry-0x6fffefe0>
    80008e0c:	fe043703          	ld	a4,-32(s0)
    80008e10:	2701                	sext.w	a4,a4
    80008e12:	c398                	sw	a4,0(a5)

  // tell device that feature negotiation is complete.
  status |= VIRTIO_CONFIG_S_FEATURES_OK;
    80008e14:	fe842783          	lw	a5,-24(s0)
    80008e18:	0087e793          	ori	a5,a5,8
    80008e1c:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008e20:	100017b7          	lui	a5,0x10001
    80008e24:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008e28:	fe842703          	lw	a4,-24(s0)
    80008e2c:	c398                	sw	a4,0(a5)

  // tell device we're completely ready.
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80008e2e:	fe842783          	lw	a5,-24(s0)
    80008e32:	0047e793          	ori	a5,a5,4
    80008e36:	fef42423          	sw	a5,-24(s0)
  *R(VIRTIO_MMIO_STATUS) = status;
    80008e3a:	100017b7          	lui	a5,0x10001
    80008e3e:	07078793          	addi	a5,a5,112 # 10001070 <_entry-0x6fffef90>
    80008e42:	fe842703          	lw	a4,-24(s0)
    80008e46:	c398                	sw	a4,0(a5)

  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80008e48:	100017b7          	lui	a5,0x10001
    80008e4c:	02878793          	addi	a5,a5,40 # 10001028 <_entry-0x6fffefd8>
    80008e50:	6705                	lui	a4,0x1
    80008e52:	c398                	sw	a4,0(a5)

  // initialize queue 0.
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80008e54:	100017b7          	lui	a5,0x10001
    80008e58:	03078793          	addi	a5,a5,48 # 10001030 <_entry-0x6fffefd0>
    80008e5c:	0007a023          	sw	zero,0(a5)
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80008e60:	100017b7          	lui	a5,0x10001
    80008e64:	03478793          	addi	a5,a5,52 # 10001034 <_entry-0x6fffefcc>
    80008e68:	439c                	lw	a5,0(a5)
    80008e6a:	fcf42e23          	sw	a5,-36(s0)
  if(max == 0)
    80008e6e:	fdc42783          	lw	a5,-36(s0)
    80008e72:	2781                	sext.w	a5,a5
    80008e74:	eb89                	bnez	a5,80008e86 <virtio_disk_init+0x1b4>
    panic("virtio disk has no queue 0");
    80008e76:	00003517          	auipc	a0,0x3
    80008e7a:	84250513          	addi	a0,a0,-1982 # 8000b6b8 <etext+0x6b8>
    80008e7e:	ffff8097          	auipc	ra,0xffff8
    80008e82:	e00080e7          	jalr	-512(ra) # 80000c7e <panic>
  if(max < NUM)
    80008e86:	fdc42783          	lw	a5,-36(s0)
    80008e8a:	0007871b          	sext.w	a4,a5
    80008e8e:	479d                	li	a5,7
    80008e90:	00e7ea63          	bltu	a5,a4,80008ea4 <virtio_disk_init+0x1d2>
    panic("virtio disk max queue too short");
    80008e94:	00003517          	auipc	a0,0x3
    80008e98:	84450513          	addi	a0,a0,-1980 # 8000b6d8 <etext+0x6d8>
    80008e9c:	ffff8097          	auipc	ra,0xffff8
    80008ea0:	de2080e7          	jalr	-542(ra) # 80000c7e <panic>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80008ea4:	100017b7          	lui	a5,0x10001
    80008ea8:	03878793          	addi	a5,a5,56 # 10001038 <_entry-0x6fffefc8>
    80008eac:	4721                	li	a4,8
    80008eae:	c398                	sw	a4,0(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    80008eb0:	6609                	lui	a2,0x2
    80008eb2:	4581                	li	a1,0
    80008eb4:	0001d517          	auipc	a0,0x1d
    80008eb8:	14c50513          	addi	a0,a0,332 # 80026000 <disk>
    80008ebc:	ffff8097          	auipc	ra,0xffff8
    80008ec0:	586080e7          	jalr	1414(ra) # 80001442 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80008ec4:	0001d797          	auipc	a5,0x1d
    80008ec8:	13c78793          	addi	a5,a5,316 # 80026000 <disk>
    80008ecc:	00c7d713          	srli	a4,a5,0xc
    80008ed0:	100017b7          	lui	a5,0x10001
    80008ed4:	04078793          	addi	a5,a5,64 # 10001040 <_entry-0x6fffefc0>
    80008ed8:	2701                	sext.w	a4,a4
    80008eda:	c398                	sw	a4,0(a5)

  // desc = pages -- num * virtq_desc
  // avail = pages + 0x40 -- 2 * uint16, then num * uint16
  // used = pages + 4096 -- 2 * uint16, then num * vRingUsedElem

  disk.desc = (struct virtq_desc *) disk.pages;
    80008edc:	0001d717          	auipc	a4,0x1d
    80008ee0:	12470713          	addi	a4,a4,292 # 80026000 <disk>
    80008ee4:	6789                	lui	a5,0x2
    80008ee6:	97ba                	add	a5,a5,a4
    80008ee8:	0001d717          	auipc	a4,0x1d
    80008eec:	11870713          	addi	a4,a4,280 # 80026000 <disk>
    80008ef0:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80008ef2:	0001d717          	auipc	a4,0x1d
    80008ef6:	18e70713          	addi	a4,a4,398 # 80026080 <disk+0x80>
    80008efa:	0001d697          	auipc	a3,0x1d
    80008efe:	10668693          	addi	a3,a3,262 # 80026000 <disk>
    80008f02:	6789                	lui	a5,0x2
    80008f04:	97b6                	add	a5,a5,a3
    80008f06:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80008f08:	0001e717          	auipc	a4,0x1e
    80008f0c:	0f870713          	addi	a4,a4,248 # 80027000 <disk+0x1000>
    80008f10:	0001d697          	auipc	a3,0x1d
    80008f14:	0f068693          	addi	a3,a3,240 # 80026000 <disk>
    80008f18:	6789                	lui	a5,0x2
    80008f1a:	97b6                	add	a5,a5,a3
    80008f1c:	eb98                	sd	a4,16(a5)

  // all NUM descriptors start out unused.
  for(int i = 0; i < NUM; i++)
    80008f1e:	fe042623          	sw	zero,-20(s0)
    80008f22:	a015                	j	80008f46 <virtio_disk_init+0x274>
    disk.free[i] = 1;
    80008f24:	0001d717          	auipc	a4,0x1d
    80008f28:	0dc70713          	addi	a4,a4,220 # 80026000 <disk>
    80008f2c:	fec42783          	lw	a5,-20(s0)
    80008f30:	97ba                	add	a5,a5,a4
    80008f32:	6709                	lui	a4,0x2
    80008f34:	97ba                	add	a5,a5,a4
    80008f36:	4705                	li	a4,1
    80008f38:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  for(int i = 0; i < NUM; i++)
    80008f3c:	fec42783          	lw	a5,-20(s0)
    80008f40:	2785                	addiw	a5,a5,1
    80008f42:	fef42623          	sw	a5,-20(s0)
    80008f46:	fec42783          	lw	a5,-20(s0)
    80008f4a:	0007871b          	sext.w	a4,a5
    80008f4e:	479d                	li	a5,7
    80008f50:	fce7dae3          	bge	a5,a4,80008f24 <virtio_disk_init+0x252>

  // plic.c and trap.c arrange for interrupts from VIRTIO0_IRQ.
}
    80008f54:	0001                	nop
    80008f56:	0001                	nop
    80008f58:	70a2                	ld	ra,40(sp)
    80008f5a:	7402                	ld	s0,32(sp)
    80008f5c:	6145                	addi	sp,sp,48
    80008f5e:	8082                	ret

0000000080008f60 <alloc_desc>:

// find a free descriptor, mark it non-free, return its index.
static int
alloc_desc()
{
    80008f60:	1101                	addi	sp,sp,-32
    80008f62:	ec22                	sd	s0,24(sp)
    80008f64:	1000                	addi	s0,sp,32
  for(int i = 0; i < NUM; i++){
    80008f66:	fe042623          	sw	zero,-20(s0)
    80008f6a:	a081                	j	80008faa <alloc_desc+0x4a>
    if(disk.free[i]){
    80008f6c:	0001d717          	auipc	a4,0x1d
    80008f70:	09470713          	addi	a4,a4,148 # 80026000 <disk>
    80008f74:	fec42783          	lw	a5,-20(s0)
    80008f78:	97ba                	add	a5,a5,a4
    80008f7a:	6709                	lui	a4,0x2
    80008f7c:	97ba                	add	a5,a5,a4
    80008f7e:	0187c783          	lbu	a5,24(a5)
    80008f82:	cf99                	beqz	a5,80008fa0 <alloc_desc+0x40>
      disk.free[i] = 0;
    80008f84:	0001d717          	auipc	a4,0x1d
    80008f88:	07c70713          	addi	a4,a4,124 # 80026000 <disk>
    80008f8c:	fec42783          	lw	a5,-20(s0)
    80008f90:	97ba                	add	a5,a5,a4
    80008f92:	6709                	lui	a4,0x2
    80008f94:	97ba                	add	a5,a5,a4
    80008f96:	00078c23          	sb	zero,24(a5)
      return i;
    80008f9a:	fec42783          	lw	a5,-20(s0)
    80008f9e:	a831                	j	80008fba <alloc_desc+0x5a>
  for(int i = 0; i < NUM; i++){
    80008fa0:	fec42783          	lw	a5,-20(s0)
    80008fa4:	2785                	addiw	a5,a5,1
    80008fa6:	fef42623          	sw	a5,-20(s0)
    80008faa:	fec42783          	lw	a5,-20(s0)
    80008fae:	0007871b          	sext.w	a4,a5
    80008fb2:	479d                	li	a5,7
    80008fb4:	fae7dce3          	bge	a5,a4,80008f6c <alloc_desc+0xc>
    }
  }
  return -1;
    80008fb8:	57fd                	li	a5,-1
}
    80008fba:	853e                	mv	a0,a5
    80008fbc:	6462                	ld	s0,24(sp)
    80008fbe:	6105                	addi	sp,sp,32
    80008fc0:	8082                	ret

0000000080008fc2 <free_desc>:

// mark a descriptor as free.
static void
free_desc(int i)
{
    80008fc2:	1101                	addi	sp,sp,-32
    80008fc4:	ec06                	sd	ra,24(sp)
    80008fc6:	e822                	sd	s0,16(sp)
    80008fc8:	1000                	addi	s0,sp,32
    80008fca:	87aa                	mv	a5,a0
    80008fcc:	fef42623          	sw	a5,-20(s0)
  if(i >= NUM)
    80008fd0:	fec42783          	lw	a5,-20(s0)
    80008fd4:	0007871b          	sext.w	a4,a5
    80008fd8:	479d                	li	a5,7
    80008fda:	00e7da63          	bge	a5,a4,80008fee <free_desc+0x2c>
    panic("free_desc 1");
    80008fde:	00002517          	auipc	a0,0x2
    80008fe2:	71a50513          	addi	a0,a0,1818 # 8000b6f8 <etext+0x6f8>
    80008fe6:	ffff8097          	auipc	ra,0xffff8
    80008fea:	c98080e7          	jalr	-872(ra) # 80000c7e <panic>
  if(disk.free[i])
    80008fee:	0001d717          	auipc	a4,0x1d
    80008ff2:	01270713          	addi	a4,a4,18 # 80026000 <disk>
    80008ff6:	fec42783          	lw	a5,-20(s0)
    80008ffa:	97ba                	add	a5,a5,a4
    80008ffc:	6709                	lui	a4,0x2
    80008ffe:	97ba                	add	a5,a5,a4
    80009000:	0187c783          	lbu	a5,24(a5)
    80009004:	cb89                	beqz	a5,80009016 <free_desc+0x54>
    panic("free_desc 2");
    80009006:	00002517          	auipc	a0,0x2
    8000900a:	70250513          	addi	a0,a0,1794 # 8000b708 <etext+0x708>
    8000900e:	ffff8097          	auipc	ra,0xffff8
    80009012:	c70080e7          	jalr	-912(ra) # 80000c7e <panic>
  disk.desc[i].addr = 0;
    80009016:	0001d717          	auipc	a4,0x1d
    8000901a:	fea70713          	addi	a4,a4,-22 # 80026000 <disk>
    8000901e:	6789                	lui	a5,0x2
    80009020:	97ba                	add	a5,a5,a4
    80009022:	6398                	ld	a4,0(a5)
    80009024:	fec42783          	lw	a5,-20(s0)
    80009028:	0792                	slli	a5,a5,0x4
    8000902a:	97ba                	add	a5,a5,a4
    8000902c:	0007b023          	sd	zero,0(a5) # 2000 <_entry-0x7fffe000>
  disk.desc[i].len = 0;
    80009030:	0001d717          	auipc	a4,0x1d
    80009034:	fd070713          	addi	a4,a4,-48 # 80026000 <disk>
    80009038:	6789                	lui	a5,0x2
    8000903a:	97ba                	add	a5,a5,a4
    8000903c:	6398                	ld	a4,0(a5)
    8000903e:	fec42783          	lw	a5,-20(s0)
    80009042:	0792                	slli	a5,a5,0x4
    80009044:	97ba                	add	a5,a5,a4
    80009046:	0007a423          	sw	zero,8(a5) # 2008 <_entry-0x7fffdff8>
  disk.desc[i].flags = 0;
    8000904a:	0001d717          	auipc	a4,0x1d
    8000904e:	fb670713          	addi	a4,a4,-74 # 80026000 <disk>
    80009052:	6789                	lui	a5,0x2
    80009054:	97ba                	add	a5,a5,a4
    80009056:	6398                	ld	a4,0(a5)
    80009058:	fec42783          	lw	a5,-20(s0)
    8000905c:	0792                	slli	a5,a5,0x4
    8000905e:	97ba                	add	a5,a5,a4
    80009060:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[i].next = 0;
    80009064:	0001d717          	auipc	a4,0x1d
    80009068:	f9c70713          	addi	a4,a4,-100 # 80026000 <disk>
    8000906c:	6789                	lui	a5,0x2
    8000906e:	97ba                	add	a5,a5,a4
    80009070:	6398                	ld	a4,0(a5)
    80009072:	fec42783          	lw	a5,-20(s0)
    80009076:	0792                	slli	a5,a5,0x4
    80009078:	97ba                	add	a5,a5,a4
    8000907a:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>
  disk.free[i] = 1;
    8000907e:	0001d717          	auipc	a4,0x1d
    80009082:	f8270713          	addi	a4,a4,-126 # 80026000 <disk>
    80009086:	fec42783          	lw	a5,-20(s0)
    8000908a:	97ba                	add	a5,a5,a4
    8000908c:	6709                	lui	a4,0x2
    8000908e:	97ba                	add	a5,a5,a4
    80009090:	4705                	li	a4,1
    80009092:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    80009096:	0001f517          	auipc	a0,0x1f
    8000909a:	f8250513          	addi	a0,a0,-126 # 80028018 <disk+0x2018>
    8000909e:	ffffa097          	auipc	ra,0xffffa
    800090a2:	506080e7          	jalr	1286(ra) # 800035a4 <wakeup>
}
    800090a6:	0001                	nop
    800090a8:	60e2                	ld	ra,24(sp)
    800090aa:	6442                	ld	s0,16(sp)
    800090ac:	6105                	addi	sp,sp,32
    800090ae:	8082                	ret

00000000800090b0 <free_chain>:

// free a chain of descriptors.
static void
free_chain(int i)
{
    800090b0:	7179                	addi	sp,sp,-48
    800090b2:	f406                	sd	ra,40(sp)
    800090b4:	f022                	sd	s0,32(sp)
    800090b6:	1800                	addi	s0,sp,48
    800090b8:	87aa                	mv	a5,a0
    800090ba:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    int flag = disk.desc[i].flags;
    800090be:	0001d717          	auipc	a4,0x1d
    800090c2:	f4270713          	addi	a4,a4,-190 # 80026000 <disk>
    800090c6:	6789                	lui	a5,0x2
    800090c8:	97ba                	add	a5,a5,a4
    800090ca:	6398                	ld	a4,0(a5)
    800090cc:	fdc42783          	lw	a5,-36(s0)
    800090d0:	0792                	slli	a5,a5,0x4
    800090d2:	97ba                	add	a5,a5,a4
    800090d4:	00c7d783          	lhu	a5,12(a5) # 200c <_entry-0x7fffdff4>
    800090d8:	fef42623          	sw	a5,-20(s0)
    int nxt = disk.desc[i].next;
    800090dc:	0001d717          	auipc	a4,0x1d
    800090e0:	f2470713          	addi	a4,a4,-220 # 80026000 <disk>
    800090e4:	6789                	lui	a5,0x2
    800090e6:	97ba                	add	a5,a5,a4
    800090e8:	6398                	ld	a4,0(a5)
    800090ea:	fdc42783          	lw	a5,-36(s0)
    800090ee:	0792                	slli	a5,a5,0x4
    800090f0:	97ba                	add	a5,a5,a4
    800090f2:	00e7d783          	lhu	a5,14(a5) # 200e <_entry-0x7fffdff2>
    800090f6:	fef42423          	sw	a5,-24(s0)
    free_desc(i);
    800090fa:	fdc42783          	lw	a5,-36(s0)
    800090fe:	853e                	mv	a0,a5
    80009100:	00000097          	auipc	ra,0x0
    80009104:	ec2080e7          	jalr	-318(ra) # 80008fc2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80009108:	fec42783          	lw	a5,-20(s0)
    8000910c:	8b85                	andi	a5,a5,1
    8000910e:	2781                	sext.w	a5,a5
    80009110:	c791                	beqz	a5,8000911c <free_chain+0x6c>
      i = nxt;
    80009112:	fe842783          	lw	a5,-24(s0)
    80009116:	fcf42e23          	sw	a5,-36(s0)
  while(1){
    8000911a:	b755                	j	800090be <free_chain+0xe>
    else
      break;
    8000911c:	0001                	nop
  }
}
    8000911e:	0001                	nop
    80009120:	70a2                	ld	ra,40(sp)
    80009122:	7402                	ld	s0,32(sp)
    80009124:	6145                	addi	sp,sp,48
    80009126:	8082                	ret

0000000080009128 <alloc3_desc>:

// allocate three descriptors (they need not be contiguous).
// disk transfers always use three descriptors.
static int
alloc3_desc(int *idx)
{
    80009128:	7139                	addi	sp,sp,-64
    8000912a:	fc06                	sd	ra,56(sp)
    8000912c:	f822                	sd	s0,48(sp)
    8000912e:	f426                	sd	s1,40(sp)
    80009130:	0080                	addi	s0,sp,64
    80009132:	fca43423          	sd	a0,-56(s0)
  for(int i = 0; i < 3; i++){
    80009136:	fc042e23          	sw	zero,-36(s0)
    8000913a:	a895                	j	800091ae <alloc3_desc+0x86>
    idx[i] = alloc_desc();
    8000913c:	fdc42783          	lw	a5,-36(s0)
    80009140:	078a                	slli	a5,a5,0x2
    80009142:	fc843703          	ld	a4,-56(s0)
    80009146:	00f704b3          	add	s1,a4,a5
    8000914a:	00000097          	auipc	ra,0x0
    8000914e:	e16080e7          	jalr	-490(ra) # 80008f60 <alloc_desc>
    80009152:	87aa                	mv	a5,a0
    80009154:	c09c                	sw	a5,0(s1)
    if(idx[i] < 0){
    80009156:	fdc42783          	lw	a5,-36(s0)
    8000915a:	078a                	slli	a5,a5,0x2
    8000915c:	fc843703          	ld	a4,-56(s0)
    80009160:	97ba                	add	a5,a5,a4
    80009162:	439c                	lw	a5,0(a5)
    80009164:	0407d063          	bgez	a5,800091a4 <alloc3_desc+0x7c>
      for(int j = 0; j < i; j++)
    80009168:	fc042c23          	sw	zero,-40(s0)
    8000916c:	a015                	j	80009190 <alloc3_desc+0x68>
        free_desc(idx[j]);
    8000916e:	fd842783          	lw	a5,-40(s0)
    80009172:	078a                	slli	a5,a5,0x2
    80009174:	fc843703          	ld	a4,-56(s0)
    80009178:	97ba                	add	a5,a5,a4
    8000917a:	439c                	lw	a5,0(a5)
    8000917c:	853e                	mv	a0,a5
    8000917e:	00000097          	auipc	ra,0x0
    80009182:	e44080e7          	jalr	-444(ra) # 80008fc2 <free_desc>
      for(int j = 0; j < i; j++)
    80009186:	fd842783          	lw	a5,-40(s0)
    8000918a:	2785                	addiw	a5,a5,1
    8000918c:	fcf42c23          	sw	a5,-40(s0)
    80009190:	fd842703          	lw	a4,-40(s0)
    80009194:	fdc42783          	lw	a5,-36(s0)
    80009198:	2701                	sext.w	a4,a4
    8000919a:	2781                	sext.w	a5,a5
    8000919c:	fcf749e3          	blt	a4,a5,8000916e <alloc3_desc+0x46>
      return -1;
    800091a0:	57fd                	li	a5,-1
    800091a2:	a831                	j	800091be <alloc3_desc+0x96>
  for(int i = 0; i < 3; i++){
    800091a4:	fdc42783          	lw	a5,-36(s0)
    800091a8:	2785                	addiw	a5,a5,1
    800091aa:	fcf42e23          	sw	a5,-36(s0)
    800091ae:	fdc42783          	lw	a5,-36(s0)
    800091b2:	0007871b          	sext.w	a4,a5
    800091b6:	4789                	li	a5,2
    800091b8:	f8e7d2e3          	bge	a5,a4,8000913c <alloc3_desc+0x14>
    }
  }
  return 0;
    800091bc:	4781                	li	a5,0
}
    800091be:	853e                	mv	a0,a5
    800091c0:	70e2                	ld	ra,56(sp)
    800091c2:	7442                	ld	s0,48(sp)
    800091c4:	74a2                	ld	s1,40(sp)
    800091c6:	6121                	addi	sp,sp,64
    800091c8:	8082                	ret

00000000800091ca <virtio_disk_rw>:

void
virtio_disk_rw(struct buf *b, int write)
{
    800091ca:	7139                	addi	sp,sp,-64
    800091cc:	fc06                	sd	ra,56(sp)
    800091ce:	f822                	sd	s0,48(sp)
    800091d0:	0080                	addi	s0,sp,64
    800091d2:	fca43423          	sd	a0,-56(s0)
    800091d6:	87ae                	mv	a5,a1
    800091d8:	fcf42223          	sw	a5,-60(s0)
  uint64 sector = b->blockno * (BSIZE / 512);
    800091dc:	fc843783          	ld	a5,-56(s0)
    800091e0:	47dc                	lw	a5,12(a5)
    800091e2:	0017979b          	slliw	a5,a5,0x1
    800091e6:	2781                	sext.w	a5,a5
    800091e8:	1782                	slli	a5,a5,0x20
    800091ea:	9381                	srli	a5,a5,0x20
    800091ec:	fef43423          	sd	a5,-24(s0)

  acquire(&disk.vdisk_lock);
    800091f0:	0001f517          	auipc	a0,0x1f
    800091f4:	f3850513          	addi	a0,a0,-200 # 80028128 <disk+0x2128>
    800091f8:	ffff8097          	auipc	ra,0xffff8
    800091fc:	076080e7          	jalr	118(ra) # 8000126e <acquire>
  // data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
    80009200:	fd040793          	addi	a5,s0,-48
    80009204:	853e                	mv	a0,a5
    80009206:	00000097          	auipc	ra,0x0
    8000920a:	f22080e7          	jalr	-222(ra) # 80009128 <alloc3_desc>
    8000920e:	87aa                	mv	a5,a0
    80009210:	cf91                	beqz	a5,8000922c <virtio_disk_rw+0x62>
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80009212:	0001f597          	auipc	a1,0x1f
    80009216:	f1658593          	addi	a1,a1,-234 # 80028128 <disk+0x2128>
    8000921a:	0001f517          	auipc	a0,0x1f
    8000921e:	dfe50513          	addi	a0,a0,-514 # 80028018 <disk+0x2018>
    80009222:	ffffa097          	auipc	ra,0xffffa
    80009226:	2be080e7          	jalr	702(ra) # 800034e0 <sleep>
    if(alloc3_desc(idx) == 0) {
    8000922a:	bfd9                	j	80009200 <virtio_disk_rw+0x36>
      break;
    8000922c:	0001                	nop
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000922e:	fd042783          	lw	a5,-48(s0)
    80009232:	20078793          	addi	a5,a5,512
    80009236:	00479713          	slli	a4,a5,0x4
    8000923a:	0001d797          	auipc	a5,0x1d
    8000923e:	dc678793          	addi	a5,a5,-570 # 80026000 <disk>
    80009242:	97ba                	add	a5,a5,a4
    80009244:	0a878793          	addi	a5,a5,168
    80009248:	fef43023          	sd	a5,-32(s0)

  if(write)
    8000924c:	fc442783          	lw	a5,-60(s0)
    80009250:	2781                	sext.w	a5,a5
    80009252:	c791                	beqz	a5,8000925e <virtio_disk_rw+0x94>
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80009254:	fe043783          	ld	a5,-32(s0)
    80009258:	4705                	li	a4,1
    8000925a:	c398                	sw	a4,0(a5)
    8000925c:	a029                	j	80009266 <virtio_disk_rw+0x9c>
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    8000925e:	fe043783          	ld	a5,-32(s0)
    80009262:	0007a023          	sw	zero,0(a5)
  buf0->reserved = 0;
    80009266:	fe043783          	ld	a5,-32(s0)
    8000926a:	0007a223          	sw	zero,4(a5)
  buf0->sector = sector;
    8000926e:	fe043783          	ld	a5,-32(s0)
    80009272:	fe843703          	ld	a4,-24(s0)
    80009276:	e798                	sd	a4,8(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80009278:	0001d717          	auipc	a4,0x1d
    8000927c:	d8870713          	addi	a4,a4,-632 # 80026000 <disk>
    80009280:	6789                	lui	a5,0x2
    80009282:	97ba                	add	a5,a5,a4
    80009284:	6398                	ld	a4,0(a5)
    80009286:	fd042783          	lw	a5,-48(s0)
    8000928a:	0792                	slli	a5,a5,0x4
    8000928c:	97ba                	add	a5,a5,a4
    8000928e:	fe043703          	ld	a4,-32(s0)
    80009292:	e398                	sd	a4,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80009294:	0001d717          	auipc	a4,0x1d
    80009298:	d6c70713          	addi	a4,a4,-660 # 80026000 <disk>
    8000929c:	6789                	lui	a5,0x2
    8000929e:	97ba                	add	a5,a5,a4
    800092a0:	6398                	ld	a4,0(a5)
    800092a2:	fd042783          	lw	a5,-48(s0)
    800092a6:	0792                	slli	a5,a5,0x4
    800092a8:	97ba                	add	a5,a5,a4
    800092aa:	4741                	li	a4,16
    800092ac:	c798                	sw	a4,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800092ae:	0001d717          	auipc	a4,0x1d
    800092b2:	d5270713          	addi	a4,a4,-686 # 80026000 <disk>
    800092b6:	6789                	lui	a5,0x2
    800092b8:	97ba                	add	a5,a5,a4
    800092ba:	6398                	ld	a4,0(a5)
    800092bc:	fd042783          	lw	a5,-48(s0)
    800092c0:	0792                	slli	a5,a5,0x4
    800092c2:	97ba                	add	a5,a5,a4
    800092c4:	4705                	li	a4,1
    800092c6:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[0]].next = idx[1];
    800092ca:	fd442683          	lw	a3,-44(s0)
    800092ce:	0001d717          	auipc	a4,0x1d
    800092d2:	d3270713          	addi	a4,a4,-718 # 80026000 <disk>
    800092d6:	6789                	lui	a5,0x2
    800092d8:	97ba                	add	a5,a5,a4
    800092da:	6398                	ld	a4,0(a5)
    800092dc:	fd042783          	lw	a5,-48(s0)
    800092e0:	0792                	slli	a5,a5,0x4
    800092e2:	97ba                	add	a5,a5,a4
    800092e4:	03069713          	slli	a4,a3,0x30
    800092e8:	9341                	srli	a4,a4,0x30
    800092ea:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.desc[idx[1]].addr = (uint64) b->data;
    800092ee:	fc843783          	ld	a5,-56(s0)
    800092f2:	05878693          	addi	a3,a5,88
    800092f6:	0001d717          	auipc	a4,0x1d
    800092fa:	d0a70713          	addi	a4,a4,-758 # 80026000 <disk>
    800092fe:	6789                	lui	a5,0x2
    80009300:	97ba                	add	a5,a5,a4
    80009302:	6398                	ld	a4,0(a5)
    80009304:	fd442783          	lw	a5,-44(s0)
    80009308:	0792                	slli	a5,a5,0x4
    8000930a:	97ba                	add	a5,a5,a4
    8000930c:	8736                	mv	a4,a3
    8000930e:	e398                	sd	a4,0(a5)
  disk.desc[idx[1]].len = BSIZE;
    80009310:	0001d717          	auipc	a4,0x1d
    80009314:	cf070713          	addi	a4,a4,-784 # 80026000 <disk>
    80009318:	6789                	lui	a5,0x2
    8000931a:	97ba                	add	a5,a5,a4
    8000931c:	6398                	ld	a4,0(a5)
    8000931e:	fd442783          	lw	a5,-44(s0)
    80009322:	0792                	slli	a5,a5,0x4
    80009324:	97ba                	add	a5,a5,a4
    80009326:	40000713          	li	a4,1024
    8000932a:	c798                	sw	a4,8(a5)
  if(write)
    8000932c:	fc442783          	lw	a5,-60(s0)
    80009330:	2781                	sext.w	a5,a5
    80009332:	cf99                	beqz	a5,80009350 <virtio_disk_rw+0x186>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80009334:	0001d717          	auipc	a4,0x1d
    80009338:	ccc70713          	addi	a4,a4,-820 # 80026000 <disk>
    8000933c:	6789                	lui	a5,0x2
    8000933e:	97ba                	add	a5,a5,a4
    80009340:	6398                	ld	a4,0(a5)
    80009342:	fd442783          	lw	a5,-44(s0)
    80009346:	0792                	slli	a5,a5,0x4
    80009348:	97ba                	add	a5,a5,a4
    8000934a:	00079623          	sh	zero,12(a5) # 200c <_entry-0x7fffdff4>
    8000934e:	a839                	j	8000936c <virtio_disk_rw+0x1a2>
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80009350:	0001d717          	auipc	a4,0x1d
    80009354:	cb070713          	addi	a4,a4,-848 # 80026000 <disk>
    80009358:	6789                	lui	a5,0x2
    8000935a:	97ba                	add	a5,a5,a4
    8000935c:	6398                	ld	a4,0(a5)
    8000935e:	fd442783          	lw	a5,-44(s0)
    80009362:	0792                	slli	a5,a5,0x4
    80009364:	97ba                	add	a5,a5,a4
    80009366:	4709                	li	a4,2
    80009368:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000936c:	0001d717          	auipc	a4,0x1d
    80009370:	c9470713          	addi	a4,a4,-876 # 80026000 <disk>
    80009374:	6789                	lui	a5,0x2
    80009376:	97ba                	add	a5,a5,a4
    80009378:	6398                	ld	a4,0(a5)
    8000937a:	fd442783          	lw	a5,-44(s0)
    8000937e:	0792                	slli	a5,a5,0x4
    80009380:	97ba                	add	a5,a5,a4
    80009382:	00c7d703          	lhu	a4,12(a5) # 200c <_entry-0x7fffdff4>
    80009386:	0001d697          	auipc	a3,0x1d
    8000938a:	c7a68693          	addi	a3,a3,-902 # 80026000 <disk>
    8000938e:	6789                	lui	a5,0x2
    80009390:	97b6                	add	a5,a5,a3
    80009392:	6394                	ld	a3,0(a5)
    80009394:	fd442783          	lw	a5,-44(s0)
    80009398:	0792                	slli	a5,a5,0x4
    8000939a:	97b6                	add	a5,a5,a3
    8000939c:	00176713          	ori	a4,a4,1
    800093a0:	1742                	slli	a4,a4,0x30
    800093a2:	9341                	srli	a4,a4,0x30
    800093a4:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[1]].next = idx[2];
    800093a8:	fd842683          	lw	a3,-40(s0)
    800093ac:	0001d717          	auipc	a4,0x1d
    800093b0:	c5470713          	addi	a4,a4,-940 # 80026000 <disk>
    800093b4:	6789                	lui	a5,0x2
    800093b6:	97ba                	add	a5,a5,a4
    800093b8:	6398                	ld	a4,0(a5)
    800093ba:	fd442783          	lw	a5,-44(s0)
    800093be:	0792                	slli	a5,a5,0x4
    800093c0:	97ba                	add	a5,a5,a4
    800093c2:	03069713          	slli	a4,a3,0x30
    800093c6:	9341                	srli	a4,a4,0x30
    800093c8:	00e79723          	sh	a4,14(a5) # 200e <_entry-0x7fffdff2>

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800093cc:	fd042783          	lw	a5,-48(s0)
    800093d0:	0001d717          	auipc	a4,0x1d
    800093d4:	c3070713          	addi	a4,a4,-976 # 80026000 <disk>
    800093d8:	20078793          	addi	a5,a5,512
    800093dc:	0792                	slli	a5,a5,0x4
    800093de:	97ba                	add	a5,a5,a4
    800093e0:	577d                	li	a4,-1
    800093e2:	02e78823          	sb	a4,48(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800093e6:	fd042783          	lw	a5,-48(s0)
    800093ea:	20078793          	addi	a5,a5,512
    800093ee:	00479713          	slli	a4,a5,0x4
    800093f2:	0001d797          	auipc	a5,0x1d
    800093f6:	c0e78793          	addi	a5,a5,-1010 # 80026000 <disk>
    800093fa:	97ba                	add	a5,a5,a4
    800093fc:	03078693          	addi	a3,a5,48
    80009400:	0001d717          	auipc	a4,0x1d
    80009404:	c0070713          	addi	a4,a4,-1024 # 80026000 <disk>
    80009408:	6789                	lui	a5,0x2
    8000940a:	97ba                	add	a5,a5,a4
    8000940c:	6398                	ld	a4,0(a5)
    8000940e:	fd842783          	lw	a5,-40(s0)
    80009412:	0792                	slli	a5,a5,0x4
    80009414:	97ba                	add	a5,a5,a4
    80009416:	8736                	mv	a4,a3
    80009418:	e398                	sd	a4,0(a5)
  disk.desc[idx[2]].len = 1;
    8000941a:	0001d717          	auipc	a4,0x1d
    8000941e:	be670713          	addi	a4,a4,-1050 # 80026000 <disk>
    80009422:	6789                	lui	a5,0x2
    80009424:	97ba                	add	a5,a5,a4
    80009426:	6398                	ld	a4,0(a5)
    80009428:	fd842783          	lw	a5,-40(s0)
    8000942c:	0792                	slli	a5,a5,0x4
    8000942e:	97ba                	add	a5,a5,a4
    80009430:	4705                	li	a4,1
    80009432:	c798                	sw	a4,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80009434:	0001d717          	auipc	a4,0x1d
    80009438:	bcc70713          	addi	a4,a4,-1076 # 80026000 <disk>
    8000943c:	6789                	lui	a5,0x2
    8000943e:	97ba                	add	a5,a5,a4
    80009440:	6398                	ld	a4,0(a5)
    80009442:	fd842783          	lw	a5,-40(s0)
    80009446:	0792                	slli	a5,a5,0x4
    80009448:	97ba                	add	a5,a5,a4
    8000944a:	4709                	li	a4,2
    8000944c:	00e79623          	sh	a4,12(a5) # 200c <_entry-0x7fffdff4>
  disk.desc[idx[2]].next = 0;
    80009450:	0001d717          	auipc	a4,0x1d
    80009454:	bb070713          	addi	a4,a4,-1104 # 80026000 <disk>
    80009458:	6789                	lui	a5,0x2
    8000945a:	97ba                	add	a5,a5,a4
    8000945c:	6398                	ld	a4,0(a5)
    8000945e:	fd842783          	lw	a5,-40(s0)
    80009462:	0792                	slli	a5,a5,0x4
    80009464:	97ba                	add	a5,a5,a4
    80009466:	00079723          	sh	zero,14(a5) # 200e <_entry-0x7fffdff2>

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000946a:	fc843783          	ld	a5,-56(s0)
    8000946e:	4705                	li	a4,1
    80009470:	c3d8                	sw	a4,4(a5)
  disk.info[idx[0]].b = b;
    80009472:	fd042783          	lw	a5,-48(s0)
    80009476:	0001d717          	auipc	a4,0x1d
    8000947a:	b8a70713          	addi	a4,a4,-1142 # 80026000 <disk>
    8000947e:	20078793          	addi	a5,a5,512
    80009482:	0792                	slli	a5,a5,0x4
    80009484:	97ba                	add	a5,a5,a4
    80009486:	fc843703          	ld	a4,-56(s0)
    8000948a:	f798                	sd	a4,40(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    8000948c:	fd042603          	lw	a2,-48(s0)
    80009490:	0001d717          	auipc	a4,0x1d
    80009494:	b7070713          	addi	a4,a4,-1168 # 80026000 <disk>
    80009498:	6789                	lui	a5,0x2
    8000949a:	97ba                	add	a5,a5,a4
    8000949c:	6794                	ld	a3,8(a5)
    8000949e:	0001d717          	auipc	a4,0x1d
    800094a2:	b6270713          	addi	a4,a4,-1182 # 80026000 <disk>
    800094a6:	6789                	lui	a5,0x2
    800094a8:	97ba                	add	a5,a5,a4
    800094aa:	679c                	ld	a5,8(a5)
    800094ac:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    800094b0:	2781                	sext.w	a5,a5
    800094b2:	8b9d                	andi	a5,a5,7
    800094b4:	2781                	sext.w	a5,a5
    800094b6:	03061713          	slli	a4,a2,0x30
    800094ba:	9341                	srli	a4,a4,0x30
    800094bc:	0786                	slli	a5,a5,0x1
    800094be:	97b6                	add	a5,a5,a3
    800094c0:	00e79223          	sh	a4,4(a5)

  __sync_synchronize();
    800094c4:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800094c8:	0001d717          	auipc	a4,0x1d
    800094cc:	b3870713          	addi	a4,a4,-1224 # 80026000 <disk>
    800094d0:	6789                	lui	a5,0x2
    800094d2:	97ba                	add	a5,a5,a4
    800094d4:	679c                	ld	a5,8(a5)
    800094d6:	0027d703          	lhu	a4,2(a5) # 2002 <_entry-0x7fffdffe>
    800094da:	0001d697          	auipc	a3,0x1d
    800094de:	b2668693          	addi	a3,a3,-1242 # 80026000 <disk>
    800094e2:	6789                	lui	a5,0x2
    800094e4:	97b6                	add	a5,a5,a3
    800094e6:	679c                	ld	a5,8(a5)
    800094e8:	2705                	addiw	a4,a4,1
    800094ea:	1742                	slli	a4,a4,0x30
    800094ec:	9341                	srli	a4,a4,0x30
    800094ee:	00e79123          	sh	a4,2(a5) # 2002 <_entry-0x7fffdffe>

  __sync_synchronize();
    800094f2:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800094f6:	100017b7          	lui	a5,0x10001
    800094fa:	05078793          	addi	a5,a5,80 # 10001050 <_entry-0x6fffefb0>
    800094fe:	0007a023          	sw	zero,0(a5)

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80009502:	a819                	j	80009518 <virtio_disk_rw+0x34e>
    sleep(b, &disk.vdisk_lock);
    80009504:	0001f597          	auipc	a1,0x1f
    80009508:	c2458593          	addi	a1,a1,-988 # 80028128 <disk+0x2128>
    8000950c:	fc843503          	ld	a0,-56(s0)
    80009510:	ffffa097          	auipc	ra,0xffffa
    80009514:	fd0080e7          	jalr	-48(ra) # 800034e0 <sleep>
  while(b->disk == 1) {
    80009518:	fc843783          	ld	a5,-56(s0)
    8000951c:	43dc                	lw	a5,4(a5)
    8000951e:	873e                	mv	a4,a5
    80009520:	4785                	li	a5,1
    80009522:	fef701e3          	beq	a4,a5,80009504 <virtio_disk_rw+0x33a>
  }

  disk.info[idx[0]].b = 0;
    80009526:	fd042783          	lw	a5,-48(s0)
    8000952a:	0001d717          	auipc	a4,0x1d
    8000952e:	ad670713          	addi	a4,a4,-1322 # 80026000 <disk>
    80009532:	20078793          	addi	a5,a5,512
    80009536:	0792                	slli	a5,a5,0x4
    80009538:	97ba                	add	a5,a5,a4
    8000953a:	0207b423          	sd	zero,40(a5)
  free_chain(idx[0]);
    8000953e:	fd042783          	lw	a5,-48(s0)
    80009542:	853e                	mv	a0,a5
    80009544:	00000097          	auipc	ra,0x0
    80009548:	b6c080e7          	jalr	-1172(ra) # 800090b0 <free_chain>

  release(&disk.vdisk_lock);
    8000954c:	0001f517          	auipc	a0,0x1f
    80009550:	bdc50513          	addi	a0,a0,-1060 # 80028128 <disk+0x2128>
    80009554:	ffff8097          	auipc	ra,0xffff8
    80009558:	d7e080e7          	jalr	-642(ra) # 800012d2 <release>
}
    8000955c:	0001                	nop
    8000955e:	70e2                	ld	ra,56(sp)
    80009560:	7442                	ld	s0,48(sp)
    80009562:	6121                	addi	sp,sp,64
    80009564:	8082                	ret

0000000080009566 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80009566:	1101                	addi	sp,sp,-32
    80009568:	ec06                	sd	ra,24(sp)
    8000956a:	e822                	sd	s0,16(sp)
    8000956c:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    8000956e:	0001f517          	auipc	a0,0x1f
    80009572:	bba50513          	addi	a0,a0,-1094 # 80028128 <disk+0x2128>
    80009576:	ffff8097          	auipc	ra,0xffff8
    8000957a:	cf8080e7          	jalr	-776(ra) # 8000126e <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    8000957e:	100017b7          	lui	a5,0x10001
    80009582:	06078793          	addi	a5,a5,96 # 10001060 <_entry-0x6fffefa0>
    80009586:	439c                	lw	a5,0(a5)
    80009588:	0007871b          	sext.w	a4,a5
    8000958c:	100017b7          	lui	a5,0x10001
    80009590:	06478793          	addi	a5,a5,100 # 10001064 <_entry-0x6fffef9c>
    80009594:	8b0d                	andi	a4,a4,3
    80009596:	2701                	sext.w	a4,a4
    80009598:	c398                	sw	a4,0(a5)

  __sync_synchronize();
    8000959a:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    8000959e:	a855                	j	80009652 <virtio_disk_intr+0xec>
    __sync_synchronize();
    800095a0:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800095a4:	0001d717          	auipc	a4,0x1d
    800095a8:	a5c70713          	addi	a4,a4,-1444 # 80026000 <disk>
    800095ac:	6789                	lui	a5,0x2
    800095ae:	97ba                	add	a5,a5,a4
    800095b0:	6b98                	ld	a4,16(a5)
    800095b2:	0001d697          	auipc	a3,0x1d
    800095b6:	a4e68693          	addi	a3,a3,-1458 # 80026000 <disk>
    800095ba:	6789                	lui	a5,0x2
    800095bc:	97b6                	add	a5,a5,a3
    800095be:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    800095c2:	2781                	sext.w	a5,a5
    800095c4:	8b9d                	andi	a5,a5,7
    800095c6:	2781                	sext.w	a5,a5
    800095c8:	078e                	slli	a5,a5,0x3
    800095ca:	97ba                	add	a5,a5,a4
    800095cc:	43dc                	lw	a5,4(a5)
    800095ce:	fef42623          	sw	a5,-20(s0)

    if(disk.info[id].status != 0)
    800095d2:	0001d717          	auipc	a4,0x1d
    800095d6:	a2e70713          	addi	a4,a4,-1490 # 80026000 <disk>
    800095da:	fec42783          	lw	a5,-20(s0)
    800095de:	20078793          	addi	a5,a5,512
    800095e2:	0792                	slli	a5,a5,0x4
    800095e4:	97ba                	add	a5,a5,a4
    800095e6:	0307c783          	lbu	a5,48(a5)
    800095ea:	cb89                	beqz	a5,800095fc <virtio_disk_intr+0x96>
      panic("virtio_disk_intr status");
    800095ec:	00002517          	auipc	a0,0x2
    800095f0:	12c50513          	addi	a0,a0,300 # 8000b718 <etext+0x718>
    800095f4:	ffff7097          	auipc	ra,0xffff7
    800095f8:	68a080e7          	jalr	1674(ra) # 80000c7e <panic>

    struct buf *b = disk.info[id].b;
    800095fc:	0001d717          	auipc	a4,0x1d
    80009600:	a0470713          	addi	a4,a4,-1532 # 80026000 <disk>
    80009604:	fec42783          	lw	a5,-20(s0)
    80009608:	20078793          	addi	a5,a5,512
    8000960c:	0792                	slli	a5,a5,0x4
    8000960e:	97ba                	add	a5,a5,a4
    80009610:	779c                	ld	a5,40(a5)
    80009612:	fef43023          	sd	a5,-32(s0)
    b->disk = 0;   // disk is done with buf
    80009616:	fe043783          	ld	a5,-32(s0)
    8000961a:	0007a223          	sw	zero,4(a5)
    wakeup(b);
    8000961e:	fe043503          	ld	a0,-32(s0)
    80009622:	ffffa097          	auipc	ra,0xffffa
    80009626:	f82080e7          	jalr	-126(ra) # 800035a4 <wakeup>

    disk.used_idx += 1;
    8000962a:	0001d717          	auipc	a4,0x1d
    8000962e:	9d670713          	addi	a4,a4,-1578 # 80026000 <disk>
    80009632:	6789                	lui	a5,0x2
    80009634:	97ba                	add	a5,a5,a4
    80009636:	0207d783          	lhu	a5,32(a5) # 2020 <_entry-0x7fffdfe0>
    8000963a:	2785                	addiw	a5,a5,1
    8000963c:	03079713          	slli	a4,a5,0x30
    80009640:	9341                	srli	a4,a4,0x30
    80009642:	0001d697          	auipc	a3,0x1d
    80009646:	9be68693          	addi	a3,a3,-1602 # 80026000 <disk>
    8000964a:	6789                	lui	a5,0x2
    8000964c:	97b6                	add	a5,a5,a3
    8000964e:	02e79023          	sh	a4,32(a5) # 2020 <_entry-0x7fffdfe0>
  while(disk.used_idx != disk.used->idx){
    80009652:	0001d717          	auipc	a4,0x1d
    80009656:	9ae70713          	addi	a4,a4,-1618 # 80026000 <disk>
    8000965a:	6789                	lui	a5,0x2
    8000965c:	97ba                	add	a5,a5,a4
    8000965e:	0207d683          	lhu	a3,32(a5) # 2020 <_entry-0x7fffdfe0>
    80009662:	0001d717          	auipc	a4,0x1d
    80009666:	99e70713          	addi	a4,a4,-1634 # 80026000 <disk>
    8000966a:	6789                	lui	a5,0x2
    8000966c:	97ba                	add	a5,a5,a4
    8000966e:	6b9c                	ld	a5,16(a5)
    80009670:	0027d783          	lhu	a5,2(a5) # 2002 <_entry-0x7fffdffe>
    80009674:	0006871b          	sext.w	a4,a3
    80009678:	2781                	sext.w	a5,a5
    8000967a:	f2f713e3          	bne	a4,a5,800095a0 <virtio_disk_intr+0x3a>
  }

  release(&disk.vdisk_lock);
    8000967e:	0001f517          	auipc	a0,0x1f
    80009682:	aaa50513          	addi	a0,a0,-1366 # 80028128 <disk+0x2128>
    80009686:	ffff8097          	auipc	ra,0xffff8
    8000968a:	c4c080e7          	jalr	-948(ra) # 800012d2 <release>
}
    8000968e:	0001                	nop
    80009690:	60e2                	ld	ra,24(sp)
    80009692:	6442                	ld	s0,16(sp)
    80009694:	6105                	addi	sp,sp,32
    80009696:	8082                	ret
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
