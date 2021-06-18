bits 16
org 0x7c00

boot:
	mov ax, 0x2401
	int 0x15

	mov ax, 0x3
	int 0x10

	mov [disk], dl

	mov ah, 0x2 		; read sectors
	mov al, 1 		; number of sectors to read
	mov ch, 0 		; cylinder idx
	mov dh, 0 		; head idx
	mov cl, 2 		; sector idx
	mov dl, [disk] 		; disk idx
	mov bx, copy_target 	; target pointer
	int 0x13

	; Set up 32 bits protected mode
	cli
	lgdt [gdt_pointer]
	mov eax, cr0
	or eax,0x1
	mov cr0, eax
	mov ax, DATA_SEG
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	jmp CODE_SEG:boot2

gdt_start:
	dq 0x0
gdt_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
gdt_data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:
gdt_pointer:
	dw gdt_end - gdt_start
	dd gdt_start

disk:
	db 0x0

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

; Pad to 510 bytes and add the magic bytes 0xaa55 to mark sector as bootable
times 510 - ($-$$) db 0
dw 0xaa55

copy_target:
bits 32

boot2:
	cli
