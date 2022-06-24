.8086
.model tiny
.code

org 100h

jmp start

file db 'c:\file.txt', 0
buffer dw ?
line_count dw ?
enter db 0Dh, 0Ah, '$'
ten dw 10
str db 'Lines in text: $'          

proc NewLine
    inc line_count
    jmp continue
endp

Output_String proc
    mov ah, 09h
    int 21h
    ret
endp

start:     
    mov ax, cs
    mov dx, ax
    mov es, ax
    mov line_count, 1
    
    ; open file
    mov dx, offset file
    mov ah, 3Dh
    mov al, 00h             ;00 - only for reading
    int 21h
    jc Exit
    mov bx, ax              ;bx - file identificator
    mov di, 01h             ;di - STDOUT id
    
    ; Reading data from file
read_data:
    mov cx, 1
    mov dx, offset buffer
    mov ah, 3Fh
    int 21h
    jc close_file
    mov cx, ax              ;cx - number of reading bites
    jcxz close_file         ;if cx is equal 0 - close file
    mov ah,40h          
    xchg bx,di              ;bx = 1- STDOUT
    int 21h                 ;output to STDOUT
    cmp buffer, 0Ah
    je call NewLine
continue:
    xchg di,bx              ;bx - file id
    jc close_file
    jmp short read_data     ;output next data patch

;Closing file
close_file:
    mov ah, 3Eh
    int 21h
    
    ;Output
    lea dx, enter
    call Output_string
    lea dx, str
    call Output_string  
     
    mov ax, line_count
l1:
    mov dx, 0
    idiv ten
    push dx
    cmp al, 0
    je Output
    jmp l1
    
Output:
    mov ah, 02h
    pop dx
    add dx, '0'
    cmp dx, 039h 
    int 21h
    cmp sp, 0FFFEh
    je Exit
    jmp Output
    
Exit:
    mov ax, 4C00h
    int 21h
    ret
