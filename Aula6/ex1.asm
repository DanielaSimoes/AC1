	.eqv SIZE, 3
	.data
str1:   .asciiz "Array"
str2:	.asciiz "de"
str3:   .asciiz "ponteiros"
	.align 2
array:  .word str1, str2, str3
	.text
	.globl main
main:
	#*array = $t0
	la $t0, array
	#t1 = i = 0
	li $t1, 0
for:
	bge $t1, SIZE, endfor
	sll $t2, $t1, 2 #i*4
	
	li $v0, 4
	lw $a0, array($t2)
	syscall
	
	li $v0,11
	or $t0, $0, '\n'
	syscall
	
	addi $t1, $t1, 1
	j for
endfor:
	jr $ra
	
	
	