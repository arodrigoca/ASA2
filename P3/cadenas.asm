#recorrer una cadena introducidas por el usuario

.data

cad: .space 1024

.text

li $v0, 8
la $a0, cad
li $a1, 1024
syscall

li $v0, 4
la $a0, cad
syscall


la $s0, cad
li $v0, 11

next:
lb $t0, 0($s0)
move $a0, $t0
li $v0, 11
syscall

addi $s0, $s0, 1

li $t1, '\n'
beq $t0, $t1, fin

b next

fin:

li, $v0, 10
syscall
