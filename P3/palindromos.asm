#recorrer una cadena introducidas por el usuario

.data

cad: .space 1024
endMessage: .asciiz "La palabra es un palindromo"
badMessage: .asciiz "La palabra NO es un palindromo"

.text

li $v0, 8
la $a0, cad
li $a1, 1024
syscall

li $v0, 4
la $a0, cad
syscall


la $s0, cad
li $v0, 11

next:
lb $t0, 0($s0)

addi $s0, $s0, 1

li $t1, '\n'
beq $t0, $t1, ndetectada

b next


ndetectada:

#el registro s1 es el inicio de la palabra y el registro s0 es el final de la palabra

subi $s0, $s0, 2
la $s1, cad
b compara


compara:

#la dir de memoria de s0 es el final y la s1 es el principio, El caracter va a ser registro 5 y 6

lb $t5, 0($s0)
lb $t6, 0($s1)
addi $s1, $s1, 1
subi $s0, $s0, 1
bne $t5, $t6, incorrecta
beq $s0, $s1, correcta
b compara

incorrecta:

li $v0, 4
la, $a0, badMessage
syscall
b fin



correcta:

li $v0, 4
la, $a0, endMessage
syscall
b fin


fin:

li, $v0, 10
syscall