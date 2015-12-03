	.data
str1:   .asciiz " - Mover disco de topo de "
str2:	.asciiz " para "
str3:	.asciiz "\nIntroduza o numero de discos: "
str4:	.asciiz "\n"
	.text
	.globl main
	
main:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	li $s0, 4
	
	jal rafa
	
	addi $s0, $s0, 1
	
	lw $s0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	jr $ra
	
rafa:
	addiu $sp, $sp, -4
	sw $s0, 0($sp)
	
	li $s0, 5
	
	addiu $sp, $sp, 4
	jr $ra	
