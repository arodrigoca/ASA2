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

jal hanoi


li $v0, 10
syscall


hanoi: #(n, start, finish, extra)

	bne $a0, 0, hanoi_recursivo
	jr $ra


hanoi_recursivo:

#operaciones de pila

	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 12($sp) # Save return address
	sw $fp, 8($sp) # Save frame pointer
	addiu $fp, $sp, 16
	sw $a3, 0($fp)  
	sw $a2, 4($fp)
	sw $a1, 8($fp)
	sw $a0, 12($fp)
	
#-----------------------------------------------------

#ahora, hay que llamar de nuevo a hanoi(n-1, start, extra, finish)

#antes: a0,   	a1,    	a2,    	a3
#ahora: a0-1    a1,	a3,	a2

	subu $a0, $a0, 1 #a0 is now a0-1
	move $t0, $a3 #use a t register to store a2. This is necessary to flip the 2 registers
	move $a3, $a2 #same
	move $a2, $t0 #same. now a2 is a3
	
	jal hanoi
	
	#restore previous values
	
	lw $a3, 0($fp)
	lw $a2, 4($fp)
	lw $a1, 8($fp)
	lw $a0, 12($fp)
	
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
	
	move $a0, $t0
	
	
	#--------prepare new values
	
	subu $a0, $a0, 1
	move $t0, $a3
	move $t1, $a2
	move $t2, $a1
	
	move $a1, $t0
	move $a3, $t2
	
		
	jal hanoi
	
	
	lw $ra, 12($sp) #el ra y el fp solo se tienen que recuperar cuando haces jr
	lw $fp, 8($sp)
	addiu $sp, $sp, 32 
 	jr $ra
	


#-------------------------------------------------------





