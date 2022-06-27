.model small
.stack 100h

.data     
.code
start:
	xor ax,ax
	mov dx,3F8h       ;COM1 base address
	mov al,'A'
	out dx,al
	xor ax,ax
	mov dx,2F8h       ;COM2 base address
	in al,dx
	mov dl,al
	mov ah,02h
	int 21h
	mov ax,4C00h
	int 21h
	ret
end start
