.data 
lista: .space 20  #5numeros. al principio sino el asciiz jode.
#lista: .word 0,0,0,0,0,0  . es otra forma
mensaje1: .asciiz "Ingrese un numero: "
mensaje2: .asciiz "Los numeros ingresados son: "
espacio: .asciiz " "



.text
IngresarNumeros:

	li $s0, 0 #cant de numeros en la lista
	la $t0, lista 

forIngresar:	
	la $a0, mensaje1
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	
	sw $v0, 0($t0)
	addi $t0, $t0, 4 #me muevo en lista	
	addi $s0, $s0, 1
	
	
	bne $s0, 5, forIngresar

	jr $ra

MostrarNumeros:

	la $t0, lista
	li $s0, 0
	
	la $a0, mensaje2
	li $v0, 4
	syscall

forMostrar:
	lw $a0, 0($t0)  #ver
	li $v0, 1
	syscall

	la $a0, espacio
	li $v0, 4
	syscall
	
	addi $s0, $s0, 1
	addi $t0, $t0, 4
	
	bne $s0, 5, forMostrar

	jr $ra
main:
	jal IngresarNumeros
	jal MostrarNumeros

fin:
	li $v0, 10
	syscall


	
















	
	
