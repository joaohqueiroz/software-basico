; Program to print the arguments passed on it's execution

%include        'lib.asm'

section .data

section .text
global _start

_start:
    pop     ecx             ; first value on the stack is the number of arguments
    nextArg:
        cmp     ecx, 0h         ; check to see if we have any arguments left
        jz      noMoreArgs      ; if zero flag is set jump to noMoreArgs label (jumping over the end of the loop)
        pop     eax             ; pop the next argument off the stack
        call    stringPrintLF        ; call our print with linefeed function
        dec     ecx             ; decrease ecx (number of arguments left) by 1
        jmp     nextArg         ; jump to nextArg label
    
    noMoreArgs:
        call exit