.data

.text

li $s2, 0 

get_numbers:

	li $v0, 5
	syscall
	move $s1, $v0 #s1 is the number introduced by the user
	beq $v0, $s2, print #$s2 is the stop value, 0
	#here i do everything related to the tree
	#----------
	#----------------------------------------
	b get_numbers


print:

	li $v0, 10
	syscall


tree_node_create:

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 12($sp) # Save frame pointer
	addiu $fp, $sp, 12 #set up frame pointer to a2 
	sw $a2, 0($fp) #Save arguments
	sw $a1, 4($fp)
	sw $a0, 8($fp)
	
	li $v0, 9 #invoke heap allocation
	li $a0, 12
	syscall
	move $t0, $v0 #retrieve the memory addres the SO gave us
	
	lw $a0, 8($fp)#restore a0, because we wrote on in at the syscall
	
	sw $a0, 0($v0) #store value of the first node
	sw $a1, 4($v0) #store left of the first node
	sw $a2, 8($v0) #store right of the first node
	
	beq $v0, 0, memory_error #if there is no more memory available, end the program (needs improving)
	
	addiu $sp, $sp, 32
	jr $ra


memory_error:

	li $v0, 10
	syscall





