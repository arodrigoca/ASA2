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
li $a0,4 # Put argument (3) in $a0
jal fact # Call factorial function
move $a0, $v0 # Move fact result in $a0
li $v0, 1 # Load syscall print-int into $v0
syscall # Make the syscall
li $v0, 10 # Load syscall exit into $v0
syscall # Make the syscall
move $v0, $a0

## fact
## Registers used:
## $a0
fact:
 bgtz $v0, fact_recur # fact(n-1)
 li $v0, 1
 b return_fact
 
fact_recur:

#------------esto es lo relacionado con la creacion de pila y correspondientes operaciones de guardado
subu $sp, $sp, 32 # Stack frame is 32 bytes long
sw $ra, 20($sp) # Save return address
sw $fp, 16($sp) # Save frame pointer
addiu $fp, $sp, 28 # Set up frame pointer
sw $a0, 0($fp) # Save argument (n)
lw $v0, 0($fp) #Esto coge lo que valía a0 y lo deja en v0
#---------------------------------------------------------------------------------------------------

lw $v1, 0($fp) # Load n
 subu $v0, $v1, 1 # Compute n - 1
 move $a0, $v0 # Move value to $a0
 jal fact

 lw $v1, 0($fp) # Load n
 mul $v0, $v0, $v1 # Compute fact(n-1) * n
 
 
return_fact:
lw $ra, 20($sp)
 lw $fp, 16($sp)
 addiu $sp, $sp, 32 #liberar la memoria dejando el stack pointer al principio de la pila para fact 0
 jr $ra
