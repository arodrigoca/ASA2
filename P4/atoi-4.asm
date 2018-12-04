.data

cad: .space 1024

.text

li $v0, 8
la $a0, cad #a0 direccion de memoria de la cadena
li $a1, 1024
syscall

#si hago subrutina, podria usar la direccion en a0 o tengo que pasarlo a valor en vez de a dir memoria?

li $t0, '-'
lb $t1, 0($a0)
beq $t1, $t0, negativo
b main

negativo:

	li $s7, -1
	addi $a0, $a0, 1

main:

	jal process

	li $v0, 10
	syscall


process:

	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 24
	sw $a0, 0($fp)

	lb $t0, 0($a0)
	bgt $t0, 57, end # si es mayor de 57, terminas
	blt $t0, 48, end #si es menor de 48, terminas
	li $t1, '\n'
	beq $t0, $t1, end
	
	
	addi $a0, $a0, 1
	
	b process
	

end:

jr $ra






