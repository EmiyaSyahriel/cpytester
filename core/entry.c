#include <dlfcn.h>
#include <stdio.h>
#include <linux/time.h>

void* nullptr = (void*)0;
void* handle = (void*)0;
void* (* memcpy_impl)(int* dst, int* src, int count);

int main(int argc, const char** argv)
{
    if(argc <= 1)
    {
        printf("usage : %s [library.so]\n", argv[0]);
        return 4;
    }
    handle = dlopen(argv[1], RTLD_LAZY);
    if(handle == nullptr) {
        printf("Library %s not found\n", argv[1]);
        return 1; // No library named like that
    }
    memcpy_impl = dlsym(handle, "memcpy_impl");
    if (memcpy_impl == nullptr)
    {
        printf("Method memcpy_impl not found in %s\n", argv[1]);
        return 2; // No function named like that
    }
    int a[] = {765,346,315,283};
    int b[4];
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    void* c = memcpy_impl(b,a, 4);
    if(c != (void*)b) {
        printf("Return pointer and destination pointer not the same\n");
        return 3; // Something wrong with the implementation
    }
    clock_gettime(CLOCK_MONOTONIC, &end);

    printf("%s = %lins\n", argv[1], end.tv_nsec - start.tv_nsec);
    return 0;
}
