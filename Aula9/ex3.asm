	.data
array:  .word 1, 1, 1, 3	
	.text
	.globl main
	
main:
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, array
	li $a1, 4
	jal soma
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
soma:
	# valor de retorno : int
	# argumentos: $a0 ponteiro para um array, $a1 numero de elementos
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp) # value
	
if:	
	beqz $a1, else
	
	lw $s0, 0($a0)
	addi $a0, $a0, 4
	addi $a1, $a1, -1
	
	jal soma
	add $v0, $v0, $s0
	
	j end
	
else:
	move $v0, $0

end:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	
	jr $ra
