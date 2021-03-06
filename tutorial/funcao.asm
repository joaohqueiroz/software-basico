;Funcoes que incrementam em 1 o valor de v1

section .data
    SYS_EXIT    equ 1
    RET_EXIT    equ 5
    SYS_READ    equ 3
    SYS_WRITE   equ 4
    STD_IN      equ 0
    STD_OUT     equ 1
    MAX_IN      equ 10

    v1 dw '1241', 0xA

section .bss
    buffer resb 10

section .text

    global _start

    _start:
        call incrementarValor
        call mostrarValor

    _exit:
        mov eax, SYS_EXIT
        int 0x80

    incrementarValor:
        lea esi, [v1]
        mov ecx, 4      ;tem que mudar esse 4 se mudar o numero de caracteres da string
        call strToInt
        add eax, 1
        lea esi, [buffer]
        call intToStr
        ret

    ;Converte string para inteiro
    ;Entrada: ESI ECX
    ;Saida EAX com o valor
    strToInt:
        xor ebx, ebx
    .prox_digito:
        movzx eax, byte[esi]
        inc esi
        sub al, '0'
        imul ebx, 10
        add ebx, eax        ;ebx = ebx*10 + eax
        loop .prox_digito   ;while ecx
        mov eax, ebx
        ret

    ;Converte inteiro para string
    ;Entrada: EAX ESI
    ;Saida EAX
    intToStr:
        add esi, 9    ;converte inteiro para string de novo
        mov byte[esi], 0
        mov ebx, 10
        .prox_digito:
            xor edx, edx
            div ebx
            add dl, '0'
            dec esi
            mov [esi], dl
            test eax, eax
            jnz .prox_digito    ; until eax == 0
            mov eax, esi
            ret

    ;Imprime o valor na tela
    mostrarValor:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        mov ecx, buffer
        mov edx, 10
        int 0x80
        ret
