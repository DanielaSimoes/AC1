	.data
str1:	.asciiz "String de teste"
buf1:	.space 30
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a1, str1
	la $a0, buf1
	jal strcpy
	move $a0, $v0
	li $v0, 4
	syscall	

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra

strcpy:
	# valor de retorno : ponteiro para um array de characters
	# argumentos : $a0 ponteiro do destino, $a1 ponteiro da source
	
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	lb $t1, 0($a1)
	
if:
	sb $t1, 0($a0) #*dst = *src
	beqz $t1, endif
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	
	jal strcpy
	
endif:
	lw $v0, 4($sp)	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra