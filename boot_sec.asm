[org 0x7C00] ; Set origin address to the expected bootloader address.

mov ah, 0x0E ; TTY mode

mov bp, 0x8000 ; An address for the stack far away from the bootloader start address (0x7C00) so we don't get overwritten.
mov sp, bp ; Empty stack; sp points to bp.

push 'A'
push 'B'
push 'C'

; Show how the stack grows downwards.
; Can only push words so each character is offset by one word.
mov al, [0x7FFE] ; 'A'
int 0x10 ; Screen interrupt. (Print to screen).

mov al, [0x7FFC] ; 'B'
int 0x10

mov al, [0x7FFA] ; 'C'
int 0x10

; Can only pop words so use an auxiliary register so ah (TTY mode) isn't overwritten.
pop bx
mov al, bl ; Get lower byte from the pop. 'C'
int 0x10

pop bx
mov al, bl ; 'B'
int 0x10

pop bx
mov al, bl ; 'A'
int 0x10

jmp $ ; Jump here. (Infinite loop).

; Fill the rest of he bootloader area with zeros.
times 510-($-$$) db 0

; BIOS check number.
dw 0xAA55
