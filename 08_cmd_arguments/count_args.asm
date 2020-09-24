section .bss
        digitSpace resb 100  ; reserve bytes for digits
        digitSpacePos resb 8 ; reserve bytes for tracking digit position
        ; need to store digit position to avoid rcx modified by syscalls

section .text
        global _start

_start:
        pop rax        ; pop argc
        sub rax, 1     ; subtract 1
        call _printRAX ; call digit print subroutine

        mov rax, 60 ; sys_exit syscall
        mov rdi, 0  ; no error
        syscall     ; call sys_exit

_printRAX:
        mov rcx, digitSpace      ; digitSpace in rcx
        mov rbx, 10              ; newline at start (subroutine runs backwards)
        mov [rcx], rbx           ; insert newline char
        inc rcx                  ; increment to next char
        mov [digitSpacePos], rcx ; move incremented position to tracker

_printRAXLoop:
        ; get digits in backwards order from remainders of division by 10
        mov rdx, 0  ; set to 0 to avoid concatenating div result
        mov rbx, 10 ; store 10
        div rbx     ; divide rax by 10
        push rax    ; store rax in stack
        add rdx, 48 ; convert division remainder to ASCII character
        ; e.g. 123/10 -> rax = 12, rdx = 3

        mov rcx, [digitSpacePos] ; increment digit space position
        mov [rcx], dl             ; insert remainder char into rcx
        inc rcx                   ; increment to next char
        mov [digitSpacePos], rcx  ; moved incremented position to tracker

        pop rax            ; pop into rax
        cmp rax, 0         ; compare rax to 0
        jne _printRAXLoop  ; jump if rax is not 0 (i.e. not final digit)

_printRAXLoop2:
        mov rcx, [digitSpacePos]

        mov rax, 1   ; sys_write syscall
        mov rdi, 1   ; standard output
        mov rsi, rcx ; going to print rcx
        mov rdx, 1   ; printing one digit
        syscall      ; call sys_write

        ; print chars in backwards order
        mov rcx, [digitSpacePos] ; move position to rcx
        dec rcx                  ; decrement position
        mov [digitSpacePos], rcx ; move decremented position to tracker

        cmp rcx, digitSpace ; compare rcx (position) to digitSpace
        jge _printRAXLoop2 ; loop if rcx is >= digitSpace
        
        ret
