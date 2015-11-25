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
		
	for:
		#se for maior ou igual a 32 passa para o endfor
		bge $t1, 32, endfor
		andi $t2, $t0, 0x80000000
		#if
		li $v0, 11
		
		bnez $t2, else
		ori $a0, $0, '0'
		j endif
		
	else: 
		
		li $v0, 11
		ori $a0, $0, '1'
				
	endif: 
		syscall
		sll $t0, $t0, 1
		addi $t1, $t1, 1
		j for
		
	endfor: 
		jr $ra 
