GCC := /usr/bin/gcc
CLANG := /usr/bin/clang
GXX := /usr/bin/g++
CLANGXX := /usr/bin/clang++
CFLAG := -O3 -fPIE

define testfn
	./bin/entry.elf ./bin/$(1).so
endef

define checkbin
	if ! [ -d "./bin" ]; then mkdir "./bin"; fi
endef

.PHONY: all test

all : ./bin/entry.elf ./bin/forloopa_gcc.so ./bin/forloopp_gcc.so ./bin/memcpy_gcc.so ./bin/stdcopy_gcc.so ./bin/forloopa_clang.so ./bin/forloopp_clang.so ./bin/memcpy_clang.so ./bin/stdcopy_clang.so

test : all
	echo "\n ==== Testing session begins"
	@$(call testfn,forloopa_gcc)
	@$(call testfn,forloopp_gcc)
	@$(call testfn,memcpy_gcc)
	@$(call testfn,stdcopy_gcc)
	@$(call testfn,forloopa_clang)
	@$(call testfn,forloopp_clang)
	@$(call testfn,memcpy_clang)
	@$(call testfn,stdcopy_clang)

./bin/%.elf : ./core/%.c
	@$(call checkbin)
	$(GCC) -o $@ $(CFLAG) -ldl $<
	strip -x $@

./bin/%_clang.so : ./tests/%.c
	@$(call checkbin)
	$(CLANG) -o $@ $(CFLAG) -shared $<
	strip -x $@

./bin/%_gcc.so : ./tests/%.c
	@$(call checkbin)
	$(GCC) -o $@ $(CFLAG) -shared $<
	strip -x $@

./bin/%_clang.so : ./tests/%.cpp
	@$(call checkbin)
	$(CLANGXX) -o $@ $(CFLAG) -shared $<
	strip -x $@

./bin/%_gcc.so : ./tests/%.cpp
	$(GXX) -o $@ $(CFLAG) -shared $<
	strip -x $@