section .data
        filename db "file.csv",0
        text db "1,2,3",0

section .text
        global _start

_start:
        mov rax, 2        ; sys_open syscall
        mov rdi, filename ; filename string
        mov rsi, 65       ; 64 (create flag) + 1 (write flag)
        mov rdx, 0644o    ; read/write owner, read group, read other (octals)
        syscall           ; call sys_open (create file)

        push rax      ; push file descriptor to stack
        mov rdi, rax  ; move file descriptor from rax to rdi
        mov rax, 1    ; sys_write syscall
        mov rsi, text ; move text to write
        mov rdx, 6    ; number of bytes to write
        syscall       ; call sys_write (write to file)

        mov rax, 3 ; sys_close syscall
        pop rdi    ; pop file descriptor to close
        syscall    ; call sys_close (close file)

        mov rax, 60 ; sys_exit syscall
        mov rdi, 0  ; no error
        syscall     ; call sys_exit
