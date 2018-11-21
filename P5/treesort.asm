.data

.text

li $s2, 0

main:

move $a0, $s2 #prepare first argument
li $a1, 0 #prepare second argument
li $a2, 0 #prepare third argument

jal tree_node_create

move $s0, $v0 #save the node in $s0, as we need $v0 to make the syscall, S0 is then our root node

#lw $a0, 0($s0)
#li $v0, 1
#syscall

#lw $a0, 4($s0)
#li $v0, 1
#syscall

#lw $a0, 8($s0)
#li $v0, 1
#syscall


in_loop:

	li $v0, 5
	syscall
	move $s1, $v0 #s1 is the number introduced by the user
	beq $v0, $s2, print #$s2 is the stop value, 0
	
	#arguments for tree_insert
	move $a0, $s1 #first argument is number introduced by user
	move $a1, $s0 #second argument is root node
	
	jal tree_insert
	
	#
	#tree_insert will create the node itself
	b in_loop



tree_insert: #a0 is val and $a1 is root

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 24 #set up frame pointer to a1 
	sw $a1, 0($fp)
	sw $a0, 4($fp)
	
	#call tree_node_create
	#no need to move a0 to a0 because val is val in tree_node_create
	
	move $a0, $a0 #not necessary, but i kept it to make my mind clear
	li $a1, 0
	li $a2, 0
	jal tree_node_create
	
	lw $a0, 4($fp)
	lw $a1, 0($fp)
	
	
	#v0 will be the created node address. In the pdf pseudocode, new_node is this value, v0.
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra



print:

	li $v0, 10
	syscall


tree_node_create:

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 12($sp) # Save frame pointer
	addiu $fp, $sp, 20 #set up frame pointer to a2 
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
	
	#retrieve ra and fp
	lw $ra, 16($sp)
	lw $fp, 12($sp)
	addiu $sp, $sp, 32
	jr $ra


memory_error:

	li $v0, 10
	syscall





