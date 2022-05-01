; ; [org 0x7c00] ; or mov ds, 0x7c00
; MKTKERNEL equ 0x1000
; diskNumber db 0
; mov [diskNumber], dl
; mov ah, 2 ; ah
; mov al, 2 ; number of sectors
; mov ch, 0 ; cylinder 0
; mov cl, 2 ; second sector (boot sector is = 1)
; mov dh, 0 ; head number
; mov bx, MKTKERNEL ; addres
; int 0x13

; mov ah, 0x0
; mov al, 0x3
; int 0x10

; cli
; lgdt [GDT_Descriptor]
; mov eax, cr0
; or eax, 1
; mov cr0, eax
; jmp CODE_SEG:start_protected_mode

; jmp $

[org 0x7c00]                        
MKTKERNEL equ 0x1000
                                    

mov [BOOT_DISK], dl

                                    
xor ax, ax                          
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, MKTKERNEL
mov dh, 24

mov ah, 0x02
mov al, dh 
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
mov dl, [BOOT_DISK]
int 0x13

                                    
mov ah, 0x0
mov al, 0x3
int 0x10

cli
lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

jmp $
                                    
BOOT_DISK: db 0

%include "./src/boot/gdt.s"

[bits 32]
start_protected_mode:
    mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov ebp, 0x90000		; 32 bit stack base pointer
	mov esp, ebp

    jmp MKTKERNEL

times 510-($-$$) db 0
db 0x55, 0xaa
; jmp finishBootUp
; finishBootUp:
;     call printm
;     jmp menu


; menu:
; %include "./src/boot/menu.s"

; textEditor:
; %include "./src/optionText/text.s"


; bootUpString db 'Welcome to MAKiT E', 0

; returnCall:
;     ret

; printm:
;     mov di, 0
;     jmp printmLoop

; printmLoop:
;     mov bx, si
;     add bx, di
;     mov al, [bx]
;     inc di
;     mov bl, [displaymode]
;     cmp al, 0
;     je returnCall
;     mov ah, 0x09            ; int 10h 'print char' function
;     mov bh, 0x00
;     mov cx, 0x01
;     int 0x10
;     mov bh, 0x00
;     mov ah, 0x03
;     int 0x10
;     mov ah, 0x02
;     mov bh, 0x00
;     inc dl
;     int 0x10
;     jmp printmLoop

; exit: