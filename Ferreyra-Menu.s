.data
msg0: .asciiz "vamos a traducir la palabra GIRASOL.\nSeleccione un idioma [1,2,3] o salir [4] \n"
msg1: .asciiz "1.Albanes\n2.Suajili\n3.Filipino\n4.salir\n"

rta1: .asciiz "Luledielli \n\n"
rta2: .asciiz "Alizeti \n\n"
rta3: .asciiz "Mirasol \n\n"
rta4: .asciiz "Cerrando el programa...\nAdios"

.text
OP1:
la $a0, rta1 #en a0 cargo la direccion de memoria rta1 donde se encuentra la palabra "luloedielli"
li $v0, 4 #en v0 cargo 4 para indicarle al sistema que imprima lo que se encuentra en la direccion de memoria rta1
syscall
j END

OP2:
la $a0, rta2
li $v0,4
syscall
j END

OP3:
la $a0, rta3
li $v0, 4
syscall
j END

OP4:
la $a0, rta4
li $v0, 4
syscall
li $v0, 10 #vamos a cerrar todo
syscall


main:
la $a0, msg0
li $v0, 4
syscall

la $a0, msg1
#li $v0, 4 esto es inutil.
syscall

li $v0, 5 #toma el input y lo guarda en v0. (cache)
syscall

beq $v0, 1, OP1
beq $v0, 2, OP2
beq $v0, 3, OP3
beq $v0, 4, OP4
END:
j main



