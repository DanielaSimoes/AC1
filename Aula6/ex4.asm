	.data
str1:	.asciiz "\nP"
str2:	.asciiz ": "
str3:   .asciiz "Nr. de parametros: "
	.text
	.globl main
main:
	#argc.length()
	move $t0, $a0
	
	li $v0,4
	la $a0, str3
	syscall
	
	li $v0,1
	or $a0, $0, $t0
	syscall
	
	#t1 = i = 0
	li $t1, 0
	
for:
	bge $t1, $t0, endfor
	
	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0,1
	or $a0, $0, $t1
	syscall
	
	li $v0, 4
	la $a0, str2
	syscall
	
	#i*4
	sll $t2, $t1, 2
	add $t3, $t2, $a1
	
	lw $a0, 0($t3)
	li $v0, 4
	syscall
	
	addi $t1, $t1, 1
	
	j for
	
endfor:
	li $v0, 0
	jr $ra
	
	