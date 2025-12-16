; lab6-2.asm - Программа вывода значения регистра eax с iprintLF
%include 'functions.asm'

SECTION .text
    GLOBAL _start
_start:
    mov eax, '6'
    mov ebx, '4'
    add eax, ebx
    call iprintLF
    call quit
