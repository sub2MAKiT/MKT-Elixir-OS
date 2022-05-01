addAlToRenderBufferMKT: ; al - character, ah - is highlighted, ebx - empty, ecx - empty
    cmp si, 0
    jne addAlToRenderBuffer    
    ret

addAlToRenderBuffer:
    dec si
    mov ecx, [renderBufferOffset]
    cmp ecx, 4000
    jae resetRenderBufferOffset
    mov ebx, 0x10000
    cmp ah, 0
    jne writeHighValueToRenderBuffer
    jmp writeLowValueToRenderBuffer

writeHighValueToRenderBuffer:
    or al, 128
    add ebx, ecx
    mov [ebx], al
    jmp returnTheRenderBufferFuntion

writeLowValueToRenderBuffer:
    and al, 127
    add ebx, ecx
    mov [ebx], al
    jmp returnTheRenderBufferFuntion

resetRenderBufferOffset:
    mov cx, 0
    mov [renderBufferOffset], cx
    mov ecx, 4001
    jmp addAlToRenderBufferMKT

returnTheRenderBufferFuntion:
    jmp addAlToRenderBufferMKT

renderBufferOffset dw 0





addStringToRenderBufferMKT: ; al - empty, ah - is highlighted, ebx - pointer to string, ecx - empty, di - empty
    mov edi, ebx
    cmp ah, 0
    je addStringToRenderBufferMKTLoopLow
    jmp addStringToRenderBufferMKTLoopHigh

addStringToRenderBufferMKTLoopLow:
    cmp al, 0
    je returnCall
    mov al, [ebx]
    mov ecx, [renderBufferOffset]
    mov ebx, 0x10000
    add ebx, ecx
    mov [ebx], al
    inc di
    mov ebx, edi
    inc ecx
    mov [renderBufferOffset], ecx
    cmp ecx, 4000
    je checkForBufferOverflowAddStringToRenderBufferMKTLoopLow
    jmp addStringToRenderBufferMKTLoopLow
    
addStringToRenderBufferMKTLoopHigh:
    cmp al, 0
    je returnCall
    mov al, [ebx]
    or al, 128
    mov ecx, [renderBufferOffset]
    mov ebx, 0x10000
    add ebx, ecx
    mov [ebx], al
    inc di
    mov ebx, edi
    inc ecx
    mov [renderBufferOffset], ecx
    cmp ecx, 4000
    je checkForBufferOverflowAddStringToRenderBufferMKTLoopHigh
    jmp addStringToRenderBufferMKTLoopHigh
    
checkForBufferOverflowAddStringToRenderBufferMKTLoopHigh:
    mov ecx, 0
    mov [renderBufferOffset], ecx
    jmp addStringToRenderBufferMKTLoopHigh

checkForBufferOverflowAddStringToRenderBufferMKTLoopLow:
    mov ecx, 0
    mov [renderBufferOffset], ecx
    jmp addStringToRenderBufferMKTLoopLow