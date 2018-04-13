
all:
	nasm -f bin boot_sec.asm -o out/boot_sec.bin

clean:
	rm out/boot_sec.bin

run: all
	qemu-system-i386 out/boot_sec.bin