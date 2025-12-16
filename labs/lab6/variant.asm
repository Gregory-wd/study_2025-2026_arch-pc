SECTION .data
    msg     db 'Введите № студенческого билета: ', 0
    result  db 'Ваш вариант: ', 0
    newline db 0xA, 0xD, 0  ; перевод строки + нуль-терминатор

SECTION .bss
    buffer resb 80          ; буфер для ввода
    num    resd 1           ; для хранения числа

SECTION .text
    global _start

_start:
    ; Вывод приглашения
    mov eax, msg
    call sprint
    
    ; Ввод строки
    mov ecx, buffer
    mov edx, 80
    call sread
    
    ; Перевод строки в число
    mov eax, buffer
    call atoi              ; в eax теперь число
    
    ; Вычисление варианта: (число mod 20) + 1
    xor edx, edx           ; обнуляем edx для деления
    mov ebx, 20            ; делитель = 20
    div ebx                ; eax = число/20, edx = остаток
    
    inc edx                ; остаток + 1 = вариант
    mov [num], edx         ; сохраняем результат
    
    ; Вывод сообщения "Ваш вариант: "
    mov eax, result
    call sprint
    
    ; Вывод номера варианта
    mov eax, [num]
    call iprintLF
    
    ; Завершение программы
    call quit

; ============================================
; ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
; ============================================

; Функция выхода из программы
quit:
    mov eax, 1      ; системный вызов exit
    mov ebx, 0      ; код возврата 0
    int 0x80
    ret

; Функция печати строки
; Вход: eax = адрес строки
sprint:
    push eax
    push ebx
    push ecx
    push edx
    
    ; Вычисление длины строки
    mov ebx, eax    ; сохраняем адрес начала
    mov ecx, 0      ; счетчик длины
.sloop:
    cmp byte [eax], 0
    je .send
    inc eax
    inc ecx
    jmp .sloop
.send:
    ; Вывод строки
    mov eax, 4      ; системный вызов write
    mov ebx, 1      ; stdout
    mov edx, ecx    ; длина строки
    mov ecx, [esp+12] ; адрес строки (был сохранен)
    int 0x80
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; Функция ввода строки
; Вход: ecx = буфер, edx = максимальная длина
sread:
    push eax
    push ebx
    push ecx
    push edx
    
    mov eax, 3      ; системный вызов read
    mov ebx, 0      ; stdin
    int 0x80
    
    ; Добавляем нуль-терминатор в конец строки
    mov byte [ecx + eax - 1], 0
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; Функция преобразования строки в число (atoi)
; Вход: eax = адрес строки
; Выход: eax = число
atoi:
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, eax    ; esi = адрес строки
    mov eax, 0      ; обнуляем результат
    mov ecx, 0      ; индекс символа
    
.convert_loop:
    movzx ebx, byte [esi + ecx]  ; загружаем символ
    cmp bl, 0                    ; конец строки?
    je .done
    
    ; Проверяем, что символ - цифра
    cmp bl, '0'
    jl .error
    cmp bl, '9'
    jg .error
    
    ; Преобразуем символ в цифру
    sub bl, '0'
    
    ; Умножаем текущий результат на 10 и добавляем новую цифру
    mov edx, 10
    mul edx         ; eax = eax * 10
    add eax, ebx    ; добавляем цифру
    
    inc ecx
    jmp .convert_loop

.error:
    ; Если встретили не цифру, просто возвращаем что есть
    jmp .done

.done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret

; Функция печати числа
; Вход: eax = число
iprint:
    push eax
    push ebx
    push ecx
    push edx
    
    xor ecx, ecx    ; счетчик цифр
    
.divide_loop:
    inc ecx
    xor edx, edx
    mov ebx, 10
    div ebx         ; eax = частное, edx = остаток
    add edx, '0'    ; преобразуем в символ
    push edx        ; сохраняем на стек
    test eax, eax   ; eax == 0?
    jnz .divide_loop
    
.print_loop:
    dec ecx
    mov eax, esp    ; адрес символа на стеке
    call sprint_char
    pop eax         ; очищаем стек
    test ecx, ecx
    jnz .print_loop
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

; Функция печати числа с переводом строки
; Вход: eax = число
iprintLF:
    call iprint
    
    push eax
    mov eax, newline
    call sprint
    pop eax
    ret

; Функция печати одного символа
; Вход: eax = адрес символа
sprint_char:
    push eax
    push ebx
    push ecx
    push edx
    
    mov ecx, eax    ; адрес символа
    mov eax, 4      ; write
    mov ebx, 1      ; stdout
    mov edx, 1      ; длина = 1 символ
    int 0x80
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
