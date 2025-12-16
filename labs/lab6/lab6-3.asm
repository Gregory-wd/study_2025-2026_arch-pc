; lab6-3.asm - Программа вычисления выражения (5*2+3)/3
%include 'functions.asm'

SECTION .data
    div_msg: DB 'Результат: ',0
    rem_msg: DB 'Остаток от деления: ',0

SECTION .text
    GLOBAL _start
_start:
    ; Вычисление (5*2+3)/3
    mov eax, 5
    mov ebx, 2
    mul ebx        ; EAX = 5*2 = 10
    add eax, 3     ; EAX = 10+3 = 13
    
    xor edx, edx   ; обнуляем EDX
    mov ebx, 3
    div ebx        ; EAX = 13/3 = 4, EDX = остаток 1
    
    mov edi, eax   ; сохраняем результат
    
    ; Вывод результата
    mov eax, div_msg
    call sprint
    mov eax, edi
    call iprintLF
    
    ; Вывод остатка
    mov eax, rem_msg
    call sprint
    mov eax, edx
    call iprintLF
    
    call quit
