section .text
    [bits 32]
    [extern main]
    call main
    [extern screenRender]
    call screenRender
    jmp $


; returnCall:
;     ret

; %include "./src/boot/options/menu.s"
; %include "./src/renderBuffer/addToRenderBuffer.s"