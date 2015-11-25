	.data
str:    .asciiz "10104"
	.text
	.globl main
	
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str
	jal atoi
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

atoi:
	li $t0, 0 #digit
	li $t1, 0 #res
	move $t2, $a0 #*s
	
while:
	lb $t3, 0($t2)
	
	blt $t3, '0', endwhile
	bgt $t3, '1', endwhile
	
	add $t2, $t2, 1
	
	subi $t0, $t3, '0'
	
	li $t4, 10
	
	mul $t1, $t4 ,$t1
	add $t1, $t1, $t0
	
	j while
	
endwhile:
	move $v0, $t1
	jr $ra