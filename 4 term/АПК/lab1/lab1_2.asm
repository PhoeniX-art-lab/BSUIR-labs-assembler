.model small
.stack 100h

.data
Information db "Byte sent: $"
           
.code

jmp start

Init_COM1 proc
   xor ax,ax
   mov al,10100011b    ;init port
   mov dx,0            ;writing port number(0-1)
   int 14h                  
   ret            
Init_COM1 endp

IsWrite_COM1 proc
   mov al,'A'
   mov ah,1             ;01h - send a character through
   mov dx,0             ;the selected port
   int 14h
   ret 
IsWrite_COM1 endp

IsRead_COM2 proc
    mov ah,2            ;02h - get a character thtough
    mov dx,1            ;the selected port(dx - port number)
    int 14h
    ret
IsRead_COM2 endp

Output proc
   mov ah,02h
   mov dl,al
   int 21h
   ret
Output endp

Exit proc
    mov ax,4C00h
    int 21h
    ret
Exit endp

start:    
   mov ax, @data
   mov ds, ax
   call Init_COM1
   call IsWrite_COM1
   mov al,'A'
   call IsRead_COM2
   push ax
   
   mov ah,9
   mov dx,offset Information
   int 21h
           
   pop ax        
   call Output
   call Exit

end start