; lab6-1.asm - Программа вывода значения регистра eax
%include 'functions.asm'

SECTION .bss
    buf1: RESB 80

SECTION .text
    GLOBAL _start
_start:
    mov eax, '6'
    mov ebx, '4'
    add eax, ebx
    mov [buf1], eax
    mov eax, buf1
    call sprintLF
    call quit
