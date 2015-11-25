	.eqv SIZE,3
	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:   .asciiz "\nString #"
str5:   .asciiz ": "
	.align 2
array:	.word str1, str2, str3
	.text
	.globl main
main:
	#t0 = i
	li $t0, 0

for:
	bge $t0, SIZE, endfor
	
	li $v0, 4
	la $a0, str4
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, str5
	syscall
	
	#t1 = j
	li $t1, 0
	#i*4
	sll $t2, $t0, 2 
	#t3 = array[i]
	lw $t3, array($t2) 
	
while:
	#adicionar ao início do array[i] o j
	add $t4, $t3, $t1
	lb $t4, 0($t4)
	beq $t4, '\0', endwhile
	
	#print char
	or $a0, $0, $t4
	li $v0, 11
	syscall
	
	or $a0, $0, '-'
	li $v0, 11
	syscall
	
	#j++
	addi $t1, $t1, 1
	
	j while

endwhile:
	addi $t0, $t0, 1
	j for
	
endfor:
	jr $ra
