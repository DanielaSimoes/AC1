#ex3	
	.eqv MAX 0x80000000
	.eqv MIN 0x7FFFFFFF
	.eqv SIZE, 10
	.data
val:    .word 8, 4, -3, 5, 124, 15, -8987, 9, 27, 16
str1:   .asciiz "Maximo: "
str2:	.asciiz "\nMinimo: "
	.text
	.globl main
main:
	li $t0, 0
	li $t1, MAX
	li $t3, MIN
for: 	
	bge $t0, SIZE, end
	move $t3, $t0
	sll $t3, $t3, 2
	lw $t4, val($t3)
if1:
	ble $t4, $t1, if2
	move $t1, $t4
if2:
	bge $t4, $t2, endif
	move $t2, $t4
endif:
	addi $t0, $t0, 1
	j for
end:
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 4
	la $a0, str2
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
endF:
	jr $ra	