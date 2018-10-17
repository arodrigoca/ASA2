.data

num: .word 0
cad: .space 1024

.text

li $v0, 8
la $a0, cad
li $a1, 1024
syscall

#en s0 guardo la direcci�n del byte
#en t0 guardo el byte

la $s0, cad
la $s1, num #en s1 guardo la dirección de num
li $t7, 0
li $t4, 1

main:

 
lb $t0, 0($s0)

li $t1, '\n'
beq $t0, $t1, ndetectada

#
#


mulo $t7, $t7, 10
subi $t0, $t0, '0'
add $t7, $t7, $t0

#
#

addi $s0, $s0, 1

b main

ndetectada:

mul $t7, $t7, $t4
la $t5, num
sw $t7, 0($t5)

li $v0, 1
move $a0, $t7
syscall
li $v0, 10
syscall
