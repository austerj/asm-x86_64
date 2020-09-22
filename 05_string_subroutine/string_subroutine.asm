section .data
        text db "Hello, world!",10,0
        text2 db "World?",10,0

section .text
        global _start

_start:
        mov rax, text
        call _print

        mov rax, text2
        call _print

        mov rax, 60 ; sys_exit syscall
        mov rdi, 0  ; no error
        syscall     ; call sys_exit

;input: rax as pointer to string
;output: print string at rax
_print:
        push rax       ; store rax on stack
        mov rbx, 0     ; initialize char count
_printLoop:            ; loop over chars
        inc rax        ; increment pointer to next char
        inc rbx        ; increment char count by one
        mov cl, [rax]  ; store current char from pointer value
        cmp cl, 0      ; check if current char is 0
        jne _printLoop ; repeat loop if not 0

        mov rax, 1     ; sys_write syscall
        mov rdi, 1     ; standard output
        pop rsi        ; pop string pointer
        mov rdx, rbx   ; store length of string
        syscall        ; call sys_write

        ret
