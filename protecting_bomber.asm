@author: Michael Berlin

start:

; initialize checkers (google "canary" for extra information)

mov bx, ax
mov word [bx - 0x200], 0x00
mov word [bx - 0x203], 0x00
mov word [bx - 0x206], 0x00
mov word [bx - 0x209], 0x00

mov si, ax
add bx, 0x32C ; return bx to attacking position

attack:

mov word [bx], 0xCCCC
add bx, 0x10
mov word [bx], 0xCCCC
add bx, 0x10
mov word [bx], 0xCCCC
add bx, 0x10
mov word [bx], 0xCCCC
add bx, 0x10
mov word [bx], 0xCCCC
add bx, 0x10
mov word [bx], 0xCCCC
add bx, 0x10

defend:
; defend: check if checkers have changed
cmp word [si - 0x200], 0x00
jne run_up
cmp word [si - 0x203], 0x00
jne run_up
cmp word [si - 0x206], 0x00
jne run_up
cmp word [si - 0x209], 0x00
jne run_up

jmp attack ; everything is fine - attack

run_up:

; !!! OTHER SURVIVER IS TRYING TO KILL US !!!
; !!!          MOVE THE CODE UP           !!!

sub ax, 0x206 ; up we go
mov di, ax
sub cx, 0x206
sub dx, 0x206
jmp run 

run:
push ds
pop es
push cx
; move all code
mov cx, exit - start
shr cx, 1
rep movsw
pop cx
jmp ax ; jump to the duplicated code



exit:
