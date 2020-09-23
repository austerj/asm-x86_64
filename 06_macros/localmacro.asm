%macro exit 0
        mov rax, 60 ; sys_exit syscall
        mov rdi, 0  ; no error
        syscall     ; call sys_exit
%endmacro

%macro raxToFive 0
%%_loop:
        call _printRAXDigit ; print current rax digit
        add rax, 1          ; increment by one
        cmp rax, 5          ; check if 5
        jb %%_loop          ; repeat if less than 5
%endmacro

section .data
        digit db 0,10

section .text
        global _start

_start:
        mov rax, 0
        raxToFive
        mov rax, 3
        raxToFive

        exit

_printRAXDigit:
        mov rbx, rax    ; temporary store rax in rbx
        add rax, 48     ; add 48 to get ASCII char
        mov [digit], al ; load lower byte into digit
        mov rax, 1      ; sys_write syscall
        mov rdi, 1      ; standard output
        mov rsi, digit  ; load digit pointer
        mov rdx, 2      ; length of digit + newline
        syscall         ; call sys_Write
        mov rax, rbx    ; move back rax
        ret
