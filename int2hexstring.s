.data
msg1: .asciiz "Ingrese un numero: "
msg2: .ascii "\nEl numero en hexa es: 0x"
msg3: .asciiz "00000000\n"
hexa: .ascii "0123456789ABCDEF"
msg_signo: .asciiz "\nEl signo es: 0x"
msg5: .ascii "\n\nEl exponente en exceso es: 0x"
msg_exponente_exceso: .asciiz "00000000\n"
msg6: .ascii "El exponente es: 0x"
msg_exponente: .asciiz "00000000\n"
msg7: .ascii "\n\nLa mantisa es: 0x" 
msg_mantisa: .asciiz "00000000\n"

.text
main: 
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 6 #Lee el numero flotante y lo guarda en $f0
    syscall

    mfc1 $a0,$f0 #muevo el flotante a $a0
    addi $s1, $a0, 0 
    la $a1, msg3
    jal i2hs
    li $v0, 4
    la $a0, msg2
    syscall

    jal signo
    jal exponente_en_exceso
    jal exponente
    jal mantisa
    
    li $v0, 10
    syscall

signo: 
    li $v0, 4       #msg de signo
    la $a0, msg_signo   
    syscall

    move $t1, $s1
    srl $t1, $t1, 31  #dejo solo el bit signo  
    
    move $a0, $t1      
    li $v0, 1
    syscall

    jr $ra

exponente_en_exceso: 

    move $t1, $s1
    srl $t1, $t1, 23 #dejamos solo 9 bits (el primer bit es del bit signo)
    andi $t1, $t1, 0xff  #t1 & 0 1111 1111 para deshacernos del bit signo 

    move $a0, $t1
    la $a1, msg_exponente_exceso

    sw  $ra, ($sp) 
    jal i2hs
    lw  $ra, ($sp)

    li $v0, 4       #msg de exp en exceso
    la $a0, msg5   
    syscall

    jr $ra

exponente:

    move $t1, $s1
    srl $t1, $t1, 23 #dejamos solo 9 bits (el primer bit es del bit signo)
    andi $t1, $t1, 0xff  #t1 & 0 1111 1111 para deshacernos del bit signo 

    sub $t1, $t1, 127
    move $a0, $t1
    la $a1, msg_exponente

    sw  $ra, ($sp) 
    jal i2hs
    lw  $ra, ($sp)

    li $v0, 4       #msg de exponente
    la $a0, msg6   
    syscall

    jr $ra

mantisa:
    move $t1, $s1
    sll $t1, $t1, 9
    srl $t1, $t1, 9

    move $a0, $t1
    la $a1, msg_mantisa

    sw  $ra, ($sp) 
    jal i2hs
    lw  $ra, ($sp)

    li $v0, 4       
    la $a0, msg7
    syscall

    jr $ra
         
            #$a0 numero a pasar $a1 numero pasado
i2hs:                   
    sw  $a1, -4($sp)     
    sw  $a0, -8($sp)
    la   $t1, hexa
    li   $t2, 8
    addi $a1, $a1, 7


L1:   
    andi $t0, $a0, 0xf
    add  $t3, $t0, $t1      
    lb   $t4, 0($t3)
    sb   $t4, 0($a1)
    srl  $a0, $a0, 4
    addi $a1, $a1, -1
    addi $t2, $t2, -1
    beqz $t2, E1
    j L1


E1:   
    lw  $a1, -4($sp)
    lw  $a0, -8($sp)
    jr $ra
      
