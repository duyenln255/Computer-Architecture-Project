#Write a MIPS program that takes in a name as a string and print out a
#”Hello <name>!”.
#For example, if the input is John, then the output should be Hello, John.
.data 				#Directive, The following data items should be stored in the data segment.
prompt: .asciiz "Enter your name: "
output: .asciiz "Hello, "	#.asciiz - Store the string in memory and null-terminate it
exclamation: .asciiz "!"
name: .space 200		#create 100 bytes space

.text 				#The next items are put in the user text segment.
main:
	li $v0, 4		#print string
	la $a0, prompt
	syscall 
	
	li $v0, 8		#get string mode
	la $a0, name		# Get address to store string
	li $a1, 100 	# Input 100 characters into string (includes end of string)
	syscall 

	li $v0, 4		#print string output
	la $a0, output
	syscall 

	li $v0, 4		#print name 
	la $a0, name
	syscall 
	
exit:
	li $v0, 10		#terminate execution
	syscall
