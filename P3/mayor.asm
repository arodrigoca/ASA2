#ejemplo para comparar dos números
#si son iguales hay que imprimir una cadena y luego se termina

.data

numero1: .word 0
numero2: .word 0
cadena: .asciiz "Los numeros son iguales\n"
cadena1: .asciiz "El número mayor es: "

.text

main:

li, $v0, 5
syscall
move $t6, $v0 
li, $v0, 5
syscall
move $t7, $v0

beq $t6, $t7, igual
bgt $t6, $t7, mayor
bgt $t7, $t6, menor


mayor:

la $a0, cadena1
li $v0, 4
syscall

move $a0, $t6
li $v0, 1
syscall
b fin


menor:

la $a0, cadena1
li $v0, 4
syscall

move $a0, $t7
li $v0, 1
syscall
b fin


igual:

la $a0, cadena
li $v0, 4
syscall
b fin


fin:

li $v0, 10
syscall

