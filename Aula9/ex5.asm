	.data
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 3
	jal fact
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
fact:
	# valor de retorno : unsigned int 
	# argumento : unsigned int numero
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	bleu $a0, 12, endif
	
	li $v0, 10
	syscall
	
endif:
	
	bleu $a0, 1, return_else
	subiu $a0, $a0, 1
	
	jal fact
	
	lw $a0, 4($sp)
	mul $v0, $a0, $v0
	
	j end
	
return_else:
	
	li $v0, 1
	
end:	
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra