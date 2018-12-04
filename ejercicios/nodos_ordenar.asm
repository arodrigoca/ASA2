.data

.text

main:
	
	li $v0, 5 #get the first node so we can start somewhere
	syscall
	move $s0, $v0
	move $a0, $s0
	li $a1, 0
	jal node_create
	move $s0, $v0
	
	main_loop:
		li $v0, 5
		syscall
		beq $v0, 0, end_read #check if value is 0
		move $a1, $v0 #move the value to the second argument, a1
		move $a0, $s0 #move the root node to first argument, a0
		jal insert_node
		move $s0, $v0 #update root node
		
		li $v0, 1
		lw $a0, 0($s0)
		syscall
		
		
		li $v0, 1
		lw $a0, 4($s0)
		syscall
		
		b main_loop

node_create: #a0 is the value of the node. a1 is the next pointer. Returns address of created node

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 20($sp) # Save frame pointer
	addiu $fp, $sp, 24 #set up frame pointer to a1
	sw $a1, 0($fp) #store arguments
	sw $a0, 4($fp)
	
	li $v0, 9  #invoke heap allocation
	li $a0, 12
	syscall
	
	move $t0, $v0 #store the memory address the SO gave in t0
	
	lw $a0, 4($fp) #restore a0
	lw $a1, 0($fp) #restore a1, but it's not necessary
	
	sw $a0, 0($t0) #store node data on the heap
	sw $a1, 4($t0)
	beq $t0, 0, end_read
	
	lw $ra, 16($sp) #end subrutine
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra


insert_node: #a0 is the address of the root node. a1 is the value of the new node to insert. returns 0 if root node changed. othersie, returns node address.

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 20($sp) # Save frame pointer
	addiu $fp, $sp, 24 #set up frame pointer to a1
	sw $a1, 0($fp) #store arguments
	sw $a0, 4($fp)
	
	lw $a0, 0($fp) #prepare values for create_node
	lw $a1, 4($fp)
	
	jal node_create
	
	
	lw $a0, 4($fp)
	lw $a1, 0($fp)
	
	lw $t0, 0($v0) #t0 is the value of the new node
	lw $t1, 0($a0) #t1 is the value of the first node
	
	bgt $t0, $t1, end_read
	
	
	lw $ra, 16($sp) #end subrutine
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra



end_read:

	li $v0, 10
	syscall

