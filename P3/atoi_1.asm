.data

cad: .space 1024
num: .word 0

.text

li $v0, 8
la $a0, cad
li $a1, 1024
syscall

li $v0, 4
la $s0, cad
syscall

#en s0 guardo la dirección del byte
#en t0 guardo el byte

la $s0, cad
main:

lb $t0, 0($s0)
li $t1, '\n'
beq $t0, $t1, ndetectada

#print wanna print the char - a number
lb $t7, 0($s0)
subi $t7,$t7, 1
li $v0, 11
move $a0, $t7
syscall
#-----------------------

li $v0, 11
move $a0, $t0
syscall

addi $s0, $s0, 1

b main

ndetectada:

li $v0, 10
syscall