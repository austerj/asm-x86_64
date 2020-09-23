STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60

%macro exit 0
        mov rax, SYS_EXIT ; sys_exit syscall
        mov rdi, 0        ; no error
        syscall           ; call sys_exit
%endmacro

%macro printDigit 1
    mov rax, %1         ; move arg to rax
    call _printRAXDigit ; print arg
%endmacro

_printRAXDigit:
        add rax, 48        ; add 48 to get ASCII char
        mov [digit], al    ; load lower byte into digit
        mov rax, SYS_WRITE ; sys_write syscall
        mov rdi, STDOUT    ; standard output
        mov rsi, digit     ; load digit pointer
        mov rdx, 2         ; length of digit + newline
        syscall            ; call sys_Write
        ret
