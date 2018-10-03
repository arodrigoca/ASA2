.data

operando1:
.word 0

operando2:
.word 0

resultado:
.asciiz "Tu resultado es: "

.text
main:

li $v0, 5
syscall
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
add $t3, $s0, $s1
la $a0, resultado
li $v0, 4
syscall
move $a0, $t3
li $v0, 1 #Imprimir el entero
syscall
li $v0, 10
syscall



