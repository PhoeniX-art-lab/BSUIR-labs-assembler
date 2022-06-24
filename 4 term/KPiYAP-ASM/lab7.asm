.model tiny   

.code
org 100h

jmp start

Output_String proc
    mov ah, 09h
    int 21h
    ret
endp 

putc macro char
    push ax
    mov al, char
    mov ah, 0Eh
    int 10h     
    pop ax
endm

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
    mov ax, 03
    int 10h  
    mov dx, offset str1
    call Output_String
    call Scan_Num
    cmp cx, 1
    jl start
    cmp cx, 255
    jg start
    mov count, cx
    
    ; mov stack on 200h after the end of program
    mov sp, program_length+100h+200h
    ; free all memory after the end of program and stack
    mov ah, 4Ah
    stack_offset = program_length+ 100h + 200h
    mov bx, stack_offset shr 4 + 1                  ; size in paragraphs + 1     
    int 21h
    
    ; Write EPB fields 
    mov ax, cs
    mov word ptr EPB+4, ax                          ; CMD segment   
    mov word ptr EPB+8, ax                          ; First FCB(File Control Block) segment
    mov word ptr EPB+0Ch, ax                        ; Second FCB segment
    
    mov cx, count
l1:
    mov ax, 4B00h
    mov dx, offset program_path
    mov bx, offset EPB
    int 21h
loop l1
    
    
    int 20h
    count dw ?
    str1 db "Enter count of repetitions: $"
    program_path db "timer.exe", 0
    enter db 0Dh, 0Ah, '$'
    ten dw 10
    EPB dw 0000                                      ; Current enviroment 
        dw offset commandline,0                      ; CMD address
        dw 005Ch,0,006Ch,0                           ; FCB program address
    commandline db 125                               ; CMD length
                db " /?"
    program_length equ $-start                       ; Program length
end start