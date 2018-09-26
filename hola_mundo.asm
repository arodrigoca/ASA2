# Mi programa hola mundo
# Esto son comentarios
.data
str:
.asciiz "Hola Mundo en MIPS32\n"
.word 0xCAFEBACA #traza
.text
main: 
la $a0, str
li $v0, 4
syscall
li $v0, 10
syscall

#las etiquetas apuntan a datos o instrucciones
#la etiqueta main tiene como valor el valor de memoria de la primera instrucción
#las etiquetas apuntan a cosas en text segment o en data segment
#el registro pc dice la siguiente instrucción que se ha ejecutado
#Directivas (los .algo) no generan instrucciones como tal, son para el ensamblador
#Las direcciones se ponen siempre en hexadecimal
#Dentro del mapa de memoria, existe la pila(te lo da el sistema operativo), el segmento de datos(También lo da el OS) y el segmento de código()
#Directiva .data = datos en la memoria de datos
#STR estará en la primera dirección del segmento de datos(en este caso, a partir de la 0x10010000, puedes verlo en labels)
#un caracter ascii ocupa 1 byte en memoria por lo que se ve
