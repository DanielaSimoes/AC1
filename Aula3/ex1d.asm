	.data
	str1: .asciiz "Introduza um número: "
	str2: .asciiz "\nO valor em binario"
 	.text
 	.globl main
 	
	main:   #print da str1
		li $v0,4 
		la $a0, str1 
		syscall
		
		#leitura do valor, o retorno e em v0
		li $v0,5 
		syscall 
		#entao armazena-se em t0
		or $t0, $0, $v0
		
		#print str2
		li $v0,4 
		la $a0, str2 
		syscall
		
		#inicializacao do i
		li $t1, 0
		li $t3, 0
		li $t5, 0
		
	for:
		#se for maior ou igual a 32 passa para o endfor
		bge $t1, 32, endfor
		andi $t2, $t0, 0x80000000
		srl $t2, $t2, 31
		
		addi $t4, $t2, 0x30
		
		sll $t0, $t0, 1
		addi $t1, $t1, 1
			
		bne $t5, 1, verify
		
		j print
	
	set:
		li $t5, 1
		j print
		
	print:
		or $a0, $0, $t4
		ori $v0, $0, 11
		syscall
		
		j for
		
	verify: 
		beq $t2, $1, set
		j for
		
	
	else:
		
		
	endfor: 
		jr $ra 
