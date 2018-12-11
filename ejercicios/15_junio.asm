.data

	text: .asciiz

.text


main:
	#s1 will be string address and $s0 will be the first node on the list
	li $a0, ','
	li $a1, 0
	jal create_node
	move $s0, $v0

	#read the characters
	la $s1, text
	move $a0, $s1
	li $a1, 1024
	li $v0, 8
	syscall
	#v0 contains adress of asciiz
	
	move $t0, $s1
	main_loop:
		
		
		move $a1, $s0
		lb $a0, 0($t0)
		beq, $a0, '\n', fin
		jal push_node
		move $s0, $v0
		addiu $t0, $t0,  1
		b main_loop
	
	fin:
	move $a0, $s0
	jal print_list
	li $v0, 10
	syscall


remove_node:

	


print_list: #print(p->top)

	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	
	lw $t0, 4($a0)
	
	beq $t0, 0, print_char
	
	case_2: #not equal to null
		lw $a0, 4($a0)
		jal print_list
		lw $a0, 0($fp)
	
	print_char:
		
		lb $a0, 0($a0)
		beq $a0, ',', fin_print
		li $v0, 11
		syscall
		lw $a0, 0($fp)
		
		li $v0, 11
		li $a0, '\n'
		syscall
		lw $a0, 0($fp) #restore value
	
	fin_print:
	
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addiu $sp, $sp, 32
		jr $ra
	


push_node: #push_node(char , p->top)
	
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28

	jal create_node
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)	
	addiu $sp, $sp, 32
	jr $ra
	
	
	
	#v0 contains the new node address
	

create_node: #create_node(char, address to next node)

	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	li $a0, 8
	li $v0, 9
	syscall
	
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	
	sb $a0, 0($v0)
	sw $a1, 4($v0)
	
	move $v0, $v0
	
	
	end_create_node:
	
		lw $ra, 20($sp)
		lw $fp, 16($sp)
		addiu $sp, $sp, 32
		jr $ra