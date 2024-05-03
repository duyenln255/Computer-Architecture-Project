#Write a MIPS program that does the following steps:
#1. Request the user to insert 2 integers. Please prompt ”Insert a: ” and
#”Insert b: ”
#2. Return the result of the addition and subtraction on those 2 integers.
#For example, if the user input 4, then 5, the output should be a + b = 9
#and a - b = -1.
.data 
promptA: .asciiz "Insert a: "
promptB: .asciiz "Insert b: "
plus: .asciiz "a + b = "
subt: .asciiz "a - b = "
endl: .asciiz "\n"


.text 
	li $v0, 4		#print string mode
	la $a0, promptA	
	syscall 
	
	li $v0, 5		#Get integer mode
	syscall 
	add $t0, $0, $v0 	# Move integer from $v0 to register $a0
	
	li $v0, 4		#print string mode
	la $a0, promptB
	syscall
	
	li $v0, 5		#Get integer mode
	syscall 
	add $t1, $0, $v0 	# Move integer from $v0 to register $a1
	
	add $t2, $t0, $t1	# a+b
	sub $t3, $t0, $t1	#a -b
	
	li $v0, 4		#print string mode
	la $a0, plus	
	syscall 
	
	li $v0, 1		# Print integer a0
	#print a + b
	move $a0, $t2
	syscall
	
	li $v0, 4		#print string mode
	la $a0, endl	
	syscall 
	
	li $v0, 4		#print string mode
	la $a0, subt	
	syscall 
	
	li $v0, 1		# Print integer a0
	move $a0, $t3		#print a - b
	syscall
exit:
	li $v0, 10
	syscall 	
