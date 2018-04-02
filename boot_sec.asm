; Infinite loop
loop:
	jmp loop

; Fill rest with zeros
times 510-($-$$) db 0

; BIOS check number
dw 0xAA55
