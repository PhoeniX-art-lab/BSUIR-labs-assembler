.8086
.model tiny
.code

org 100h
    
jmp start
    
outp proc 
    
    mov bx, 02h
l1:
    mov dx, 0
    idiv bx
    push dx
    cmp al, 0
    je Output
    jmp l1
    
Output:
    mov ah, 02h
    pop dx
    add dx, '0'
    int 21h
    cmp sp, 0FFFCh
    je Exit
    jmp Output

Exit:
    cmp cx, 0
    je c1
    jmp ex
endp 

Output_String proc
    mov ah, 09h
    int 21h
    ret
endp
    
start:
    xor al, al  
    in al, 21h      ;get current value
    mov master, ax
    or al, 80h       ;zapret IRQ15
    out 21h, al     ;write new value to the port
    mov slave, ax
    
    
    mov ax, master
    mov cx, 0
    call outp
c1:
    mov dx, offset enter
    call Output_String
    
    mov ax, slave
    mov cx, 1
    call outp
    
       

Ex:
    mov ax, 4C00h
    int 21h
    ret 

    master dw ?
    slave dw ?
    enter db 0Dh, 0Ah, '$'
end start   