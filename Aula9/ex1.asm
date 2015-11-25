	.data
str:	.asciiz "Ola"
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str
	jal strlen
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
	
strlen:
	#recebe em $a0 um array de characters
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	lb $t0, 0($a0) #*s
	
if:
	beq $t0, '\0', else
	
	addiu $a0, $a0, 1 #s++
	jal strlen
	addi $v0, $v0, 1
	
	j end
	
else:
	li $v0, 0
	
end:

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
	
