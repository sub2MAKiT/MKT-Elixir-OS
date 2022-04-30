textEditor:
jmp keyToAl

printStringStack:
    mov dl, 1
    mov si, $0
    jmp printStringLoopStack

printStringLoopStack:
    mov bx, bp
    inc si
    inc si   
    sub bx, si
    mov al, [bx]
    cmp bx, sp
    jl keyToAl
    mov ah, 0x09
    mov bh, 0x00
    mov bl, [displaymode]
    mov cx, 0x01
    int 0x10
    mov bh, 0x00
    mov ah, 0x03
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    inc dl
    int 0x10
    jmp printStringLoopStack

keyToAl:
    mov ah, 0
    int 0x16
    mov [currentChar], al
    mov bl, [currentChar]
    push bx
    cmp bl, $8
    jne clsLabel
    pop bx
    mov bx, sp
    inc bx
    inc bx
    cmp bp, bx
    je clsLabel
    pop bx
    jmp clsLabel

clsLabel:
    call cls
    mov si, bp
    jmp printStringStack

cls:
    pusha
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    mov bh, 0x00
    mov dh, 0x00
    mov dl, 0x00
    mov ah, 0x02
    int 0x10
    popa
    ret

currentChar:
    db 0