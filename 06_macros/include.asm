%include "header.inc"

section .data
        digit db 0,10

section .text
        global _start

_start:
        printDigit 3
        printDigit 4
        exit
