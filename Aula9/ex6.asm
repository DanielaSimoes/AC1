	.data
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 2
	li $a1, 2
	
	jal xtoy
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra

xtoy:
	# valor de retorno int
	# argumentos: int x, int y
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	beqz $a1, return1
	
	subiu $a1, $a1, 1
	jal xtoy
	
	mul $v0, $v0, $a0
	
	j end
	
return1:
	li $v0, 1
	
end:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
	