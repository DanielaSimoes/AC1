	.data
	.text
	.globl main
	
main:
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 6
	li $a1, 5
	jal divisor
	
	move $a0, $v1
	li $v0, 1
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra

divisor:
	
	#dividendo => $a0
	#divisor => $a1
	#t0 => i
	#t1 => bit
	#t2 => quociente
	#t3 => resto
	
	 sll $a1, $a1, 16
	 
	 andi $a0, $a0, 0xFFFF 
	 sll $a0, $a0, 1
	 
	 li $t0, 0 #i
for:	
	li $t1, 0
	bge $t0, 16, endfor
	
ifDiv:
	blt $a0, $a1, endifDiv
	subu $a0, $a0, $a1
	li $t1, 1
endifDiv:
	sll $a0, $a0, 1
	or $a0, $a0, $t1
	
	addi $t0, $t0, 1 #i++
	
	j for

endfor:
	srl $t3, $a0, 1
	andi $t3, $t3, 0xFFFF0000
	
	andi $t2, $a0, 0xFFFF
	
	or $v0, $t3, $t2
	
	jr $ra