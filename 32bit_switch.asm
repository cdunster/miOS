[bits 16]
switch_to_32:
    cli                     ; Disable interrupts.
    lgdt [gdt_descriptor]   ; Load GDT descriptor.

    ; Set 32-bit mode in cr0
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_32    ; Far jump using different segment.

[bits 32]
init_32:
    ; Update segment registers.
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Update stack.
    mov ebp, 0x90000
    mov esp, ebp

    call begin_32
