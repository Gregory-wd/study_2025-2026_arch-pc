; Простые функции ввода-вывода для NASM
section .text

; Вывод строки с переводом строки
sprintLF:
    call sprint
    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; Вывод строки (адрес в EAX)
sprint:
    push edx
    push ecx
    push ebx
    push eax
    call slen
    mov edx, eax
    pop eax
    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 80h
    pop ebx
    pop ecx
    pop edx
    ret

; Длина строки (адрес в EAX)
slen:
    push ebx
    mov ebx, eax
nextchar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar
finished:
    sub eax, ebx
    pop ebx
    ret

; Ввод строки (буфер в ECX, длина в EDX)
sread:
    push eax
    push ebx
    mov eax, 3
    mov ebx, 0
    int 80h
    pop ebx
    pop eax
    ret

; Преобразование строки в число (адрес в EAX)
atoi:
    push ebx
    push ecx
    push edx
    mov ebx, eax
    mov eax, 0
    mov ecx, 0
multiplyLoop:
    xor edx, edx
    mov dl, [ebx+ecx]
    cmp dl, '0'
    jl finished_atoi
    cmp dl, '9'
    jg finished_atoi
    sub dl, '0'
    add eax, eax
    lea eax, [eax*4 + eax]
    add eax, edx
    inc ecx
    jmp multiplyLoop
finished_atoi:
    pop edx
    pop ecx
    pop ebx
    ret

; Вывод числа (число в EAX)
iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0
divideLoop:
    inc ecx
    mov edx, 0
    mov esi, 10
    idiv esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz divideLoop
printLoop:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz printLoop
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; Вывод числа с переводом строки
iprintLF:
    call iprint
    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; Завершение программы
quit:
    mov ebx, 0
    mov eax, 1
    int 80h
    ret
