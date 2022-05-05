section .text
    [bits 32]
    [extern main]
    call main
    jmp menu

returnCall:
    ret

%include "./src/options/menu.s"