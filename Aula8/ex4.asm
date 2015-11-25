	.data
buf:    .space 33
str:    .asciiz "\nOperacao desconhecida"
str2:   .asciiz "\nNumero de argumentos errado"
	.text
	.globl main
	
main:
	subiu $sp, $sp, -28
	sw $ra, 0($sp)
	sw $s0, 4($sp) # val1
	sw $s1, 8($sp) # val2
	sw $s2, 12($sp) # res
	sw $s3, 16($sp) # exit_code
	sw $s4, 20($sp) # $a1
	sw $s5, 24($sp) # $op
	move $s4, $a1
	
if1:
	bne $a0, 3, else1
	
	# val1 = atoi(argv[1]);
	
	lw $a0, 0($s4)
	jal atoi
	move $s0, $v0 
	
	# val2 = atoi(argv[2]);
	
	lw $a0, 8($s4)
	jal atoi
	move $s1, $v0
	
	# ---
	
	lw $s5, 4($s4)
	lb $s5, 0($s5)
	# t0 = op
ifX:
	bne $s5, 'x', elseB
	mul $s2, $s0, $s1
	j continue

elseB:
	bne $s5, '/', elseP
	move $a0, $s0
	move $a1, $s1
	jal divisor
	j continue
	
elseP:
	bne $s5, '%', else
	move $a0, $s0
	move $a1, $s1
	jal divisor
	srl $s2, $v0, 16

	j continue
	
else:
	li $v0, 4
	la $a0, str
	syscall
	li $s3, 1
	j continue

else1:
	li $v0, 4
	la $a0, str2
	syscall
	li $s3, 2
	j continue
	
continue:
	bnez $s3, endMain
	
	move $a0, $s0
	li $a1, 10
	jal print_int_ac1
	
	li $v0, 11
	move $a0, $s5
	syscall
	
	move $a0, $s1
	li $a1, 10
	jal print_int_ac1
	
	li $v0, 11
	ori $a0, $0, '='
	syscall
	
	move $a0, $s2
	li $a1, 10
	jal print_int_ac1
	
endMain:
	move $v0, $s2
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addiu $sp, $sp, 28
	jr $ra
	
itoa:
	addiu $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	
	move $s0, $a0 #n
	move $s1, $a1 #b
	move $s2, $a2 #p
	move $s3, $a2 #s
	
do:
	#digit = n%b
	rem $t3, $s0, $s1
	#n = n/b
	div $s0, $s0, $s1
	
	move $a0, $t3
	jal toascii
	
	sb $v0, 0($s2)
	
	#p++
	addi $s2, $s2, 1
	
enddo:
	bgt $s0, 0, do
	
	li $t5, '\0'
	sb $t5, 0($s2)
	
	#char *s
	move $a0, $s3
	jal strrev
	
	move $v0, $s3
		
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp, $sp, 20
	
	jr $ra
	
strrev:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $a0, 12($sp)
	
	# char p1 = str
	move $s0, $a0
	
	# char p2 = str
	move $s1, $a0
	
while:
	lb $t2, 0($s1)
	beqz $t2, decrement
	addi $s1, $s1, 1 #p2++
	j while
	
decrement:
	addi $s1, $s1, -1
	
while2:
	bge $s0, $s1, endwhile2
	jal exchange
	addi $s0, $s0, 1
	addi $s1, $s1, -1
	j while2

endwhile2:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $v0, 12($sp)
	addiu $sp, $sp, 16
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
	
atoi:
	li $t0, 0 #digit
	li $t1, 0 #res
	move $t2, $a0 #*s
	
whileAtoi:
	lb $t3, 0($t2)
	
	blt $t3, '0', endwhileAtoi
	bgt $t3, '9', endwhileAtoi
	
	add $t2, $t2, 1
	
	subi $t0, $t3, '0'
	
	li $t4, 10
	
	mul $t1, $t4 ,$t1
	add $t1, $t1, $t0
	
	j whileAtoi
	
endwhileAtoi:
	move $v0, $t1
	jr $ra
	

print_int_ac1:

	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a2, buf
	jal itoa
	
	move $a0, $v0
	li $v0, 4
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
	 
	 andi $t4, $a0, 0xFFFF 
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
