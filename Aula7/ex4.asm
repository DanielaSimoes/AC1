	.data
str2:   .space 50
str1:   .asciiz "Arquitetura de "
str3:   .asciiz "Computadores"
	.text 
	.globl main
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a1, str1
	la $a0, str2
	jal strcpy
	
	la $a0, str2
	la $a1, str3
	jal strcat
	
	move $a0, $v0
	li $v0, 4
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

strcat:
#	Parametros de entrada: *dst, *src
#	Retorno: dst

	#char *p = dst
	move $t0, $a0
	move $t7, $a0
	
while:
	#*p
	lb $t2, 0($t0)
	beqz $t2, endwhile
	addiu $t0, $t0, 1 # p++
	
	j while

endwhile:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $a0, $t0
	jal strcpy
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	move $v0, $t7
	
	jr $ra

strcpy:
#	Parametros de entrada: *dst, *src
# 	Retorno: *dst

	# t0 => src
	move $t0, $a1
	#t1 => dst
	move $t1, $a0
	
	# i => t2
	li $t2, 0
	
do:
	add $t4, $t2, $t0 #src[i]
	add $t5, $t2, $t1 #dst[i]
	
	lb $t6, 0($t4)
	sb $t6, 0($t5)
	  
	lb $t8, 0($t4)
	beqz $t8, stopwhile
	addi $t2, $t2, 1 # i++
	
	j do
	
stopwhile:
	move $v0, $t1 #valor de retorno
	jr $ra
	
