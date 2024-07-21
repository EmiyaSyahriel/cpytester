#include <algorithm>
// For loop using pointer arithmetic
extern "C" void *memcpy_impl(int *dst, int *src, int count)
{
  std::copy(src, src + count, dst);
  return dst;
}