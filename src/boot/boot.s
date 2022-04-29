[org 0x7c00]
mov ah, 0x0e
; printBootString:
;     mov al, [bx]
;     cmp al, 0
;     je keyToAl
;     int 0x10
;     inc bx
;     jmp printBootString
mov bp, 0x8000
mov sp, bp

jmp keyToAl

printString:
    mov ah, 0x0e
    mov si, $0
    jmp printStringLoop

printStringLoop:
    mov bx, bp
    inc si
    inc si   
    inc si    
    inc si
    sub bx, si
    cmp bx, sp
    jl keyToAl
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    jmp printStringLoop

keyToAl:
    mov ah, $0
    int 0x16
    mov [currentChar], al
    mov bl, [currentChar]
    push ebx
    cmp bl, $8
    jne clsLabel
    pop ebx
    mov bx, sp
    inc bx
    inc bx
    inc bx
    inc bx
    cmp bp, bx
    je clsLabel
    pop ebx
    jmp clsLabel

printCurrentChar:
    mov ah, 0x0e
    mov al, [currentChar]
    int 0x10
    jmp keyToAl

end:

clsLabel:
    call cls
    jmp printString

cls:
    pusha
    mov ah, 0x00
    mov al, 0x03  ; text mode 80x25 16 colours
    int 0x10
    popa
    ret


bootUpString db "Welcome to MAKiT E", 0


currentChar:
    db 0

jmp $
times 510-($-$$) db 0
db 0x55, 0xaa