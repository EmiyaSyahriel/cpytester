// For loop using array access
void *memcpy_impl(int *dst, int *src, int count)
{
    for (int i = 0; i < count; i++) { dst[i] = src[i]; }
    return dst;
}