#ex4
	.eqv MSK,  0xF0000000
	.eqv MSKN, 0x0FFFFFFF
	.data
str1:   .asciiz "Inteiro em decimal: "
str2:   .asciiz "\nEm hexadecimal: 0x"
	.text 
	.globl main
main:
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0 
	li $v0, 4
	la $a0, str2
	syscall
	li $t3, 7
	li $t1, MSK
	
for:	
	blt $t3, 0, endfor
	and $t2, $t0, $t1
if:
	beqz $t2, if2
	move $t4, $t3
while:
	beqz $t4, endwhile
	srl $t5, $t2, 4
	andi $t6, $t5, MSKN
	move $t2, $t6
	add $t4, $t4, -1 
	j while
endwhile:
if2:
	bgt $t2, 9, else
	or $a1, $0, '0'
	add $t2, $t2, $a1
	j endif
else:
	or $a1, $0, 'A'
	add $t7, $a1, -10
	add $t2, $t2, $t7
endif:
	li $v0, 11
	move $a0, $t2
	syscall
	srl $t8, $t1, 4
	andi $t8, $t8, MSKN
	move $t1, $t8
	sub $t3, $t3, 1
	j for
endfor:
	li $v0, 11
	or $a0, $0, '\n'
	syscall
end:
	jr $ra