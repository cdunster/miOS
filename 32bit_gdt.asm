gdt_start:
gdt_null:           ; Mandatory null descriptor.
    dq 0

gdt_code:           ; Code segment descriptor.
    dw 0xFFFF       ; Limit (bits 0-15).
    dw 0            ; Base (bits 0-15).
    db 0            ; Base (bits 16-23).
    db 10011010b    ; (present)1, (privilege)00, (descriptor type)1, (code)1, (conforming)0, (readable)1, (accessed)0.
    db 11001111b    ; (granularity)1, (32-bit default)1, (64-bit seg)0, (AVL)0, limit (bits 16-19).
    db 0            ; Base (bits 24-31).

gdt_data:           ; Data segment descriptor.
    dw 0xFFFF       ; Limit (bits 0-15).
    dw 0            ; Base (bits 0-15).
    db 0            ; Base (bits 16-23).
    db 10010010b    ; (present)1, (privilege)00, (descriptor type)1, (code)0, (expand down)0, (writable)1, (accessed)0.
    db 11001111b    ; (granularity)1, (32-bit default)1, (64-bit seg)0, (AVL)0, limit (bits 16-19).
    db 0            ; Base (bits 24-31).

gdt_end:            ; Label so assembler can calculate size of GDT.

; GDT descriptior
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT, always less one of the true size.
    dd gdt_start                ; Start address of GDT.


; Constants for segment descriptor offsets, segment registers must contain these when in protected mode.
; E.g. DS=0x10 CPU uses segment at offset 0x10 in GDT, which is the Data segment.
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
