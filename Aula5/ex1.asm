	.data 
array:  .space 20
ini:    .asciiz "Introduza uma numero: "
	.text
	.globl main
	
main:
	#i = t0
	# lista = t1
	#lista[i] = t2
	#v0 = valor lido
	# int i = 0
	li $t0, 0
	#fui buscar o endereço do array
	la $t1, array
	li $t2, 0
	

for:
	bge $t0, 5, endfor
	
	# print "introduza um num"
	li $v0, 4
	la $a0, ini
	syscall
	
	# ler num -> retornado em v0
	li $v0, 5
	syscall
	
	# lista[i] = 4*i
	sll $t2, $t0, 2
	
	#adicionar ao endereço incial
	add $t2, $t2, $t1
	
	sw $v0, 0($t2)
	
	#i++
	addi $t0, $t0, 1
	
	j for
	
endfor:
	jr $ra