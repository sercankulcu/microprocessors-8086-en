; The same program on the 8086: for each number from 1 to n (n = 3) it prints whether it
; is odd or even. The high-level for/if becomes CMP + a conditional jump, and TEST
; checks the lowest bit.
; Source: Chapter 3.1 Programming Languages, "The Same Program: 8086"

org 100h
       mov  cx, 1       ; i = 1
again: cmp  cx, 3       ; compare i with n
       ja   done        ; done if i > n
       mov  dl, cl
       add  dl, '0'     ; digit → ASCII
       mov  ah, 02h
       int  21h         ; print DL
       test cl, 1       ; lowest bit
       jnz  odd         ; 1 means odd
       lea  dx, even_m
       jmp  print
odd:   lea  dx, odd_m
print: mov  ah, 09h
       int  21h         ; print string
       inc  cx          ; i++
       jmp  again
done:  ret
odd_m  db ' is odd.',0Dh,0Ah,'$'
even_m db ' is even.',0Dh,0Ah,'$'

; Expected output:
; 1 is odd.
; 2 is even.
; 3 is odd.
