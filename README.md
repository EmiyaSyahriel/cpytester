# cpytester
Just a simple testing repository to test various way to copy data between memories across Linux machines.

## Requirements
- gcc
- g++
- clang
- clang++
- GNU make

## Usage
### By compilation
```bash
git clone https://github.com/EmiyaSyahriel/cpytester
cd cpytester
make test
```
### Entry point
```
./bin/entry.elf [library name]
```

The entry file will load the library name, find an exported symbol named `memcpy_impl`, test how much the function needs to run and print the result to terminal.
### Creating an implementation test
Implementation cases binary files must export single function with this signature:
```c
void* memcpy_impl(int* a, int* b, int count);
```
Any kind of language is acceptable, as long as it can be loaded by the entry point

## License
CC0 1.0 Universal - See [LICENSE](License)
