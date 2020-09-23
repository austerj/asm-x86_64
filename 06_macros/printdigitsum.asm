%macro exit 0
        mov rax, 60 ; sys_exit syscall
        mov rdi, 0  ; no error
        syscall     ; call sys_exit
%endmacro

%macro printDigitSum 2
    mov rax, %1         ; move arg1 to rax
    add rax, %2         ; add arg2 to rax
    call _printRAXDigit ; print arg
%endmacro

section .data
        digit db 0,10

section .text
        global _start

_start:
        printDigitSum 3, 2
        exit

_printRAXDigit:
        add rax, 48     ; add 48 to get ASCII char
        mov [digit], al ; load lower byte into digit
        mov rax, 1      ; sys_write syscall
        mov rdi, 1      ; standard output
        mov rsi, digit  ; load digit pointer
        mov rdx, 2      ; length of digit + newline
        syscall         ; call sys_Write
        ret
