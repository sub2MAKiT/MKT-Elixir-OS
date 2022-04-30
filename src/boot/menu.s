menu:
    mov ah, 0
    int 0x16
    call cls
    jmp drawMenu
    jmp menu

drawMenu:
    mov si, [screenSize]
    call drawSpaces
    jmp drawImportantMenu

drawImportantMenu:
    mov si, 5
    call drawSpaces
    mov si, textEditorString
    mov di, 0
    call printm
    mov si, 4
    call drawSpaces
    mov si, fileExplorerString
    mov di, 0
    call printm
    mov si, 4
    call drawSpaces
    mov si, webBrowserString
    mov di, 0
    call printm
    mov si, 4
    call drawSpaces
    mov si, gameNameString
    mov di, 0
    call printm
    mov si, 4
    call drawSpaces
    mov si, calculatorString
    mov di, 0
    call printm
    mov si, 6
    call drawSpaces
    jmp textEditor

drawLowMenu:
    mov si, [screenSize]
    call drawSpaces
    jmp menu

drawSpaces:
    mov ah, 0x03
    mov bh, 0x00
    int 0x10
    jmp drawSpacesLoopCheck

drawSpacesLoopCheck:
    mov cx, 1
    cmp dl, [screenWidth]
    jne drawSpacesLoop
    mov dl, 0
    inc dh
    jmp drawSpacesLoop

drawSpacesLoop:
    cmp si, 0
    jne drawImportantSpaces
    ret

drawImportantSpaces:
    mov ah, 0x09
    mov al, 0x20
    mov bh, 0x00
    mov bl, [displaymode]
    int 0x10
    mov ah, 0x02
    mov bh, 0x00
    inc dl
    int 0x10
    dec si
    jmp drawSpaces

; options
textEditorString db 'text editor', 0 ;11
fileExplorerString db 'file explorer', 0;13
webBrowserString db 'MKT web browser',0;15
gameNameString db 'Game',0;4
calculatorString db 'calculator',0;10


screenSize db 928
screenWidth db 80
screenHeight db 12
displaymode db 201
displayModeHigh db 150
displayModeLow db 201