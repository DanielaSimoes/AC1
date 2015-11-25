	.data
str:    .asciiz "String"
	.text
	.globl main
	
main:

	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str
	jal strrev
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	li $v0, 0
	jr $ra

strrev:
	addiu $sp, $sp, -8
	sw $ra, 0($sp) #save the return address
	sw $a0, 4($sp) #save the argument
	# a0 = argument
	# a1 = p2
	move $a1, $a0
	# a0 = p1
	move $s0, $a0 #guardar um valor q não é alterado
	
while:
	lb $t2, 0($a1)
	beqz $t2, decrement
	addi $a1, $a1, 1 #p2++
	j while
	
decrement:
	addi $a1, $a1, -1
	
while2:
	bge $a0, $a1, endwhile2
	jal exchange
	addi $a0, $a0, 1
	addi $a1, $a1, -1
	j while2

endwhile2:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	move $v0, $s0
	addiu $sp, $sp, 8
	jr $ra
	
exchange:
	lb $v0, 0($a0)
	lb $v1, 0($a1)
	sb $v1, 0($a0)
	sb $v0, 0($a1)
	jr $ra
	

	
	
	