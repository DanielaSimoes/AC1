	.data
value:  .float 2.59375
zero:  	.float 0.0
	.text 
	.globl main
main:
	
	l.s $f0, zero
	
do:

	li $v0, 5
	syscall
	
	mtc1 $v0, $f1 # $f1 => val, move-se o que se ler de v0 para f1
	
	cvt.s.w $f1, $f1 #leu-se um inteiro, e necessario trabalhar com floats portanto converte-se o valor de inteiro para float (single precision)
	
	l.s $f2, value
	
	mul.s $f12, $f1, $f2
	
	li $v0, 2
	syscall
end:
	
	c.eq.s $f12, $f0
	bc1f do
	
	li $v0, 0
	
	jr $ra
	
	