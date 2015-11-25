	.data
str1:   .asciiz " - Mover disco de topo de "
str2:	.asciiz " para "
str3:	.asciiz "\nIntroduza o numero de discos: "
str4:	.asciiz "\n"
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0 #ndiscs
	
	la $a0, str3
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0 #ndiscs
	
if_main:
	blez $t1, else
	move $a0, $t1
	li $a1,1
	li $a2,3
	li $a3,2
	jal tohanoi
	
	j end_main
else_main:
	li $v0, 0
	
end_main:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra	

tohanoi:
	# não retorna nada
	# argumentos: n, p1, p2, p3
	addiu $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp) #n
	sw $s1, 8($sp) #p1
	sw $s2, 12($sp) #p2
	sw $s3, 16($sp) #p3
	sw $s4, 20($sp) #count
	
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3

	beq $s0, 1, else
	subiu $a0, $s0, 1 # n--
	move $a1, $s1
	move $a2, $s3
	move $a3, $s2
	
	jal tohanoi
	
	addi $s4, $s4, 1 #++count
	move $a0, $s1
	move $a1, $s2
	move $a2, $s4
	jal print_msg
	
	subi $a0, $s0, 1
	move $a1, $s3
	move $a2, $s2
	move $a3, $s1
	jal tohanoi
	
	j end
	
else:
	move $a0, $s1
	move $a1, $s2
	addi $a2, $s4, 1
	
	jal print_msg
	
end:
	lw $ra, 0($sp)
	lw $s0, 4($sp) #n
	lw $s1, 8($sp) #p1
	lw $s2, 12($sp) #p2
	lw $s3, 16($sp) #p3
	lw $s4, 20($sp) #count
	addiu $sp, $sp, 24
	
	jr $ra
	
print_msg:

	# não tem valor de retorno
	# argumentos: int t1, int t2, in cnt
	
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp) #t1
	sw $a1, 8($sp) #t2
	sw $a2, 12($sp) # cnt
	
	li $v0, 4
	la $a0, str4
	syscall
	
	lw $a0, 12($sp)
	li $a1, 10
	jal print_int_ac1
	
	la $a0, str1
	li $v0, 4
	syscall
	
	lw $a0, 4($sp)
	li $a1, 10
	jal print_int_ac1
	
	la $a0, str2
	li $v0, 4
	syscall
	
	lw $a0, 8($sp)
	li $a1, 10
	jal print_int_ac1
	
end_print_msg:
	lw $ra, 0($sp)
	lw $a0, 4($sp) #t1
	lw $a1, 8($sp) #t2
	lw $a2, 12($sp) # cnt
	addiu $sp, $sp, 16
	
	jr $ra
	
print_int_ac1:
	
	# não tem valor de retorno
	# argumentos: unsigned int num, unsigned int base
	
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
if_print:
	divu $t0, $a0, $a1
	beqz $t0, endif
	
	move $a0, $t0
	
	jal print_int_ac1
	
endif:
	lw $a0, 4($sp)
	
	rem $a0, $a0, $a1
	
	jal toascii
	
	move $a0, $v0
	li $v0, 11
	syscall
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra

toascii:
	addi $a0, $a0, '0'
	ble $a0, '9', end_toascii
	addi $a0, $a0, 7
end_toascii:
	move $v0, $a0
	
	jr $ra

	
	
