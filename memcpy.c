#include <string.h>
// For loop using pointer arithmetic
void *memcpy_impl(int *dst, int *src, int count)
{
    return memcpy(dst, src, count * sizeof(int));
}