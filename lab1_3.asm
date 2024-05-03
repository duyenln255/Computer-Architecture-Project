#Write a MIPS program to print out the result of F:
#F = (a − 10) × (b + d) × (c − 2 × a)/(a + b + c)
#where a, b, c, and d are numbers inserted by the user. Note that a, b, c,
#and d are inserted in this exact order. The output of division should print
#both the quotient and the remainder.
#The input prompts should be as such: ”Insert a: ”, ”Insert b: ”, etc.
#For example, if the input is 3, 4, 5, 6 then the output should be: F = 5,
#remainder 10.
.data 
promptA: .asciiz "Insert a: "
promptB: .asciiz "Insert b: "
promptC: .asciiz "Insert c: "
promptD: .asciiz "Insert d: "
output: .asciiz "F = "
remainder: .asciiz ", remainder "
period: .asciiz "."
endl: .asciiz "\n"
.text 
	li $v0, 4		#print promptA
	la $a0, promptA
	syscall 
	
	li $v0, 5		#get interger a
	syscall
	move $t0, $v0

	li $v0, 4		#print promptB
	la $a0, promptB
	syscall 
	
	li $v0, 5		#get interger b 
	syscall
	move $t1, $v0
	
	li $v0, 4		#print promptC
	la $a0, promptC
	syscall 
	
	li $v0, 5		#get interger c
	syscall
	move $t2, $v0
	
	li $v0, 4		#print promptD
	la $a0, promptD
	syscall 
	
	li $v0, 5		#get interger d
	syscall
	move $t3, $v0

	sub $t4, $t0, 10	#a-10
	add $t5, $t1, $t3	#b+d
	
	mul $t4, $t4, $t5	#(a − 10) × (b + d)
	mul $t5, $t0, 2		#ax2
	sub $t6, $t2, $t5	#(c − 2 × a)
	mul $t4, $t4, $t6	#(a − 10) × (b + d) × (c − 2 × a)
	
	add $t5, $t0, $t1	#a + b
	add $t5, $t5, $t2	#a + b + c
	
	div  $t4,$t5
	
	mfhi $t6 	# use mfhi to acess HI
	mflo $t7		#use mflo to acess LO
	
	
	li $v0, 4
	la $a0, output
	syscall 
	
	li $v0, 1
	move $a0, $t7
	syscall 
	
	li $v0, 4
	la $a0, remainder
	syscall 
	
	li $v0, 1
	move $a0, $t6
	syscall
	

exit:
	li $v0, 10 
	syscall 
