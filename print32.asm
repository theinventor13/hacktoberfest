[bits 32]

vram equ 0xb8000
white_black equ 0x0f
cyan_lime equ 0x32

printstring32:
	pusha ;preserve regs
	mov edx, vram ;load vram address
	mov ah, white_black ;white text on black background
prntstriter32:
	mov al, BYTE[ebx] ;load byte of string into al
	or al, al ;check for end of string 
	jz prntstrend32
	mov WORD[edx], ax
	add ebx, 1 ;increment string pointer
	add edx, 2 ;increment vram pointer
	jmp prntstriter32 
prntstrend32:
	popa ;restore regs
	ret ;exit function

bleachscreen:
	pusha
	mov edx, vram + ((80 * 25) * 2) - 2; point to last byte of vram
	mov ah, cyan_lime ;nauseating cyan on lime so we can easily spot our text
	mov al, "k" ;just because
bleachloop:
	mov WORD[edx], ax;load current index with blue on green k
	dec edx 
	dec edx ;decrease edx 2 times, 2 bytes
	cmp edx, vram ;are we at the beginning?
	jge bleachloop;if not, do it again
	popa
	ret
