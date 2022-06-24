;Код программы (.com)
.8086
.model tiny
.code       

org 100h
    start:
    mov ah, 09h
    mov dx, offset message
    int 21h
    ret
    message db "Hello, world!$"
end start


;Код программы (.exe)
.8086
.model small  

.stack 100h

.data
message db "Hello, world!$"

.code
start:
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset message
    int 21h
    mov ax, 4C00h
    int 21h
end start
