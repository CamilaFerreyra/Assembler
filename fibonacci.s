.data
m1: .asciiz "Ingrese la posicion del numero de la serie de fibonacci que desea: "
m2: .asciiz "Su numero de fibonacci es: "

.text
main:

li $s0, 0
li $s1, 1
la $a0, m1
li $v0, 4
syscall		  #imprime el mensaje 1

li $v0, 5
syscall       #espera un numero
move $s2, $v0 #mueve el numero a s2

jal fibbo 

la $a0, m2
li $v0, 4
syscall       #imprime el mensaje 2

li $v0, 1
move $a0, $s3
syscall       #imprime el resultado de fibonacci

li $v0, 10
syscall       #termina el programa

fibbo:
# fibbo espera en $s0, $s1, $s2, los argumentos
# fibbo devuelve el resultado en $s3
move $s3, $s0 #muevo s0 al resultado

bgt $s2, 1, seguir_funcion # si es mas grande que 1 entro al caso recursivo
jr $ra					   #else termino el caso 

seguir_funcion: 
addi $sp, $sp, -4		   
sw $ra,0($sp)
						  # guardo en stack 

move $s0, $s1			#el segundo argumento pasa a ser el primero
add $s1, $s1, $s3		#el segundo pasa a ser la suma de el primero anterior y el seguno 
addi $s2, $s2, -1       #resto al "contador"

jal fibbo

lw $ra, 0($sp)
addi $sp, $sp, 4

jr $ra
