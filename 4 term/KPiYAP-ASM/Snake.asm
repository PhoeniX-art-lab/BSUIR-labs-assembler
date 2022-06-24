.model small
.stack 100h
.data
    snakei db 10, 10, 10, 1635 dup(0)
    snakej db 25, 26, 27, 1635 dup(0)    
    moving_flags dw 0001h ;up down left right
    headI db ?
    headJ db ?
    tailI db ? 
    tailJ db ?
    snake_size dw 3
    score_label db 'Score: ', '$'
    start_instruction db '                 Press any key to start playing                 ', '$'
    pause_instruction db '                  Press any key to continue...                  ', '$'
    game_instruction db  '             Space - pause, Escape - exit this game             ', '$'
    exit_instruction db  '          Thank you for playing. Press any key to exit          ', '$'
    
.code

put_message proc
    push ax
    mov ah, 09h             
    int 21h
    pop ax
    ret
put_message endp

random proc far
    push ax
    push cx
    push dx
    
    try_again:
    mov ah, 00h        
    int 1Ah      

    mov ax, dx
    xor ah, ah
    xor dx, dx
    xor cx, cx
    mov cx, 21
    div cx
    inc dl
    push dx
    
    mov ah, 00h        
    int 1Ah    

    mov ax, dx
    xor ah, ah
    xor dx, dx
    xor cx, cx
    mov cx, 78
    div cx
    inc dl
    
    pop ax
    mov ch, al
    mov cl, dl
    
    mov dx, cx       
    mov ah,02h
    int 10h
    
    mov ah,08h
    int 10h 
    cmp al, 02Ah
    jz try_again
    
    mov dx, cx
    mov ah, 02h
    int 10h
    mov cx, 1
    mov al, 30h
    mov ah, 0Ah
    int 10h
    
    pop dx
    pop cx
    pop ax
    iret
random endp

outint proc
    push ax
    push bx
    push cx
    push dx
    
    mov bx, 10
    xor cx, cx
tostack:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jnz tostack
fromstack:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop fromstack

    pop dx
    pop cx
    pop bx
    pop ax
    ret
outint endp


frame proc

    push ax
    push bx
    push cx
    push dx
    
    mov ax, 3
    int 10h
    

    mov ah, 01h
    mov ch, 20h
    int 10h
    
    xor dx,dx
    
    mov cx,80
    mov al, 0DBh
    mov ah, 0Ah
    int 10h
    
    xor dx,dx
    xor bx, bx
    mov bx,1
    
    cycl:
    inc dh
    xor dl, dl
    mov ah, 02h
    int 10h
    
    mov cx, 1
    mov al, 0DBh
    mov ah,0Ah
    int 10h
    
    inc dl
    mov ah, 02h
    int 10h
    
    mov cx, 78
    mov al, 32
    mov ah,0Ah
    int 10h
    
    add dl, 78
    mov ah, 02h
    int 10h
    
    mov cx, 1
    mov al, 0DBh
    mov ah, 0Ah
    int 10h
    
    inc bx
    cmp bx, 24
    jnz cycl
    
    inc dh
    xor dl, dl
    mov ah, 02h
    int 10h
    
    mov cx, 80
    mov al, 0DBh
    mov ah, 0Ah
    int 10h
    
    mov dh, 22
    mov dl, 0
    mov ah, 02h
    int 10h
    
    mov cx, 80
    mov al, 0DBh
    mov ah, 0Ah
    int 10h
    
    mov dh, 23
    mov dl, 2
    mov ah, 02h
    int 10h
    
    lea dx, score_label
    call put_message
    
    mov ax, snake_size
    sub ax, 3
    call outint
    
    mov dh, 23
    mov dl, 14
    mov ah, 02h
    int 10h
    
    mov cx, 1
    mov al, 0DBh
    mov ah, 0Ah
    int 10h
    
    inc dl
    mov ah, 02h
    int 10h
    
    push dx
    lea dx, start_instruction
    call put_message
    
    pop dx
    mov ah, 02h
    int 10h
    
    mov ah, 08h
    int 21h
    
    lea dx, game_instruction
    call put_message
    
    mov dx, 0A30h
    mov ah, 02h
    int 10h
    
    mov cx, 1
    mov al, 030h
    mov ah, 0Ah
    int 10h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
frame endp

delay proc
    push si
    push bx
    push dx

    mov si, 3
    mov ah, 00h
    int 1Ah

    mov bx, dx
    add bx, si

    delay_loop:

    int 1Ah
    cmp dx, bx
    jne delay_loop

    pop dx
    pop bx
    pop si
    ret
delay endp

moving proc
    push ax
    mov ah, 01h
    int 16h
    jz moving_end
    mov ah, 00h
    int 16h
    
    check_pause:
    cmp ah, 39h 
    jnz check_esc
    jmp pause_lala
    check_esc:
    cmp ah, 01h
    jnz check_arrows
    jmp fin
    check_arrows:
    cmp ah, 48h
    jz UP
    cmp ah, 50h
    jz DOWN
    cmp ah, 4Bh
    jz LEFT
    cmp ah, 4Dh
    jz RIGHT
    jmp moving_end
    
