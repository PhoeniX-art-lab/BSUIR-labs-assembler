.model tiny

.code
org 100h

jmp start

putc macro char
    push ax
    mov al, char
    mov ah, 0Eh
    int 10h     
    pop ax
endm

Output_String proc
    mov ah, 09h
    int 21h
    ret
endp

Scan_Num proc
    push dx
    push ax
    push si
    mov cx, 0
next_digit:
    ; get char from keyboard into AL:
    mov ah, 00h
    int 16h
    ; print it
    mov ah, 0Eh
    int 10h
    
    ; check for ENTER key:
    cmp al, 0Dh
    jne only_digits
    jmp stop_input
    
    
    
only_digits:
    ; multiply CX by 10 (first time the result is zero)
    push ax
    mov ax, cx
    mul cs:ten   ; DX:AX = AX*10
    mov cx, ax
    pop ax

    ; check if the number is too big
    ; (result should be 16 bits)
    cmp dx, 0
    jne too_big

    ; convert from ASCII code:
    sub al, 30h

    ; add AL to CX:
    mov ah, 0
    mov dx, cx      ; backup, in case the result will be too big.
    add cx, ax
    jc  too_big2    ; jump if the number is too big.

    jmp next_digit

too_big2:
    mov cx, dx     ; restore the backuped value before add.
    mov dx, 0      ; DX was zero before backup!
too_big:
    mov ax, cx
    div CS:ten     ; reverse last DX:AX = AX*10, make AX = DX:AX / 10
    mov cx, ax
    putc 8         ; backspace.
    putc ' '       ; clear last entered digit.
    putc  8        ; backspace again.        
    jmp next_digit ; wait for Enter.
    
stop_input:
    pop si
    pop ax
    pop dx
    ret      
    
Scan_Num endp    

                                  
start:
    mov dx, offset str1
    call Output_string
    call Scan_Num
    mov number, cx 
    
    mov dx, offset enter
    call Output_String
    
    mov dx, offset str2
    call Output_string
    call Scan_Num
    mov system, cx
    mov dx, offset enter
    call Output_String
    
    mov ax, number

l1:   
    mov dx, 0
    idiv system
    push dx
    cmp al, 0
    je Output
    jmp l1
    
    
Output:
    mov ah, 02h
    pop dx
    add dx, '0'
    cmp dx, 039h
    jg hex_output
continue: 
    int 21h
    cmp sp, 0FFFEh
    je Exit
    jmp Output
    
hex_output:
    add dx, 07h
    jmp continue

        
Exit:
    mov ax, 4C00h
    int 21h
    ret    
    
    number dw ?  
    system dw ?
    str1 db "Enter number: $"
    str2 db "Enter number system: $"
    enter db 0Dh, 0Ah, '$'
    ten dw 10 
end start