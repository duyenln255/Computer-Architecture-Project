#Write a MIPS program to print out the 4-bit binary value of a decimal
#number. The number should be selected by the user.
#The input shall be restricted only to a positive integer that is less than 16.
#The input prompt should be: ”Please enter a positive integer less than 16:
#”.
#For example, if the decimal number is 10 then the output should be Its
#binary form is: 1010.
.data 
prompt: .asciiz "Please enter a positive integer less than 16: "
output: .asciiz "Its binary form is: "
endl: .asciiz "\n"
binary: .space 4		#4 for binary digits 
.text 
main:
	li $v0, 4		#print string mode
	la $a0, prompt
	syscall 
	
	li $v0, 5		#get integer mode
	syscall 
	move $t0, $v0		#move the input to $t0
#inputCheck
	bge $t0, 16, main	#if $t0 >=16 jumb to main

	li $v0, 4		#print output
	la $a0, output
	syscall 
# Prepare to convert to binary
    la $t1, binary  		# load address of the binary string
    li $t2, 4       		# count=$t2 = 4 (binary digits)
    li $t3, 2       		# $t3 = 2 
    addi $t1, $t1, 3  		# $t1 point to the last digit place 

convertLoop:
# $t0(decimal number)/2, quotient in $t0, remainder in $t4
    div $t0, $t3
    mflo $t0
    mfhi $t4

    addi $t4, $t4, '0'		#Convert remainder to ASCII ('0' or '1')
    sb $t4, 0($t1) 		#lưu ký tự $t4 vào địa chỉ $t1, last digit place vs do lech = 0
    
    addi $t1, $t1, -1		# Move the pointer backwards for the next digit
    subi $t2, $t2, 1		# count++
    bnez $t2, convertLoop  	# t2 = 0, $t1 = , break/Loop until 4 digits are processed, 

    li $v0, 4			#print output
    la $a0, output
    syscall

    # Move pointer back to the start of the binary string
    addi $t1, $t1, 1
    
    li $t2, 4       		# Reset count = 4 to print 
printloop:
    lb $a0, 0($t1) 
    li $v0, 11			#print character mode
    syscall
    addi $t1, $t1, 1		#Tăng địa chỉ mà $t1 trỏ tới lên 1
    subi $t2, $t2, 1		#count--
    bnez $t2, printloop 	#count = 0, end loop

exit:
	li $v0, 10
	syscall 
