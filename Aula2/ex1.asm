.text
.globl main

main:   
	ori $t0, $0, 0x12345678
	ori $t1, $0, 0x0000000F
	ori $t7, $0, 0x1ABCE543
	and $t2,$t0,$t1
	or $t3,$t0,$t1
	nor $t4,$t0,$t1
	xor $t5,$t0,$t1
	#ex 1d
	nor $t6,$0,$t7
