.data

operando1: .space 2

operando2: .space 2

.text
main:

la $t3, operando1
la $t4, operando2
li $v0, 5
syscall
move $t6, $v0
li $v0, 5
syscall
move $t7, $v0
sb $t7, 0($t3)
sb $t6, 0($t4)
lb $s0, 0($t3)
lb $s1, 0($t4)
add $t3, $s0, $s1
move $a0, $t3
li $v0, 1 #Imprimir el entero
syscall
li $v0, 10
syscall