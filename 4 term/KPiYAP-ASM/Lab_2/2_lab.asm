.model tiny
.code
org 100h
  
jmp start  
    
Input_String macro str
    mov dx, offset str
    mov offset str, size
    mov ah, 0Ah
    int 21h
endm

Output_String proc
    mov ah, 09h
    int 21h
    ret
endp

Exit proc
    mov dx, offset string
    add dx, 2
    call Output_String
    mov ax, 4C00h
    int 21h
    ret
endp

Swap proc
    mov ah, [bx + di]
    mov al, [bx + di + 1]
    mov [bx + di], al
    mov [bx + di + 1], ah
    jmp continue
endp

start:
    Input_String string
    mov dx, offset enter
    call Output_String
    
    mov dx, offset enter
    call Output_String
    
    xor si, si
    xor di, di
    mov bx, offset string[2]
    inc si
    
l1:
    cmp [bx + si], '$'
    je call Exit
    mov di, si
    dec di
    l2:  
        mov dx, di
        cmp dx, 0FFFFh
        je break

        mov ah, [bx + di]
        mov al, [bx + di + 1]
        cmp ah, al
        jg call Swap
        continue:
        dec di
        jmp l2
    break:
    inc si
    jmp l1
                        
        
        
size EQU 200
string db size dup ('$')
enter db 0Dh, 0Ah, '$'   
    
end start
