[org 0x7c00]
	[bits 16]


	mov bp, 0x8000
	mov sp, bp ;init stack at 0x8000

	mov dx, 0xdead
	call printhex
	call newline
	mov dx, 0xbeef
	call printhex

	cli
	lgdt [gdtdescriptor]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	jmp codeseg:startptcmode

	%include "print.asm"
	%include "bootstrapper.asm"
	%include "GDT.asm"

	[bits 32]


startptcmode:

	mov ax, dataseg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000 ;far, far away
	mov esp, ebp

	mov ebx, hello
	call bleachscreen
	call printstring32

	jmp $;loop forever

	%include "print32.asm"
hello:
	db "Hello World!",0
bootdrive:
	db 0

	; Fill with 510 zeros minus the size of the previous code
	times 510-($-$$) db 0
	; Magic number
	dw 0xaa55
