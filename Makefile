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
	@$(call testfn,forloopa_gcc)
	@$(call testfn,forloopp_gcc)
	@$(call testfn,memcpy_gcc)
	@$(call testfn,stdcopy_gcc)
	@$(call testfn,forloopa_clang)
	@$(call testfn,forloopp_clang)
	@$(call testfn,memcpy_clang)
	@$(call testfn,stdcopy_clang)

./bin/%.elf : ./%.c
	@$(call checkbin)
	$(GCC) -o $@ $(CFLAG) -ldl $<
	strip -x $@

./bin/%_clang.so : ./%.c
	@$(call checkbin)
	$(CLANG) -o $@ $(CFLAG) -shared $<
	strip -x $@

./bin/%_gcc.so : ./%.c
	@$(call checkbin)
	$(GCC) -o $@ $(CFLAG) -shared $<
	strip -x $@

./bin/%_clang.so : ./%.cpp
	@$(call checkbin)
	$(CLANGXX) -o $@ $(CFLAG) -shared $<
	strip -x $@

./bin/%_gcc.so : ./%.cpp
	$(GXX) -o $@ $(CFLAG) -shared $<
	strip -x $@