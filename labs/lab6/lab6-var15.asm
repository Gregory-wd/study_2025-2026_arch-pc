; lab6-var15.asm - Вычисление f(x) = (5 + x)² - 3 (вариант 15)
%include 'functions.asm'

SECTION .data
    title: DB 'Вычисление выражения: f(x) = (5 + x)² - 3', 0xA, 0xD, 0
    msg_x: DB 'Введите x: ', 0
    msg_r: DB 'Результат: ', 0

SECTION .bss
    buffer: RESB 80

SECTION .text
    GLOBAL _start
_start:
    ; Вывод заголовка
    mov eax, title
    call sprint
    
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, buffer
    mov edx, 80
    call sread
    
    ; Преобразование в число
    mov eax, buffer
    call atoi
    
    ; Вычисление (5 + x)² - 3
    add eax, 5      ; eax = x + 5
    mov ebx, eax    ; сохраняем (x+5)
    imul eax, ebx   ; eax = (x+5)²
    sub eax, 3      ; eax = (x+5)² - 3
    
    ; Вывод результата
    mov ebx, eax    ; сохраняем результат
    mov eax, msg_r
    call sprint
    mov eax, ebx
    call iprintLF
    
    call quit
