.data

startmsg: .asciiz "Introduce el numero de discos (1-8)\n"
mvdsk: .asciiz "Move disk "
frompeg: .asciiz "from peg "
topeg: .asciiz "to peg " 
endline: .asciiz "\n"


.text

la $a0, startmsg
li $v0, 4
syscall

li $v0, 5
syscall

move $a0, $v0 #a0 sera mi n

#estos son los argumentos pasados en la funcion de ejemplo
li $a1, 1 #start
li $a2, 2 #finish
li $a3, 3 #extra

jal main_hanoi


li $v0, 10
syscall


main_hanoi: #(n, start, finish, extra)

	bne $a0, 0, hanoi
	jr $ra


hanoi:

#operaciones de pila

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 12($sp) # Save return address
	sw $fp, 8($sp) # Save frame pointer
	addiu $fp, $sp, 28 # Set up frame pointer
	sw $a0, 0($fp) #salvar a0 en la pila
	subu $fp, $fp, 4 #mover el fp en la dir memoria inferior 
	sw $a1, 0($fp) #salvar a1
	subu $fp, $fp, 4
	sw $a2, 0($fp)
	subu $fp, $fp, 4
	sw $a3, 0($fp)
	addiu $fp, $fp, 12 #restaurar el fp a la cima de la pila
	
#-----------------------------------------------------

#ahora, hay que llamar de nuevo a hanoi(n-1, start, extra, finish)

#antes: a0,   	a1,    	a2,    	a3
#ahora: a0-1    a1,		a3,		a2

	subu $a0, $a0, 1 #a0 is now a0-1
	move $t0, $a2 #use a t register to store a2. This is necessary to flip the 2 registers
	move $t1, $a3 #same
	move $a3, $t0 #same. now a3 is a2
	move $a2, $t1 #same. now a2 is a3
	
	jal main_hanoi
	
	#restore previous values
	
	lw $a0, 0($fp)
	subu $fp, $fp, 4
	lw $a1, 0($fp)
	subu $fp, $fp, 4
	lw $a2, 0($fp)
	subu $fp, $fp, 4
	lw $a3, 0($fp)
	addiu $fp, $fp, 12
	
#print all the things

	move $t0, $a0 #save a0 so we can print strings. our n is now t0
	#-------------print a message
	li $v0, 4
	la $a0, mvdsk
	syscall
	#------------print an integer
	li $v0, 1
	move $a0, $t0
	syscall
	#-----------print a message
	li $v0, 4
	la $a0, frompeg
	syscall
	#----------print an integer
	li $v0, 1
	move $a0, $a1
	syscall
	#-----------print a message
	li $v0, 4
	la $a0, topeg
	syscall
	#----------print an integer
	li $v0, 1
	move $a0, $a3
	syscall
	#-----------print a message
	li $v0, 4
	la $a0, endline
	syscall
	#----------restore a0
	
	lw $a0, 0($fp)
	
	#----------------prepare hanoi next invocation, save current values
	

	addiu $fp, $sp, 28 # Set up frame pointer
	sw $a0, 0($fp) #salvar a0 en la pila
	subu $fp, $fp, 4 #mover el fp en la dir memoria inferior 
	sw $a1, 0($fp) #salvar a1
	subu $fp, $fp, 4
	sw $a2, 0($fp)
	subu $fp, $fp, 4
	sw $a3, 0($fp)
	addiu $fp, $fp, 12 #restaurar el fp a la cima de la pila
	
	
	#--------prepare new values
	
	subu $a0, $a0, 1
	move $t0, $a3
	move $t1, $a2
	move $t2, $a1
	
	move $a1, $a3
	move $a3, $a1
	
	jal main_hanoi
	
	lw $a0, 0($fp)
	subu $fp, $fp, 4
	lw $a1, 0($fp)
	subu $fp, $fp, 4
	lw $a2, 0($fp)
	subu $fp, $fp, 4
	lw $a3, 0($fp)
	addiu $fp, $fp, 12
	
	lw $ra, 12($sp)
	addiu $sp, $sp, 32 #aqui los valores deberian volver a ser 2 1 2 3
 	jr $ra
	


#-------------------------------------------------------





