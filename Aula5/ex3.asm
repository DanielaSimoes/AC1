	.data 
array:  .space 40
ini:    .asciiz "Introduza uma numero: "
	.text
	.globl main

main:
	#i = t0
	#v0 = valor lido
	# int i = 0
	li $t0, 0
	#fui buscar o endereço do array
	la $t1, array
	#t4 = array
	la $t4, array
	
	la $s2, array

for:
	bge $t0, 10, do
	
	# print "introduza um num"
	li $v0, 4
	la $a0, ini
	syscall
	
	# ler num -> retornado em v0
	li $v0, 5
	syscall
	
	# t1 = p 
	sw $v0, 0($t1)
	
	#i++
	addi $t0, $t0, 1
	#p++
	addi $t1, $t1, 4
	
	j for
	
do:
	#houvetroca = t3 => 0 = false
	li $t3, 0
	li $t9, 0
	
forBubble:
	
	#t3 = i
	bge $t9, 9, endforBubble
	# t5 = lista[i]
	# t6 = lista[i+1]
	
	sll $t4, $t9, 2
	lw $t5, array($t4)
	
	addi $t4, $t4, 4
	lw $t6, array($t4)
	
	bge $t5, $t6, endif
	
	#ha troca
	li $t3, 1
	
	#t7 = aux
	move $t7, $t5
	
	addiu $t4, $t4, -4
	sw $t6, array($t4)
	
	addiu $t4, $t4, 4
	sw $t7, array($t4)
	
	
endif:

	addi $t9, $t9, 1
	j forBubble
	
print: 
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
	
	j print
	

endforBubble:
	beq $t3, 1, do
	beqz $t3, print

end:
	jr $ra
