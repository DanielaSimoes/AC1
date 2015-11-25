	.eqv SIZE, 10
	.eqv SIZE4, 40
	.data
str1:   .asciiz "Media: "
str2:   .asciiz "\nVariancia"
#val:    .word 8, 4, -3, 5, 124, 15, -1987, 9, 27, 16
val:    .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.text
	.globl main
main:   la $t0, val
	addi $t1, $t0, SIZE4
	li $t2, 0
	li $t5, 0
	li $t6, 0
for:    bge $t2, SIZE, endfor
	move $t7, $t2
	sll $t7, $t7, 2
	lw $t8, val($t7)
	add $t5, $t5, $t8
	addi $t2, $t2, 1
	j for
	
endfor:
	div $t4, $t5, SIZE
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
for_2:
	bge $t0, $t1, endfor2
	lw $t7, 0($t0)
	sub $t3, $t7, $t4
	mul $a3, $t3, $t3
	mfhi $a0
	mflo $a1
	
	beq $a0, 0, lo
	beq $a0, -1, lo
	
	beq $a1, 0, hi
	beq $a1, -1, hi
	
	j for_2
	
lo:
	add $t6, $t6, $a1
	j for_2

hi:
	add $t6, $t6, $a0
	j for_2
	
endfor2:
	li $v0, 4
	la $a0, str2
	syscall
	li $v0, 1
	div $t9, $t6, SIZE
	move $a0, $t9
	syscall
end:
	jr $ra
	
