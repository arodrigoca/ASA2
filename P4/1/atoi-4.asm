.data

cad: .space 1024
num: .word 0

.text

li $v0, 8
la $a0, cad #en a0 voy a guardar la direccion de cad
li $a1, 1024
syscall

lb $t0, 0($a0)
li $t6, '-'
beq $t0, $t6, negativo
b main

negativo:

	li $t4, -1
	addi $a0, $a0, 1


main:

	jal process
	li $v0, 10
	syscall 


process:

	
	lb $t0, 0($a0) #guardo lo que apunta a0 en t0
	
	bgt $t0, 57, fin # si es mayor de 57, terminas
	blt $t0, 48, fin #si es menor de 48, terminas

	li $t1, '\n'
	beq $t0, $t1, fin


#----------------------

	li, $t6, 10
	multu $t6, $t7
	mflo $t7

#----------------------

	subi $t0, $t0, '0'
	add $t7, $t7, $t0
	
	
#----------------------


	addi $a0, $a0, 1
	
	b process


fin:

	jr $ra

	
	


