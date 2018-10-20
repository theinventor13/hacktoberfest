gdtstart:

gdtnull:
	dd 0x0
	dd 0x0
gdtcode:
	dw 0xffff 
	dw 0x0 
	db 0x0
	db 10011010b
	db 11001111b 
	db 0x0 
gdtdata :
	dw 0xffff 
	dw 0x0 
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0 
gdtend : 
gdtdescriptor:
	dw gdtend - gdtstart - 1 
	dd gdtstart 
codeseg equ gdtcode - gdtstart
dataseg equ gdtdata - gdtstart
