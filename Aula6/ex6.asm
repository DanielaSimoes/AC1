	.eqv SIZE, 12
	# 12 = 4 * 3
	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz	"\nString #"
str5:	.asciiz ": "
	.align 2
array:	.word str1, str2, str3

	.text
	.globl main
	
main:
	la $t0, array
	
	#pultimo
	add $t1, $t0, SIZE
	
	# i = 1 = t5
	li $t5, 1
	
for:
	bge $t0, $t1, endfor
	
	li $v0, 4
	la $a0, str4
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
	
	li $v0, 4
	la $a0, str5
	syscall
	 
	# j = 0 = t3
	
	li $t3, 0
	lw $t2, 0($t0)
	
while:
	#t4 = char
	lb $t4, 0($t2)
	beq $t4, '\0', endwhile
	
	li $v0, 11
	move $a0, $t4
	syscall

	li $v0, 11
	or $a0, $0,'-'
	syscall
	
	addi $t2, $t2, 1
	
	j while

endwhile:
	addi $t0, $t0, 4
	addi $t5, $t5, 1
	j for
	
endfor:
	jr $ra
	
