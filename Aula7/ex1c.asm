	.data
str1:   .asciiz "\n"
str2:   .asciiz " - "
	.text
	.globl main
main:
	#len
	move $t2, $a0
	#i = 0
	li $t3, 0
	
for:
	bge $t3, $t2, endfor
	
	li $v0, 4
	la $a0, str1
	syscall
	
	sll $t4, $t3, 2 # i*4
	add $t4, $t4, $a1
	
	lw $t5, 0($t4)
	
	li $v0, 4
	move $a0, $t5
	syscall
	
	li $v0, 11
	la $a0, str2
	syscall
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $a0, $t5
	jal strlen
	#a0 fica com o valor de retorno
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	#i++
	addi $t3, $t3, 1
	
	j for

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
	
endfor:
	li $v0, 0
	jr $ra
