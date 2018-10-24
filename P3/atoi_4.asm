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

lb $t0, 0($s0)
li $t6, '-'
beq $t0, $t6, negativo
b main

negativo:

li $t4, -1
addi $s0, $s0, 1


#procedimiento principal
main:


lb $t0, 0($s0) #guardo lo que apunta s0 en t0

bgt $t0, 57, ndetectada # si es mayor de 57, terminas
blt $t0, 48, ndetectada #si es menor de 48, terminas


li $t1, '\n'
beq $t0, $t1, ndetectada

#
#


#mulo $t7, $t7, 10
####################
li, $s3, 10
multu $s3, $t7
mflo $t7
###################
mfhi, $s6
bne $s6, 0, overflow
subi $t0, $t0, '0'
add $t7, $t7, $t0
bltz $t7, overflow

#
#

addi $s0, $s0, 1

b main



overflow:

li, $t7, 0
b ndetectada



ndetectada:

mul $t7, $t7, $t4
la $t5, num
sw $t7, 0($t5)

li $v0, 1
move $a0, $t7
syscall
li $v0, 10
syscall
