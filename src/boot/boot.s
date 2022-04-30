[org 0x7c00] ; or mov ds, 0x7c00
mov si, bootUpString
mov di, 0
mov bp, 0x8000
mov sp, bp
jmp finishBootUp

finishBootUp:
    call printm
    jmp menu


menu:
%include "./src/boot/menu.s"

textEditor:
%include "./src/optionText/text.s"


bootUpString db 'Welcome to MAKiT E', 0

returnCall:
    ret

printm:
    mov bx, si
    add bx, di
    mov al, [bx]
    inc di
    mov bl, [displaymode]
    cmp al, 0
    je returnCall
    mov ah, 0x09            ; int 10h 'print char' function
    mov bh, 0x00
    mov cx, 0x01
    int 0x10
    mov bh, 0x00
    mov ah, 0x03
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    inc dl
    int 0x10
    jmp printm

exit:

jmp $
times 510-($-$$) db 0
db 0x55, 0xaa