UP:
    mov ax, moving_flags
    test moving_flags, 0100h
    jnz moving_end
    mov moving_flags, 1000h
    jmp moving_end
DOWN:
    mov ax, moving_flags
    test moving_flags, 1000h
    jnz moving_end
    mov moving_flags, 0100h
    jmp moving_end
LEFT:   
    mov ax, moving_flags
    test moving_flags, 0001h
    jnz moving_end
    mov moving_flags, 0010h
    jmp moving_end
RIGHT:  
    mov ax, moving_flags
    test moving_flags, 0010h
    jnz moving_end
    mov moving_flags, 0001h
    jmp moving_end
moving_end:
    pop ax
    ret
moving endp


;field size = 25x80

start:
    MOV AX, @data
    MOV DS, AX
    
    push 0
    pop es
    pushf
    cli
    mov word ptr es:[87h*4], offset random
    mov word ptr es:[87h*4+2], seg random
    popf

   
    call frame
    
    mov cx, snake_size
    mov di, 0
    
    myLoop:
    mov dh, snakeI[di]
    mov dl, snakeJ[di]
    mov ah, 02h
    int 10h
        
    push cx
    mov cx, 1
    mov al, 02Ah
    mov ah, 0Ah
    int 10h
    pop cx
    inc di
    loop myLoop
    
    @@1:
    call delay
    call moving
    
    xor si, si
    mov si, snake_size
    mov bl, snakeI[si-1]       ;head
    mov dl, snakeJ[si-1]
    
    mov cx, moving_flags
    upc:
    test cx, 1000h
    jz downc
    sub bl, 1
    downc:
    test cx, 0100h
    jz leftc
    add bl, 1
    leftc:
    test cx, 0010h
    jz rightc
    sub dl, 1
    rightc:
    test cx, 0001h
    jz skip
    add dl, 1
    
    skip:
    
    mov headI, bl ;  new head 
    mov headJ, dl ; coordinates
    
    
    mov dh, headI
    mov dl, headJ    
    
    mov ah, 02h
    int 10h

    mov ah, 08h
    int 10h  
    
    cmp al, 2Ah      ;body crash
    jnz edges
    jmp fin
    edges:
    cmp al, 0DBh    ;edges crash   
    jnz f00d
    jmp fin
    f00d:
    cmp al, 030h
    jnz next
    mov bx, snake_size
    xor bh, bh
    inc bx
    mov snake_size, bx
    mov al, headI
    mov snakeI[bx-1], al
    mov al, headJ
    mov snakeJ[bx-1], al
   
    mov dh, snakeI[bx-1]
    mov dl, snakeJ[bx-1]      
    mov ah, 02h
    int 10h
    mov ah, 02h
    mov dl, 2Ah
    int 21h
    
    int 87h ;call random
    
    mov dh, 23
    mov dl, 9
    mov ah, 02h
    int 10h
    mov ax, snake_size
    sub ax, 3
    call outint
    
    jmp @@1
    next:
    
    mov al, snakeI[0]
    mov tailI, al       ;save old tail
    mov al, snakeJ[0]
    mov tailJ, al

    mov cx, snake_size
    xor ch, ch
    mov di, 0
    reSet_body:
        mov   al, snakeI[di+1]
        mov   snakeI[di], al
        
        mov   al, snakeJ[di+1]
        mov   snakeJ[di], al
        inc di
    loop reSet_body
    
    mov bx, snake_size      ;set new head coordinates 
    xor bh, bh
    mov al, headI
    mov   snakeI[bx-1], al
    mov al, headJ
    mov   snakeJ[bx-1], al
    
    push ax
    push dx
    mov dh, snakeI[bx-1]
    mov dl, snakeJ[bx-1]      
    mov ah, 02h
    int 10h
    mov ah, 02h
    mov dl, 2Ah
    int 21h
    pop dx 
    pop ax
    
    push ax
    push dx
    mov dh, tailI
    mov dl, tailJ       
    mov ah, 02h
    int 10h
    mov ah, 02h
    mov dl, 20h
    int 21h
    pop dx 
    pop ax
    
    jmp @@1
    
    pause_lala:
    mov dh, 23
    mov dl, 15
    mov ah, 02h
    int 10h
    push dx
    lea dx, pause_instruction
    call put_message
    
    mov ah, 08h
    int 21h
    
    pop dx
    mov ah, 02h
    int 10h
    mov ah, 09h
    lea dx, game_instruction
    call put_message
    jmp @@1
    
    fin:
    mov dh, 23
    mov dl, 15
    mov ah, 02h
    int 10h
    push dx
    lea dx, exit_instruction
    call put_message
    mov ah, 08h
    int 21h
    xor dx, dx
    mov ah, 02h
    int 10h
    mov ax, 3
    int 10h
    MOV AH, 4Ch
    INT 21h
end start
