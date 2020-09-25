section .data
        filename db "file.csv",0
        newline db 10,0

section .bss
        text resb 6 ; reserve bytes for reading file

section .text
        global _start

_start:
        mov rax, 2        ; sys_open syscall
        mov rdi, filename ; filename string
        mov rsi, 0        ; 64 (create flag) + 1 (write flag)
        mov rdx, 0        ; read/write permissions (unimportant for reading)
        syscall           ; call sys_open (read file)

        push rax      ; push file descriptor to stack
        mov rdi, rax  ; move file descriptor to rdi
        mov rax, 0    ; sys_read syscall
        mov rsi, text ; pointer to text
        mov rdx, 6    ; length of string
        syscall       ; call sys_read (reads file into text pointer)

        mov rax, 3 ; sys_close syscall
        pop rdi    ; pop file descriptor to close
        syscall    ; call sys_close (close file)

        mov rax, 1     ; sys_write syscall
        mov rdi, 1     ; standard output
        mov rsi, text  ; pointer to text
        mov rdx, 6     ; length of string
        syscall        ; call sys_write

        mov rax, 1       ; sys_write syscall
        mov rdi, 1       ; standard output
        mov rsi, newline ; pointer to text
        mov rdx, 2       ; length of string
        syscall          ; call sys_write

        mov rax, 60 ; sys_exit syscall
        mov rdi, 0  ; no error
        syscall     ; call sys_exit
