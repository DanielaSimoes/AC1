#EX1	
	.eqv CHAR_BIN_LEN 33
	.eqv MS_BIT 31
	.data
bin_nbr: .space CHAR_BIN_LEN
str_1:  .asciiz "Inteiro em decimal: "
str_2:  .asciiz "Em binario e: "
	.text
	.globl main
main: 
	li $v0,4
	la $a0, str_1
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0,4
	la $a0, str_2
	syscall
	
	li $t1, MS_BIT
	
for: 
	bltz $t1, endfor
	srlv $t2, $t0, $t1
	andi $t4, $t2, 1
	beqz $t4, else
	li $t5,'1'
	sb $t5, bin_nbr($t3)
	addi $t3, $t3, 1
	addi $t1, $t1, -1
	j for
else:
	li $t5, '0'
	sb $t5, bin_nbr($t3)
	addi $t3, $t3, 1
	addi $t1, $t1, -1
	j for
	
endfor:
	or $t5, $0, '\0'
	sb $t5, bin_nbr($t3)
	li $v0, 4
	la $a0, bin_nbr
	syscall
	
end: jr $ra
	
