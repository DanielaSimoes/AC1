	.data
str:    .asciiz "String de teste"
	.text
	.globl main
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str
	jal strlen
	#a0 fica com o valor de retorno
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	jr $ra

strlen:
	li $v0, 0
	
loop:
	lb $t0, 0($a0)
	addiu $a0, $a0, 1
	beqz $t0, end
	#len++
	addiu $v0, $v0, 1
	j loop
	
end:
	jr $ra
