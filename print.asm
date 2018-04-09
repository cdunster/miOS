print_string:
    pusha

print_valid_char:
    mov al, [bx] ; Base address of "passed" string.
    cmp al, 0 
    je print_string_done

    mov ah, 0x0E ; TTY print mode.
    int 0x10

    inc bx
    jmp print_valid_char

print_string_done:
    popa
    ret


print_newline:
    pusha

    mov ah, 0x0E ; TTY print mode.
    mov al, 0x0A ; '\n'
    int 0x10
    mov al, 0x0D ; '\r'
    int 0x10

    popa
    ret


print_hex:
    pusha
    mov cx, 0 ; for-loop index

print_hex_for:
    cmp cx, 4
    je print_hex_done

    ; Convert last char of dx to ASCII.
    mov ax, dx
    and ax, 0x000F
    add al, 0x30 ; Convert to ASCII number.
    cmp al, 0x39 ; > '9'.
    jle print_hex_step_2 ; if <= '9' then move on.
    add al, 7 ; 'A' is 0x41 not 0x3A.

print_hex_step_2:
    ; Get correct index in string for the character.
    mov bx, HEX_OUT + 5 ; Base address + string length.
    sub bx, cx ; Subract current character index.
    mov [bx], al ; Copy the character to the correct position.
    ror dx, 4 ; ?????

    inc cx
    jmp print_hex_for

print_hex_done:
    mov bx, HEX_OUT
    call print_string

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; Reserved memory for new string.
