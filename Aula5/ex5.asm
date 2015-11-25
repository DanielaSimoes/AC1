	.data
array:	.space 40
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
	
	#para o print
	la $s2, array
	
	# ---- Ordenacao ----
	# t3 => i
	# t4 => j
	li $t3, 0
	
	la $a2, array
	

forLer:
	bge $t0, 10, for_1
	
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
	
for_1: 
	#if i>= 9 -> imprimir
	bge $t3, 9, Imprimir
	
	# j = i + 1
	addi $t4, $t3, 1
	
for_2:
	
	#if j <  10 --> for 1
	blt $t4, 10, if
	
	# i++
	addi $t3, $t3, 1
	j for_1

if:
	#lista[i] = t5
	#lista[j] = t6
	# i * 4 = a0
	# j * 4 = a1
	
	#i*4
	sll $a0, $t3, 2
	
	#j*4
	sll $a1, $t4, 2
	
	#lista[i]
	lw $t5, array($a0)
	#lista[j]
	lw $t6, array($a1)
	
	#if lista[i] > lista[j]
	
	ble $t5, $t6, inc
	
	#aux = s3
	move $s3, $t5
	
	sw $t6, array($a0)
	sw $s3, array($a1)
	
	# j++
	addi $t4, $t4, 1
	
	j for_2
	
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
	
inc:
	# j++
	addi $t4, $t4, 1
	
	j for_2
	
end:
	jr $ra