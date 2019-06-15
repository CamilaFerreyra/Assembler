#Realizar un menu basico de al menos 3 opciones.
.data
#Mensajes utilizados en el programa
  msg0: .asciiz " Pulse 1 Para Elegir La Opcion 1. \n Pulse 2 Para Elegir La Opcion 2. \n Pulse 3 Para Elegir La Opcion 3 \n "
  msg1: .asciiz " Usted Eligio La Opcion 1 \n"
  msg2: .asciiz " Usted Eligio La Opcion 2 \n"
  msg3: .asciiz " Usted Eligio La Opcion 3 \n "
.text
  main:
  #Pongo los valores 1,2 y 3 en los registros t0,t1 y t2 respectivamente
    li $t0,1
    li $t1,2
    li $t2,3
#Pido al usuario que elija una opcion
    li $v0,4
    la $a0,msg0
    syscall
    li $v0,5
    syscall
      beq $v0,$t0,caso1
      beq $v0,$t1,caso2
      beq $v0,$t2,caso3
  #Distintas opciones posibles
  caso1:
    li $v0,4
    la $a0,msg1
    syscall
    li $v0,10
    syscall
  caso2:
    li $v0,4
    la $a0,msg2
    syscall
    li $v0,10
    syscall
  caso3:
    li $v0,4
    la $a0,msg3
    syscall
    li $v0,10
    syscall
