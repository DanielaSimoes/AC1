	.data
	str1: .asciiz "Introduza um número: "
	str2: .asciiz "\nO valor em hexadecimal "
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
		
		# i = 8
		li $t1, 8
		
	while:
		#t2 = value & 0xF0000000
		andi $t2, $t0, 0xF0000000
		# if (value & 0xF0000000) != 0 => do
		bnez $t2, do
		# if i <= 0 -> do
		ble $t1, 0, do
		 
		# value = value << 4
		sll $t0, $t0, 4
		# i --
		subi $t1, $t1, 1
		
		j while
		
	do: 
	
		#digito = (value & 0xF0000000) >> 28
		andi $t3, $t0, 0xF0000000
		srl $t3, $t3, 28
		#if(digito <= 9) 
		# if t3 > 9 => else
		bgt $t3, 9, else
		ble $t3, 9, if
		
		j do
		
	else:
		# somar (digito + '0' + 7)
		add $a0, $t3, 0x30
		add $a0, $a0, 7
		
		#print t4
		li $v0, 11
		syscall
		
		j endif
		
	if:
		#print print_char(digito + '0')
		# somar (digito + '0')
		add $a0, $t3, 0x30
		
		#print t5
		li $v0, 11
		syscall
		
		j endif
		
	endif:
		#value = value << 4
		sll $t0, $t0, 4
		# i--
		sub $t1, $t1, 1
		bgtz $t1, do
	
	exit: 
		jr $ra
	
		
		
	
		
