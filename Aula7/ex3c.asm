	.eqv STR_MAX_SIZE, 10	
	.data
buf:    .space 11
str:    .asciiz "String too long. Nothing done!"
	.text
	.globl main
main:
#	Parametros de entrada: int argc, char *argv[]
	li $t9, 1
	move $s0, $a0
	move $s1, $a1
	beq $s0, $t9, if2
	
if2:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lw $a2, ($a1)
	move $a0, $a2
	jal strlen
	
	bgt $v0, STR_MAX_SIZE, else
	
	la $a0, buf
	
	lw $a2, ($a1)
	move $a1, $a2
	
	jal strcpy
	move $a0, $v0
	li $v0, 4
	syscall
	
	j endif

else:
	li $v0, 4
	la $a0, str
	syscall
	
	#return 1
	move $v0, $t9
	j end
	
endif:
	move $v0, $0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
end:
	#return 0
	jr $ra
	
strcpy:
#	Parametros de entrada: *dst, *src
# 	Retorno: *dst

	# t0 => src
	move $t0, $a1
	#t1 => dst
	move $t1, $a0
	
	# tmp => t2
	move $t2, $t1
	
do:
	lb $t3, 0($t0)
	sb $t3, 0($t1)
	  
	beqz $t3, stopwhile
	addi $t0, $t0, 1 # src
	addi $t1, $t1, 1 # dst
	j do
	
stopwhile:
	move $v0, $t2 #valor de retorno
	jr $ra
	
strlen:
	li $v0, 0
	li $t0, 0
	
loop:
	lb $t0, 0($a0)

	addiu $a0, $a0, 1
	beqz $t0, endLoop
	#len++
	addiu $v0, $v0, 1
	j loop
	
endLoop:
	jr $ra
	