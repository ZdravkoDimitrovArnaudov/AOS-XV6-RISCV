#ifndef _PSTAT_H_
#define _PSTAT_H_

#include "param.h"

struct pstat {
    uint64 inuse[NPROC];  
    uint64 pid[NPROC];    
    uint64 hticks[NPROC]; 
    uint64 lticks[NPROC]; 
};

#endif // _PSTAT_H_