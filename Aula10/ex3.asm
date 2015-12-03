	.data
array:	.space 192
soma:	.double 0.0
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
	jal average
	
	li $v0, 3
	mov.d $f12, $f0
	syscall
	
	lw $ra, 0($sp)
	subiu $sp, $sp, 4
	
	jr $ra
	
average:
	#valor de retorno: double res
	#argumentos: double *array, unsigned int n
	
	li $t0, 0 #i
	
for:	
	bge $t0, $a1, endfor
	
	sll $t1, $t0, 3
	addu $t1, $t1, $a0
	
	ldc1 $f4, 0($t1)
	add.d $f2, $f2, $f4
	
	addi $t0, $t0, 1 # i++
	
	j for
	
endfor:
	beqz $a1, end
	
	mtc1 $a1, $f6
	cvt.d.w $f6, $f6
	
	div.d $f0, $f2, $f6
	
end:	
	
	jr $ra