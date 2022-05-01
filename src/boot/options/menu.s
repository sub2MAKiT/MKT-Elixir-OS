menu:
    jmp drawMenu

waitMenu:
    mov ah, 0
    int 0x16
    jmp menuInputHandling

menuInputHandling:
    mov cx, [optionSelected]
    cmp ah, 0x4b ; left arrow
    je MenuMoveLeft
    cmp ah, 0x4d ; right arror
    je MenuMoveRight
    jmp waitMenu

MenuMoveRight:
    inc cx
    jmp MenuCheckForLoopRight

MenuMoveLeft:
    dec cx
    jmp MenuCheckForLoopLeft

MenuCheckForLoopLeft:
    cmp cx, 0
    jl MenuSetOptionToFour
    jmp drawMenu

MenuCheckForLoopRight:
    cmp cx, 4
    ja MenuSetOptionToZero
    jmp drawMenu

MenuSetOptionToZero:
    mov cx, 0
    jmp drawMenu

MenuSetOptionToFour:
    mov cx, 4
    jmp drawMenu

drawMenu:
    mov [optionSelected], cx
    mov si, [screenSize]
    mov al, 32
    call addAlToRenderBufferMKT
    jmp drawImportantMenu

drawImportantMenu:
    mov si, 5
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    mov bx, textEditorString
    mov di, 0
    call MenuCheckForColour
    call addStringToRenderBufferMKT
    mov si, 4
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    mov bx, fileExplorerString
    mov di, 1
    call MenuCheckForColour
    call addStringToRenderBufferMKT
    mov si, 4
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    mov bx, webBrowserString
    mov di, 2
    call MenuCheckForColour
    call addStringToRenderBufferMKT
    mov si, 4
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    mov bx, gameNameString
    mov di, 3
    call MenuCheckForColour
    call addStringToRenderBufferMKT
    mov si, 4
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    mov bx, calculatorString
    mov di, 4
    call MenuCheckForColour
    call addStringToRenderBufferMKT
    mov si, 6
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    jmp drawLowMenu
drawLowMenu:
    mov si, [screenSize]
    mov al, 32
    mov ah, 0
    call addAlToRenderBufferMKT
    jmp waitMenu

MenuCheckForColour:
    cmp di, [optionSelected]
    je MenuChangeColourActive
    cmp di, [optionSelected]
    jne MenuChangeColourPassive

MenuChangeColourActive:
    mov di, [displayModeHigh]
    mov ah, 1
    ret

MenuChangeColourPassive:
    mov di, [displayModeLow]
    mov ah, 0
    ret

; options
textEditorString db 'text editor', 0 ;11
fileExplorerString db 'file explorer', 0;13
webBrowserString db 'MKT web browser',0;15
gameNameString db 'Game',0;4
calculatorString db 'calculator',0;10

optionSelected db 0
screenSize dw 1960
screenWidth db 80
screenHeight db 12
displaymode db 201
displayModeHigh db 150
displayModeLow db 201