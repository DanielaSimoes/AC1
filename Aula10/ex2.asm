	.data 
cinco:	.double 5.0
nove:   .double 9.0
td:	.double 32.0
test:	.double 1.0
	.text 
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	l.d $f12, test
	
	jal f2c
	
	li $v0, 3
	mov.d $f12, $f0
	syscall
	
	lw $ra, 0($sp)
	subiu $sp, $sp, 4
	
	jr $ra
	
f2c:	
	# ºC = 5/9*(ºF - 32)
	#Parametros de entrada: double ft
	#Parametros de entrada: double res
	
	l.d $f2, td
	l.d $f4, nove
	l.d $f6, cinco
	
	sub.d $f0, $f12, $f2 # F - 32
	mul.d $f0, $f0, $f6
	div.d $f0, $f0, $f4 
	
	jr $ra