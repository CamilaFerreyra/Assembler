.data
buffer: .space 17
bienvenida: .asciiz "Ingrese las direcciones de host, red y mascara\n"
estaMsg: .asciiz "\nLa direccion de host se encuentra en la red\n"
noEstaMsg: .asciiz "\nLa direccion de host no se encuentra en la red\n"

.text 

main:
la $a0, bienvenida
li $v0, 4
syscall

# la iteracion para con un punto(46) o final de linea(10)
li $s6, 0

F1:
	la $a0, buffer
	li $a1, 17
	li $v0, 8
	syscall

	jal convertir
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)

	addi $s6, $s6, 1
	beq $s6, 3, EF1
	j F1
EF1:

# ahora tenemos en stack (por orden): host, red, mascara

li $s5, 0
F3:
# vamos a poner en $s0 la mascara, en $s1 la red, en $s2 el host
	lw $s0, 0($sp)
	lw $s1, 16($sp)
	lw $s2, 32($sp)

	addi $s5, $s5, 1
	addi $sp, $sp, 4
	and $s3, $s2, $s0
	bne $s3, $s1, no_esta
	beq $s5, 4, EF3
	j F3
EF3:

la $a0, estaMsg
li $v0, 4
syscall

#limpianding stack

addi $sp, $sp, 32

li $v0, 10
syscall

no_esta:
la $a0, noEstaMsg
li $v0, 4
syscall

#aca no limpio porque no estoy segura de cuanto limpiar.

li $v0, 10
syscall


convertir:
addi $sp, $sp, -4
sw $ra, ($sp)

# guardamos el primer numero en s0
la $s5, buffer

jal tomar_numero
move $s0, $s4

jal tomar_numero
move $s1, $s4

jal tomar_numero
move $s2, $s4

jal tomar_numero
move $s3, $s4

lw $ra, ($sp)
addi $sp, $sp, 4
jr $ra

tomar_numero:
# devolvemos en s4 el valor de el enesimo numero de la ip 
li $s4, 0
F0: 
	lb $t0, ($s5)
	addi $s5, $s5, 1
	
	beq $t0, 46, EF0
	beq $t0, 10, EF0
	
	addi $t0, $t0, -48
	mul $s4, $s4, 10
	add $s4, $s4, $t0

	j F0
EF0:

jr $ra
