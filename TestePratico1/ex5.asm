#ex5
	.eqv SIZE, 25
	.data
pal:    .space SIZE
pal_inv: .space SIZE
str1:   .asciiz "introduza uma palavra: "
str2:   .asciiz "E palindromo! \n"
str3:   .asciiz "Nao e palindromo! \n"
	.text
	.globl main
main:
	li $t1, 0
	li $t2, 1
	la $t3, pal
	addi $t3, $t3, -1
	
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 8
	li $a1, SIZE
	la $a0, pal
	syscall
	
while:
	lb $t4, 0($t3)
	beq $t4, '\0', endwhile
	addi $t1, $t1, 1
	addi $t3, $t3, 1
	j while
endwhile:
	move $t0, $t1
	add $t0, $t0, -1
for:
	bltz $t0, endfor
	
	move $t5, $t1
	sub $t5, $t5, 1
	sub $t5, $t5, $t0
	lb $t7, pal_inv($t5)
	lb $t8, pal($t0)
	sb $t8, pal_inv($t5)
	sub $t0, $t0, 1
	j for
endfor:
	li $t0, 0
for2:
	bge $t0, $t1, endfor2
	lb $t7, pal_inv($t0)
	lb $t8, pal($t0)
	beq $t7, $t8, for2
	li $t2, 0
	j endfor2
endfor2:
	beqz $t2, else
	li $v0,4
	la $a0, str2
	syscall 
	j end
else:
	li $v0, 4
	la $a0, str3
	syscall
end: jr $ra
