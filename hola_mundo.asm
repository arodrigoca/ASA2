# Mi programa hola mundo
# Esto son comentarios
.data
str:
.asciiz "Hola en MIPS32\n"
num: .word 12
.text
main: la $a0, str
li $v0, 4
syscall
li $v0, 10
syscall

#las etiquetas apuntan a datos o instrucciones
#la etiqueta main tiene como valor el valor de memoria de la primera instrucción
#las etiquetas apuntan a cosas en text segment o en data segment
#el registro pc dice la siguiente instrucción que se ha ejecutado