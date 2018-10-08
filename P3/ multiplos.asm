.data

array: .word 1,2,3,4,5,6,7,8,9,10

.text

#registro con el índice
li $s0, 0
#Aumentar el índice

main:

li, $v0, 5
syscall
move $t1, $v0

li, $v0, 5
syscall
move $t2, $v0

mulo $t3, $t1, $t2

beqz $t2, fin
b aumentar


aumentar:

mulo $t6, $t1, $s0
addi $s0, $s0, 1
li $v0, 1
move $a0, $t6
syscall
li $v0, 11
li, $a0, '\n' #puedes cargar un inmediato directamente. No solo números, si no caracteres o cadenas incluso
syscall
beq $t6, $t3, fin


li $t0, 10
beq $s0, $t0, fin #condicion de terminar

#si i es menor que 10

b aumentar

fin:

li $v0, 10
syscall


