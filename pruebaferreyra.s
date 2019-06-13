.data
msg0: .asciiz "Ingrese la cantidad de numeros que desea ingresar: "
msg1: .asciiz "\nIngrese un numero: "
msgfinal: .asciiz "\nFin del programa. Que tengas un boonito dia c:"
esp: .asciiz " "
lista: .space 32 

.text
dif:	
	mul $t0,$s1,$s1 #t0<-s1^2 s1=lista[0]
	mul $t1,$s2,$s2 #t1<-s2^2 s2=lista[1]
	
	sub $s3,$t0,$t1 #s3=dif de los cuadrados de los numeros de la lista
	j $ra
		
main:
	
	li $s0,0 #s0 coontendra el largo de la lista l
	la $t0,lista #t0<-lista

SolicitarCantidadNumeros: 
	
	la $a0, msg0 #solicito el largo de l
	li $v0, 4
	syscall


	li $v0, 5 #ingresa el largo de l en v0
	
	beq $v0,0, FINdelPrograma	
	
	lw $s0, 0($v0) #add $s0, $s0, $v0
	

	la $t1, lista	#t1<-largo l

ForSolicitarNumeros:
		
	la $a0, msg1 #ingrese un numero
	li $v0, 4
	syscall
	
	li, $v0, 5
	syscall
	
	sw $v0, 0($t0) #agrego a la lista el numero

	addi $t1, $t1, -1 			#disminuyo el largo de la lista
	beq $t1,$0, FinSolicitarNumeros 	#ya ingreso todos los numeros
	addi $t0,$t0,4 		#si todavia no ingreso todos los numeros me muevo en la lista	

FinSolicitarNumeros:
	
	addi $s4,$s0,-2
	addi $s5,$s0,-1
	lw $s1, 0($s4) #addi $s1,$s4,0 #para pasarlos como parametros de dif
	lw $s2, 0($s5) #addi $s2,$s5,0

For:	
	#error le estoy pasando numeros en s1 y s2 que tienne que ver con el largo de la lista 
	#y te le tenia que pasar elementos de la lista en esa posicioon. no tengo mas tiempo,
	#SI SABIA HACERLO, sad
	
	jal dif #me deja en s3 la dif de los cuadrados
	
	lw $a0,0($s3)
	li $v0, 1    #imprimo la diferencia
	syscall

	la $a0,esp   #imprimo un espacio para uqe quede bonito
	li $v0, 4
	syscall

	beq $s4,0,FINdelPrograma #no te quedan mas elementos en la lista
	
	addi $s1,$s4,-1
	addi $s2,$s5,-1
	j For
finFor:
FINdelPrograma:
	
	la $a0, msgfinal #despedida
	li $v0, 4
	syscall

	li $v0, 10
	syscall
	
