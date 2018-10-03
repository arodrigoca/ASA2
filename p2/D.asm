.data

operando1:
.byte 1

operando2:
.byte 2

.text
main:

lb $s0, operando1
lb $s1, operando2
add $t3, $s0, $s1
move $a0, $t3
li $v0, 1 #Imprimir el entero
syscall
li $v0, 10
syscall