%include 'in_out.asm'

section .data
msg_x db "Введите x: ",0
msg_a db "Введите a: ",0
msg_res db "Результат f(x): ",0
msg_debug_x db "x = ",0
msg_debug_a db "a = ",0

section .bss
x resb 10
a_val resb 10
result resb 10

section .text
global _start
_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax
    
    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, a_val
    mov edx, 10
    call sread
    mov eax, a_val
    call atoi
    mov [a_val], eax
    
    ; Отладочный вывод
    mov eax, msg_debug_x
    call sprint
    mov eax, [x]
    call iprintLF
    
    mov eax, msg_debug_a
    call sprint
    mov eax, [a_val]
    call iprintLF
    
    ; Вычисление f(x)
    mov ebx, [x]        ; ebx = x
    mov ecx, [a_val]    ; ecx = a
    
    ; Отладочное сравнение
    cmp ebx, ecx
    jl if_branch        ; если x < a
    
    mov eax, msg_res
    call sprint
    mov eax, 8
    call iprintLF
    jmp end
    
if_branch:
    mov eax, msg_res
    call sprint
    mov eax, ecx        ; eax = a
    add eax, eax        ; eax = 2a
    sub eax, ebx        ; eax = 2a - x
    call iprintLF
    
end:
    call quit
