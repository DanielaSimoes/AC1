	.data 
ini:    .asciiz "Introduza uma string: "
str:    .space 20
	.text
	.globl main
	
main:
	# print string
	la $a0, ini
	li $v0, 4
	syscall
	
	#read string
	la $a0, str
	li $a1, 20
	li $v0, 8
	syscall
	
	#t0 = p
	la $t0, str
	
loop:
	# t1 = *p
	lb $t1, 0($t0)
	# while (*p != '\0') 
	beq $t1, '\0', endloop
	
	blt $t1, 'A', endif
	bgt $t1, 'Z', endif
	
	#*p = *p – 'a' + 'A'
	subi $t1, $t1, 'A'
	addi $t1, $t1, 'a'
	
	sb $t1, 0($t0)
	
endif:

	#p++
	addi $t0, $t0, 1
	j loop
	
endloop:
	
	#print string
	la $a0, str
	li $v0, 4
	syscall
	
	jr $ra