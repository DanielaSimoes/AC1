	.data 
array:  .word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
a:      .asciiz "-"
c:      .asciiz "\nConteudo do array:\n"
	.text
	.globl main
	
main:
	# t0 = *p
	# t1 = i
	# t2 = p = array
	la $t2, array
	
	# print c
	li $v0, 4
	la $a0, c
	syscall
	
for:
	bge $t1, 10, endfor
	
	#buscar o *p
	lw $t0, 0($t2)
	
	#print *p
	or $a0, $0, $t0
	li $v0, 1
	syscall
	
	# print a
	li $v0, 4
	la $a0, a
	syscall
	
	#p++
	addi $t2, $t2, 4
	#i++
	addi $t1, $t1, 1
	
	j for
	
endfor:
	jr $ra
	
	
