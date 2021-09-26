#include "types.h"
#include "user.h"

int main(void) {
    printf(1, "El número de procesos en este momento son: %d\n", getprocs());
    exit();
}
