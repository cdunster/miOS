[org 0x7C00] ; Set origin address to the expected bootloader address.

mov bp, 0x8000
mov sp, bp

mov bx, 0x9000
mov dh, 2
; BIOS sets dl to boot disk number.
call disk_load

mov dx, [0x9000] ; Retrieve first loaded word (0xDADA).
call print_hex

call print_newline

mov dx, [0x9000 + 512] ; First word from second sector read (0xFACE).
call print_hex

jmp $

%include "print.asm"
%include "disk.asm"

; Fill the rest of the bootloader area with zeros.
times 510-($-$$) db 0

; BIOS check number.
dw 0xAA55

times 256 dw 0xDADA ; Fill sector two.
times 256 dw 0xFACE ; Fill sector three.