#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

uint64
sys_clone (void)
{
  uint64 stack;
  uint64 arg;
  uint64 fcn;

   //obtenemos puntero función
   if(argaddr(0, &fcn) < 0){
     return -1;
   }

   //obtenemos puntero a argumento de función
   if(argaddr(1, &arg) < 0){
     return -1;
   }

   //obtenemos putnero a stack de usuario
   if(argaddr(2, &stack) < 0){
     return -1;
   }

  struct proc *p = myproc();
  uint64 sz = p->sz;

   //comprobamos que stack este alineado a pagina
   if ((stack % PGSIZE) != 0 || ((sz - stack) < PGSIZE)){
     return -1;
   }

  return clone((void *)fcn, (void *)arg, (void *)stack);
}

uint64
sys_join (void)
{
  uint64 stack;
  if(argaddr(0, &stack) < 0){
     printf ("SYSPROC: argumento no valido\n");
     return -1;
  }

  printf ("SYSPROC: lo que vale stack es: %d\n", stack);

  if (stack % 4 != 0){
    printf ("SYSPROC: Dirección no alineada a word\n");
    return -1;
  }

  //hay que comprobar que en la dirección hay algo (aqui o en proc.c)

  return join (stack);
}


uint64
sys_exit(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  if(argaddr(0, &p) < 0)
    return -1;
  return wait(p);
}

uint64
sys_sbrk(void)
{
  int addr;
  int n;
  int referencias;

  if(argint(0, &n) < 0)
    return -1;


  /*Cuando tenemos thrads, realizaremos la misma operación con sbrk.
  El proceso consiste en que desde el proceso padre, se alocata la pagina física
  y se mapea en el resto de threads hijos recursivos (solucionado por el ASID).
  */
  
  struct proc *p = myproc();
  struct proc *proceso_padre_threads;
  //tenemos que determinar si somos el proceso padre o thread


  if (p->thread == 0){ //soy proceso
    
    addr = p->sz;
    if(growproc(n) < 0){
      return -1;
    }

    proceso_padre_threads = p;
    referencias = p->referencias;


  } else { //soy thread hijo

      //tengo que buscar al proceso padre o abuelo, bisabuelo... propietario del espacio de direcciones con ASID = pid

      struct proc *proceso;
       if ((proceso = busca_padre(p->ASID)) == 0);

      addr = proceso->sz;
      if(growproc_proceso_padre(n, proceso) < 0){
        return -1;
      }

      proceso_padre_threads = proceso;
      referencias = proceso->referencias;
    
  }


  /*
    Si el padre tiene threads, también deben extenderse.
    Para hacerlo, simplemente con la dirección fisica del proceso padre mapeamos 
    la nueva extensión en los hijos.

    No usamos growproc con el resto de procesos porque entonces estaríamos alocatando más 
    páginas fisicas.

    De nuevo, si lo ejecuta un thread, debe pasar el puntero del padre proceso.
  */

  if ((n > 0 && referencias > 0) || p->thread == 1){ //O el proceso que ejecuta sbrk tiene más de una referencia o es un thread, alocatamos y mapeamos del padre a todos los procesos hijo
    if ((check_grow_threads (proceso_padre_threads, n,addr))<0){
      return -1;
    }

  }

  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
