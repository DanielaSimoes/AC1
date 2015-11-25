	.data
	str1: .asciiz "Introduza 2 numeros"
	str2: .asciiz "A soma dos dois numeros e:"	
	.text
	.globl main
main: 	
	#print str1
	la $a0, str1
	ori $v0, $0, 4
	syscall
	
	#ler primeiro num e armazenar em t0
	ori $v0, $0, 5
	syscall
	or $t0, $0, $v0
	
	#ler primeiro num e armazenar em t1
	ori $v0, $0, 5
	syscall
	or $t1, $0, $v0
	
	#fazer print str2
	la $a0, str2
	ori $v0, $0, 4
	syscall
	
	#fazer a soma
	add $t2, $t0, $t1
	
	#print do resultado
	or $a0, $0 ,$t2
	ori $v0, $0, 1
	syscall
	
	jr  $ra	#fim do programa
