// For loop using pointer arithmetic
void *memcpy_impl(int *dst, int *src, int count)
{
    void* rv = dst;
    for(int i =0 ; i < count; i++)
    {
        *(dst + i) = *(src + i);
    }
    return rv;
}