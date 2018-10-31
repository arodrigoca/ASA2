## Arquitectura de Computadores curso 2016-2017
## fact.asm -- A program to compute the factorial of 10
## main--
## Registers used:
## $a0 - syscall parameter -- the number to print
## $v0 - syscall parameter and return value
.data
msg: .asciiz "The factorial of 3 is: "
.text
main: la $a0, msg
li $v0, 4 # Load syscall print-string into $v0
syscall # Make the syscall
li $a0,3 # Put argument (3) in $a0
jal fact # Call factorial function
move $a0, $v0 # Move fact result in $a0
li $v0, 1 # Load syscall print-int into $v0
syscall # Make the syscall
li $v0, 10 # Load syscall exit into $v0
syscall # Make the syscall

## fact
## Registers used:
## $a0
fact:

bgt $a0, 1, fact2 #comprobar la condición antes de crear pila
li $v0, 1
jr $ra

fact2:

subu $sp, $sp, 32 # Stack frame is 32 bytes long
sw $ra, 20($sp) # Save return address
sw $fp, 16($sp) # Save frame pointer
addiu $fp, $sp, 28 # Set up frame pointer
sw $a0, 0($fp) # Save argument (n) en la pila

#calcula el factorial de n-1
#lw $v1, 0($fp) # Load n
 subu $a0, $a0, 1 # Compute n - 1
 jal fact

#recuperamos n
 lw $v1, 0($fp) # Load n
 mul $v0, $v0, $v1 # Compute fact(n-1) * n
 
 
return_fact:
lw $ra, 20($sp)
 lw $fp, 16($sp)
 addiu $sp, $sp, 32
 jr $ra