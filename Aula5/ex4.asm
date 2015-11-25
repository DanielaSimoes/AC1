	.data
array:  .space 40
ini:    .asciiz "Introduza um numero: "
	.text
	.globl main
	
main:
	# ---- LEITURA ----
	# int i = 0
	li $t0, 0
	#fui buscar o endereço do array
	la $t1, array
	li $t2, 0
	
	# ---- ORDENACAO ----
	
	# houveTroca => t3
	# aux => t4
	# p => t5
	# pUltimo => t6
	# *p => t7
	
	# pUltimo = lista
	la $t6, array
	# pUltimo + size-4
	addi $t6, $t6, 36
	
	#para o print
	la $s2, array
	
forLer:
	bge $t0, 10, doOrdenar
	
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
	
	j forLer
	
doOrdenar:
	# p = lista
	la $t5, array	
	#houveTroca = false
	li $t3, 0

forOrdenar:
	
	# if p >= pUltimo
	bge $t5, $t6, endfor
	
	# if *p > *(p+1)
	# *p
	lw $t7, 0($t5)
	#*(p+1)
	lw $t8, 4($t5)
	#if
	ble $t7, $t8, inc
	
	#aux = *p
	move $t4, $t7
	
	sw $t8, 0($t5)
	sw $t4, 4($t5)
	
	#houveTroca = 1
	li $t3, 1
	
	#p++
	addi $t5, $t5, 4
	
	j forOrdenar

inc:
	addi $t5, $t5, 4
	j forOrdenar
	
endfor:
	#if houveTroca = 0 --> imprimir
	beq $t3, 1, doOrdenar
	
Imprimir:
	bge $s1, 10, end
	
	#buscar o *p
	lw $t0, 0($s2)
	
	#print *p
	or $a0, $0, $t0
	li $v0, 1
	syscall
	
	
	#p++
	addi $s2, $s2, 4
	#i++
	addi $s1, $s1, 1
	
	j Imprimir

end:
	jr $ra
	
	
