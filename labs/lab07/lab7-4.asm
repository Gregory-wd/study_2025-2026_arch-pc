%include 'in_out.asm'

section .data
msg_x db "Введите x: ",0
msg_a db "Введите a: ",0
msg_res db "Результат f(x): ",0

section .bss
input_x resb 10
input_a resb 10
x resd 1
a_val resd 1

section .text
global _start
_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, input_x
    mov edx, 10
    call sread
    
    ; Преобразование x в число
    mov eax, input_x
    call atoi
    mov [x], eax
    
    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, input_a
    mov edx, 10
    call sread
    
    ; Преобразование a в число
    mov eax, input_a
    call atoi
    mov [a_val], eax
    
    ; Вычисление f(x)
    mov ebx, [x]        ; ebx = x (число)
    mov ecx, [a_val]    ; ecx = a (число)
    
    cmp ebx, ecx        ; Сравниваем x и a
    jl if_branch        ; если x < a, переходим к ветке if
    
    ; Ветка else: f(x) = 8 (x ≥ a)
    mov eax, 8
    jmp print_result
    
if_branch:
    ; Ветка if: f(x) = 2a - x (x < a)
    mov eax, ecx        ; eax = a
    add eax, eax        ; eax = 2a
    sub eax, ebx        ; eax = 2a - x
    
print_result:
    mov eax, msg_res
    call sprint
    call iprintLF
    call quit
