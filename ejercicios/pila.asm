.text

	li $a0, 0
	li $a1, 0
	jal create_node
	move $s0, $v0 #update s0 with the node with created
	
	main_loop:
		
		li $v0, 5
		syscall
		beq $v0, 0, end_program
		move $a1, $v0
		move $a0, $s0
		jal insert_node
		move $s0, $v0
		b main_loop
		


create_node: #create_node(int new value, pointer to next)

	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28 #inicialize frame pointer
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	li $v0, 9
	li $a0, 8
	syscall
	#now v0 is the node address
	
	#restore values
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	
	sw $a0, 0($v0)
	sw $a1, 4($v0)
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	jr $ra


insert_node: #insert_node(pointer to fiest node, int value of new node)

	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28 #inicialize frame pointer
	sw $a0, 0($fp)
	sw $a1, -4($fp)

	#first thing to do is create the node
	lw $a0, -4($fp) #value in to a0
	lw $a1, 0($fp)   #adress of first node as the next pointer
	jal create_node
	
	lw $a0, 0($fp) #restore values
	lw $a1, -4($fp)
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	jr $ra

remove_node: #remove_node(pointer to top, int value to remove)

	#en principio, no necesito hacer pila
	move $t1, $a0
	
	remove_loop:
		
		lw $t2, 4($t1)
		beq $t2, 0, caso_1
		lw $t3, 0($t2) #i need t2.val
		beq $t3, $a1, caso_2
		move $t1, $t2
		b remove_loop
		
		
		caso_2:
			
			lw $t3, 4($t2) #get $t2.next
			sw $t3, 4($t1) #store t2.next in t1.next
			move $v0, $t2
			jr $ra
		
		caso_1:
		
			li $v0, 0
			jr $ra


print_tree: #print_tree(->first_node)

	
	subu $sp, $sp, 32
	sw $ra, 24($sp)
	sw $fp, 20($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	
	lw $t0, 4($a0)
	beq $t0, 0, print_number
	
	lw $a0, 4($a0)
	jal print_tree
	
	lw $a0, 0($fp)
	
	
	print_number:
		
		lw $a0, 0($a0)
		beq $a0, 0, fin_print
		li $v0, 1
		syscall
		lw $a0, 0($fp) #restore value
		
		li $v0, 11
		li $a0, '\n'
		syscall
		lw $a0, 0($fp) #restore value
	
	fin_print:
	
		lw $ra, 24($sp)
		lw $fp, 20($sp)
		addi $sp, $sp, 32
		jr $ra
	


end_program:

	li $v0, 5
	syscall
	#v0 contains integer read
	beq $v0, 0, skip
	move $a1, $v0 #prepares arguments to remove
	move $a0, $s0 
	
	jal remove_node
	
	
	skip:
	move $a0, $s0
	jal print_tree
	li $v0, 10
	syscall
