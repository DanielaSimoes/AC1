	.data
	str1: .asciiz "Introduza dois números: "
	str2: .asciiz "Resultado: "
 	.text
 	.globl main
 	
	main:
	
		#print da str1
		li $v0,4 
		la $a0, str1 
		syscall
		
		#leitura do 1 valor, o retorno e em v0
		li $v0,5
		syscall 
		#t0 = mdor
		or $t0, $0, $v0
		
		#leitura do 2 valor, o retorno e em v0
		li $v0,5
		syscall 
		#t1 = mdo
		or $t1, $0, $v0
		
		# i = t2 = 0
		li $t2, 0
		
	while:
		beqz $t0, endwhile
		
		#se i >=4 -> endwhile
		bge $t2, 36, endwhile
		
		#i++
		add $t2, $t2, 1
		
		# mdor & 0x00000001
		andi $t3, $t0, 0x00000001
		# if (mdor & 0x00000001) != 0 
		beqz $t3, endif
		# res = res + mdo 
		add $t4, $t4, $t1
		
	endif:
		sll $t1, $t1, 1
		srl $t0, $t0, 1
		
		j while
		
	endwhile:
		
		# print da str2
		li $v0, 4
		la $a0, str2
		syscall
	
		# print do resultado
		li $v0, 36
		or $a0, $0, $t4
		syscall
		
		jr $ra
		
