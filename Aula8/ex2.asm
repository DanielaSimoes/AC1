	.data
buf:    .space 33
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 15
	li $a1, 16
	la $a2, buf
	jal print_int_ac1
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
itoa:
	move $t0, $a0 #n
	move $t1, $a1 #b
	move $t2, $a2 #p = s
	
	li $t3, 0 #digit
	
do:
	#digit = n%b
	rem $t3, $t0, $t1
	#n = n/b
	div $t0, $t0, $t1
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $a0, $t3
	jal toascii
	
	sb $v0, 0($t2)
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	#p++
	addi $t2, $t2, 1
	
enddo:
	bgt $t0, 0, do
	
	li $t5, '\0'
	sb $t5, 0($t2)
	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	#char *s
	move $a0, $a2
	jal strrev
	
	move $v0, $a2
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
strrev:
	addiu $sp, $sp, -8
	sw $ra, 0($sp) #save the return address
	sw $a0, 4($sp) #save the argument
	# a0 = argument
	# a1 = p2
	move $a1, $a0
	# a0 = p1
	move $s0, $a0 #guardar um valor q não é alterado
	
while:
	lb $t2, 0($a1)
	beqz $t2, decrement
	addi $a1, $a1, 1 #p2++
	j while
	
decrement:
	addi $a1, $a1, -1
	
while2:
	bge $a0, $a1, endwhile2
	jal exchange
	addi $a0, $a0, 1
	addi $a1, $a1, -1
	j while2

endwhile2:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	move $v0, $s0
	addiu $sp, $sp, 8
	jr $ra
	
exchange:
	lb $v0, 0($a0)
	lb $v1, 0($a1)
	sb $v1, 0($a0)
	sb $v0, 0($a1)
	jr $ra
	
toascii:
	addi $a0, $a0, '0'
	ble $a0, '9', endif
	addi $a0, $a0, 7
endif:
	move $v0, $a0
	jr $ra
	
print_int_ac1:

	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal itoa
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
