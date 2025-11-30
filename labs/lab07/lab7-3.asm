%include 'in_out.asm'

section .data
msg db "Наименьшее число: ",0
a dd 45
b dd 23  
c dd 17

section .bss
min resb 10

section .text
global _start
_start:
    ; Сначала предполагаем что a - минимальное
    mov ecx, [a]
    mov [min], ecx
    
    ; Сравниваем a и b
    cmp ecx, [b]
    jl check_c    ; если a < b, переходим к сравнению с c
    mov ecx, [b]  ; иначе min = b
    mov [min], ecx
    
check_c:
    ; Сравниваем текущий min с c
    mov ecx, [min]
    cmp ecx, [c]
    jl print_result  ; если min < c, переходим к выводу
    mov ecx, [c]     ; иначе min = c
    mov [min], ecx
    
print_result:
    mov eax, msg
    call sprint
    mov eax, [min]
    call iprintLF
    call quit
