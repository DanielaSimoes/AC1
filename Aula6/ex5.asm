	.data
str1:	.asciiz "\nNumero de carateres:"
str2:	.asciiz "\nNumero de maiusculas: "
str3:   .asciiz "\nNumero de minusculas: "
str4:   .asciiz "\nString menor: "
	.text
	.globl main
main:
	#t0 = argc.length()
	move $t0, $a0
	
	#t1 = i = 0
	li $t1, 0
	#t2 = nMaiusculas
	#t4 = string maior
	#t5 = argv[i]
	#t6 = n carateres
	#t7 = char
	
for:
	bge $t1, $t0, endfor
	
	#i*4
	sll $t2, $t1, 2
	add $t3, $t2, $a1
	
	lw $t5, 0($t3)
	move $t8, $t5
	
	li $s3, 0

while:
	#onde começa a palavra + indice que percorre a string
	lb $t7, 0($t8)
	#se nao houver um char acaba o while
	beq $t7, '\0', endwhile
	
	#length++
	addi $s3, $s3, 1
	
	#print char
	or $a0, $0, $t7
	li $v0, 11
	syscall
	
	addi $t6, $t6, 1
	addi $t8, $t8, 1
	
	bge $t7, 'a', countm
	bge $t7, 'A', countM
	
	j while
	
countM:
	ble $t7, 'Z', incM
	j while
	
countm:
	ble $t7, 'z', incm
	j while
	
incM:
	addi $s1, $s1, 1
	j while
	
incm:
	addi $s2, $s2, 1
	j while
	
endwhile:
	#i++
	addi $t1, $t1, 1
	
	bgt $s3, $s2, mover
	
	j for
	
mover:
	move $s2, $s3
	move $s4, $t1
	j for
	
endfor:

	li $v0, 4
	la $a0, str1
	syscall
	
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, str3
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, str4
	syscall
	
	sll $s4, $s4, 2
	addu $s4, $a1, $s4
	lw $a0, 0($s4)
	li $v0, 4
	syscall
	
	li $v0, 0
	jr $ra
