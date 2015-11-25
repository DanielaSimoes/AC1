	.data
	str1: .asciiz "Introduza um número: "
	str2: .asciiz "\nO valor em octal "
 	.text
 	.globl main
 	
	main:
	
		#print da str1
		li $v0,4 
		la $a0, str1 
		syscall
		
		#leitura do valor, o retorno e em v0
		li $v0,5 
		syscall 
		#entao armazena-se em t0 (value)
		or $t0, $0, $v0
		
		#print str2
		li $v0,4 
		la $a0, str2 
		syscall
		
		# i = 11
		li $t1, 11
		
	while:
		#t2 = value & 0xE0000000
		andi $t2, $t0, 0xE0000000
		# if (value & 0xF0000000) != 0 => do
		bnez $t2, do
		# if i <= 0 -> do
		ble $t1, 0, do
		 
		# value = value << 3
		sll $t0, $t0, 3
		# i --
		subi $t1, $t1, 1
		
		j while
		
	do: 
	
		#digito = (value & 0xE0000000) >> 30
		andi $a0, $t0, 0xE0000000
		srl $a0, $a0, 30
		
		li $v0, 1
		syscall
		
		#value = value << 3
		sll $t0, $t0, 3
		# i--
		sub $t1, $t1, 1
		bgtz $t1, do
	
		
		
