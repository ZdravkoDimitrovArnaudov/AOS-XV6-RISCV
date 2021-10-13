#include "../kernel/types.h"
#include "user.h"
#include "../kernel/pstat.h"


int main (void)
{
    struct pstat ps ;
    if (getpinfo(&ps) < 0){
        printf ("ERROR. La llamada ha devuelto codigo -1\n");
        exit(1);
    }

    for (int i = 0; i < NPROC; i++){
        if (ps.inuse[i]==1){
            printf ("PID:   %d; LTICKS:     %d; HTICKS:     %d\n", ps.pid[i], ps.lticks[i], ps.hticks[i]);   
        }
    }

    exit(0);
}
