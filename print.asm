

newline:
	push ax
	mov ah, 0x0e
	mov al, 0xA
	int 0x10
	mov al, 0xD
	int 0x10
	pop ax
	ret

printstring:
	pusha ;preserve regs
	mov ah, 0x0e ;load interrupt code
prntstriter:
	mov al, BYTE[bx] ;load byte of string into al
	or al, al ;check for 0 byte
	jz prntstrend
	int 0x10 ;call char print interrupt
	add bx, 1 ;increment string pointer
	jmp prntstriter
	prntstrend:
	popa ;restore regs
	ret ;exit function

printhex:
	pusha
	;this is an unrolled loop
	;it works from lsb to msb
	;rotate to and mask out everything but current byte
	;add to hexkey to index into ascii hex value map
	;copy to corresponding byte in hex display string 
	mov bx, dx 
	and bx, 0x000f
	add bx, hexkey
	mov al, [bx]
	mov [hextemp + 5], al;least significant byte
	shr dx, 4
	mov bx, dx 
	and bx, 0x000f
	add bx, hexkey
	mov al, [bx]
	mov [hextemp + 4], al
	shr dx, 4
	mov bx, dx 
	and bx, 0x000f
	add bx, hexkey
	mov al, [bx]
	mov [hextemp + 3], al
	shr dx, 4
	mov bx, dx 
	and bx, 0x000f
	add bx, hexkey
	mov al, [bx]
	mov [hextemp + 2], al;most significant byte
	mov bx, hextemp
	call printstring
	popa
	ret
hextemp:
	db "0x0000",0
hexkey:
	db "0123456789ABCDEF"
