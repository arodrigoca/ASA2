.data

array: .word 1 2 3 4 5 6 7 8 9 10


.text

main:

	la $s0, array
	li $s1, 10 #size of array
	
	move $a0, $s0
	li $a1, 9
	li $a2, 0
	move $a3, $s1
	
	jal buscarDesde
	#here v0 contains the position
	
	li $v0, 10
	syscall
	


							#a0		  #a1   #a2   #a3					
buscarDesde: #buscarDesde(dir array, valor, pos, longitud)

	subu $sp, $sp, 32
	sw $ra, 12($sp)
	sw $fp, 8($sp)
	addiu $fp, $sp, 28
	
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	sw $a2, -8($fp)
	sw $a3, -12($fp)
	
	bgt $a2, $a3, caso_1
	
	#prepare cadena[pos]
	li $t5, 4
	mult $a2, $t5
	mflo $t0 
	add $t0, $a0, $t0
	lw $t0, 0($t0)
	
	beq $t0, $a1, caso_2
	
	addiu $a2, $a2, 1
	jal buscarDesde
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	lw $a2, -8($fp)
	lw $a3, -12($fp)
	
	b fin_buscar
	
	
	
	caso_2:
		
		move $v0, $a2
		b fin_buscar
	
	
	
	caso_1:
	
		li $v0, -1
	
	
	fin_buscar:
	
		lw $ra, 12($sp)
		lw $fp, 8($sp)
		addiu $sp, $sp, 32
		jr $ra