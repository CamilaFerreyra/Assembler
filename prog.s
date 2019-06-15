.data
msg1: .asciiz "1. digo chau\n"
msg2: .asciiz "2. digo hola\n"
msg3: .asciiz "3. calculo 1+1\n"
msg4: .asciiz "Que opcion elige? "
wrongOpt: .asciiz "Esa opcion no existe. Adios\n"
resp1: .asciiz "Chau\n"
resp2: .asciiz "Hola\n"
resp3: .asciiz "1+1=2\n"

.text
#opciones del if (menu)
opt1:
la $a0, resp1
li $v0, 4
syscall
#salta a end obligadamente 
beq $0, $0, end

opt2:
la $a0, resp2
li $v0, 4
syscall
beq $0, $0, end

opt3:
la $a0, resp3
li $v0, 4
syscall
beq $0, $0, end

#linea donde comienza el programa
main:
li $v0, 4

la $a0, msg1
syscall

la $a0, msg2
syscall

la $a0, msg3
syscall

la $a0, msg4
syscall

li $v0, 5
syscall

#la ejecucion salta hasta la linea (opt1) si v0 == 1
beq $v0, 1, opt1 

beq $v0, 2, opt2

beq $v0, 3, opt3

li $v0, 4            #default
la $a0, wrongOpt
syscall

#tras la ejecucion de cada opcion o del default continua el programa aca
end:
li $v0, 10
syscall
