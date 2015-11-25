	.data 
array:  .word 7692, 23, 5, 234
	.text
	.globl main
	
main:
	#t0 = p
	#t1 = pultimo
	#t2 = *p
	#t3 = soma
	
	la $t0, array
	la $t1, array+12
	li $t3, 0
	
while:
	# while( p <= pultimo ) 
	bgt $t0, $t1, endwhile
	
	lw $t2, 0($t0)
	
	#soma = soma + (*p)
	add $t3, $t3, $t2
	#p++
	addi $t0, $t0,4
	
	j while
	
endwhile:
	li $v0, 1
	or $a0, $0, $t3
	syscall
	
	jr $ra
	
	
	