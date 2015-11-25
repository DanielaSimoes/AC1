	.data 
	.text
	.globl main

main:

	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 10
	li $a1, 2
	jal print_int_ac1
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
print_int_ac1:
	
	# não tem valor de retorno
	# argumentos: unsigned int num, unsigned int base
	
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
if:
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
	ble $a0, '9', end
	addi $a0, $a0, 7
end:
	move $v0, $a0
	
	jr $ra
	
	