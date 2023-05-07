C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_SOURCES:.c=.o}

all: os-image

run: all
	qemu-system-x86_64 -hda os-image

os-image: boot/boot.bin kernel/kernel.bin
	cat $^ > $@

kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

boot/boot.bin: boot/boot.asm
	cd boot && nasm -f bin boot.asm -o boot.bin

kernel/kernel.o: kernel/kernel.c
	gcc -m32 -ffreestanding -c $< -o $@

kernel/kernel_entry.o: kernel/kernel_entry.asm
	nasm -f elf32 $< -o $@

%.o: %.c
	gcc -m32 -ffreestanding -c $< -o $@

clean:
	rm kernel/*.bin kernel/*.o boot/*.bin boot/*.o