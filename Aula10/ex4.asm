	.data
array:	.space 192
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $t5, array
for_read:
	bge $t4, 11, endfor_read
	
	li $v0, 7
	syscall
	
	s.d $f0, 0($t5)
	
	addiu $t5, $t5, 8
	addiu $t4, $t4, 1
	
	j for_read
	
endfor_read:

	la $a0, array
	li $a1, 11
	jal max
	
	li $v0, 3
	mov.d $f12, $f0
	syscall
	
	lw $ra, 0($sp)
	subiu $sp, $sp, 4
	
	jr $ra
	
max:	
	# argumentos: double *array unsigned int n 
	addiu $sp, $sp, -4
	sw $a0, 0($sp)
	
	# f0 = max
	li $t1, 0 # contador
for:
	bge $t1, 11, endfor
	
	l.d $f2, 0($a0)
	c.le.d $f2, $f0		#if value>max
	bc1f replace
	
	addiu $a0, $a0, 8
	addiu $t1, $t1, 1
	j for
	
replace:
	
	mov.d $f0, $f2
	
	addiu $a0, $a0, 8
	addiu $t1, $t1, 1
	j for

endfor:
	lw $a0, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
