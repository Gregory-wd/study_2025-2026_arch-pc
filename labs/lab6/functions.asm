quit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    ret

; Функция печати строки (адрес в eax)
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
    int 0x80
    pop ebx
    pop ecx
    pop edx
    ret

; Функция ввода строки (буфер в ecx, длина в edx)
sread:
    mov eax, 3
    mov ebx, 0
    int 0x80
    ; Добавляем нуль-терминатор
    mov byte [ecx + eax - 1], 0
    ret

; Функция вычисления длины строки (адрес в eax, результат в eax)
slen:
    push ebx
    mov ebx, eax
.next:
    cmp byte [eax], 0
    jz .finished
    inc eax
    jmp .next
.finished:
    sub eax, ebx
    pop ebx
    ret

; Функция atoi (строка в eax, число в eax)
atoi:
    push ebx
    push ecx
    push edx
    push esi
    mov esi, eax
    mov eax, 0
    mov ecx, 0
.multiplyLoop:
    xor ebx, ebx
    mov bl, [esi+ecx]
    cmp bl, 48
    jl .finished
    cmp bl, 57
    jg .finished
    sub bl, 48
    add eax, eax
    mov edx, eax
    shl eax, 2
    add eax, edx
    add eax, ebx
    inc ecx
    jmp .multiplyLoop
.finished:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

; Функция печати числа (число в eax)
iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0
.divideLoop:
    inc ecx
    mov edx, 0
    mov esi, 10
    idiv esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz .divideLoop
.printLoop:
    dec ecx
    mov eax, esp
    call sprint_char
    pop eax
    cmp ecx, 0
    jnz .printLoop
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; Функция печати числа с переводом строки
iprintLF:
    call iprint
    push eax
    push eax
    mov eax, 0xA
    push eax
    mov eax, esp
    call sprint_char
    pop eax
    pop eax
    pop eax
    ret

; Функция печати символа (адрес в eax)
sprint_char:
    push edx
    push ecx
    push ebx
    push eax
    mov ecx, eax
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    pop eax
    pop ebx
    pop ecx
    pop edx
    ret
EOF
; Функция печати строки с переводом строки (адрес в eax)
sprintLF:
    call sprint        ; выводим строку
    push eax          ; сохраняем eax
    mov eax, 0xA      ; символ перевода строки
    push eax          ; помещаем его в стек
    mov eax, esp      ; получаем адрес символа
    call sprint_char  ; выводим символ
    pop eax           ; очищаем стек
    pop eax           ; восстанавливаем eax
    ret
