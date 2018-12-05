.data

.text

main:
	
	li $v0, 5 #get the first node so we can start somewhere
	syscall
	move $s0, $v0
	move $a0, $s0
	li $a1, 0
	jal node_create
	move $s0, $v0 #update root node
	
	main_loop:
		li $v0, 5
		syscall
		beq $v0, 0, end_read #check if value is 0
		move $a1, $v0 #move the value to the second argument, a1
		move $a0, $s0 #move the root node to first argument, a0
		jal insert_node
		#now v0 is 0 if root node didnt change or v0 will contain new root node
		beq $v0, 0, main_loop
		move $s0, $v0 #update root node

		b main_loop
		


node_create: #a0 is the value of the node. a1 is the next pointer. Returns address of created node

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 20($sp) # Save frame pointer
	addiu $fp, $sp, 24 #set up frame pointer to a1
	sw $a1, 0($fp) #store arguments
	sw $a0, 4($fp)
	
	li $v0, 9  #invoke heap allocation
	li $a0, 8
	syscall
	
	lw $a0, 4($fp) #restore a0
	lw $a1, 0($fp) #restore a1, but it's not necessary
	
	
	beq $v0, 0, end_read
	sw $a0, 0($v0) #store node data on the heap
	sw $a1, 4($v0)
	
	lw $ra, 16($sp) #end subrutine
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra

#--node_t*insert_node(node_t*first, int val)
insert_node: #a0 is the address of the root node. a1 is the value of the new node to insert. returns 0 if root node changed. othersie, returns node address.

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 20($sp) # Save frame pointer
	addiu $fp, $sp, 24 #set up frame pointer to a1
	sw $a1, 0($fp) #store arguments
	sw $a0, 4($fp)
	
	#create new node
	
	move $a0, $a1
	li $a1, 0
	jal node_create
	#v0 pointer to created node
	lw $a0, 4($fp) 
	lw $a1, 0($fp)
	#case 1, new node is now the first one
	
	lw $t0, 0($a0)
	bgt $a1, $t0, case1
	
	
	case1:
		
		sw $a0, 4($v0)
		#return v0 which is the new node
		lw $ra, 16($sp) #end subrutine
		lw $fp, 20($sp)
		addiu $sp, $sp, 32
		jr $ra
	
		
	lw $ra, 16($sp) #end subrutine
	lw $fp, 20($sp)
	addiu $sp, $sp, 32
	jr $ra


#--void print(node_t*first)
#--a0: first

print:

	bne $a0, 0, print_rec

	jr $ra

print_rec:
	
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	
	#comprobar si first es 0 retornar
	
	
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	
	jr $ra


end_read:
	
	
	li $v0, 10
	syscall

