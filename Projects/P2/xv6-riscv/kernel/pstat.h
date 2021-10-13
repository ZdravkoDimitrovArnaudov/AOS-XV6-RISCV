#ifndef _PSTAT_H_
#define _PSTAT_H_

#include "param.h"

struct pstat {
    uint64 inuse[NPROC];  // whether this slot of the process process table is in use (1 or 0)
    uint64 pid[NPROC];    // the PID of each process
    uint64 hticks[NPROC]; // the number of ticks each process has accumulated at priority 2
    uint64 lticks[NPROC]; // the number of ticks each process has accumulated at priority 1
};

#endif // _PSTAT_H_