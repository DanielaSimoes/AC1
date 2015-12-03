	.data
array:	.space 88
str:	.asciiz "\n"
str2:   .asciiz "Ordenados \n"
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t4, 0
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
	jal sort
	
	#li $v0, 3
	#mov.d $f12, $f0
	#syscall
	
	lw $ra, 0($sp)
	subiu $sp, $sp, 4
	
	jr $ra
	
# ---------------------------------------------------------------	
	
sort:
	#argumentos: double *array, int nval
	
	#houve troca = t0
	#i = t1
	#aux = f6
	addiu $sp, $sp, -8
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	
do:
	li $t0, 0
	li $t1, 0
	subiu $t5, $a1, 1 #nval -1
	
for:
	bge $t1, $t5, endfor
	
	sll $t3, $t1, 3
	addu $t3, $t3, $a0
	
	l.d $f2, 0($t3)	#array[i]
	l.d $f4, 8($t3) #array[i+1]
	
if:
	c.le.d $f2, $f4
	bc1t endif
	
	mov.d $f6, $f2 #aux = array[i]
	s.d $f4, 0($t3) # array[i] = array[i+1]
	s.d $f6, 8($t3) #array[i+1] = aux
	
	li $t0, 1
	
endif:
	addiu $t1, $t1, 1
	
	j for
	
endfor:
	beq $t0, 1, do
	
	li $v0, 4
	la $a0, str2
	syscall
	
	la $t7, array
for_print:

	bge $t6, 11, end

	li $v0, 3
	l.d $f12, 0($t7)
	syscall
	
	li $v0, 4
	la $a0, str
	syscall
	
	addiu $t7, $t7, 8
	addiu $t6, $t6, 1
	
	j for_print

end:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	addiu $sp, $sp, 8

	divu $a1, $a1, 2
	sll $a1, $a1, 3
	addu $a1, $a1, $a0
	
	l.d $f0, 0($a1)
	
	jr $ra
