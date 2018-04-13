
all:
	nasm -f bin boot_sec.asm -o out/boot_sec.bin

clean:
	rm out/boot_sec.bin