#Write a MIPS program to check if the elements of a 10-elements array
#are unique (appears only once in the array). If there are duplicated values in
#the array, print those values. The elements of the array must be inserted by
#the user after the prompt: ”Please insert your first element:”, ”Please insert
#your second element:”,etc. The outputs should be after the strings ”Unique
#values: ”, ”Duplicated values: ”. The duplicated values are separated by a
#semicolon as seen in the example below.
#For example, if the input is 1, 2, 3, 3, 3, 1, 7, 8, 9, 10 then the
#output should be Unique values: 2, 7, 8, 9, 10. Duplicated value: 3,
#repeated 3 times; 1, repeated 2 times..
#The program is required to check for wrong inputs such as: the input
#consist of non-integers and has more or less than 10 elements
.data
arr: .space 40 # 10 elements * 4 bytes
prompt1: .asciiz "Please insert your 1st element: "
prompt2: .asciiz "Please insert your 2nd element: "
prompt3: .asciiz "Please insert your 3rd element: "
prompt4: .asciiz "Please insert your 4th element: "
prompt5: .asciiz "Please insert your 5th element: "
prompt6: .asciiz "Please insert your 6th element: "
prompt7: .asciiz "Please insert your 7th element: "
prompt8: .asciiz "Please insert your 8th element: "
prompt9: .asciiz "Please insert your 9th element: "
prompt10: .asciiz "Please insert your 10th element: "
unique: .asciiz "Unique values: "           
duplicate:    .asciiz "Duplicated value: "        
repeat: .asciiz ", repeated "              
times:  .asciiz " times"     
comma: .asciiz ", "
period: .asciiz "."
semicolon: .asciiz "; "
unique_values: .space 40
duplicated_values: .space 40

# Request integers from the user and store them into the array
.text
main:
	li $t0, 0 	# i = 0
	li $t1, 10 	# n = 10
	la $t2, arr 	# load t2 =array address
	
	li $v0, 4			# print string mode
	la $a0, prompt1 		# load prompt 1
	syscall

inputloop:
	bge $t0, $t1, check_unique	#if i = n, j sort_array

	li $v0, 5 			# get integer mode
	syscall
	sw $v0, 0($t2) 			# store integer into array
	
	addi $t0, $t0, 1 		# i++ 
	addi $t2, $t2, 4 		# add = add + 4
	
printP:
	beq $t0, 1, printP2
	beq $t0, 2, printP3
	beq $t0, 3, printP4
	beq $t0, 4, printP5
	beq $t0, 5, printP6
	beq $t0, 6, printP7
	beq $t0, 7, printP8
	beq $t0, 8, printP9
	beq $t0, 9, printP10
	la $t0, arr
    	la $t2, unique_values
    	la $t3, duplicated_values

check_unique:
    	lw $t4, 0($t0)
    	li $t5, 0
    	la $t6, arr

check_duplicated:
    	lw $t7, 0($t6)
    	beq $t0, $t6, skip_compare
    	beq $t4, $t7, found_duplicate
    	addi $t5, $t5, 1

skip_compare:
    	addi $t6, $t6, 4
    	bnez $t6, check_duplicated

    # Print unique or duplicated values
    	bnez $t5, print_unique
    	sw $t4, 0($t2)
    	addi $t2, $t2, 4
    	j next_element

found_duplicate:
    	sw $t4, 0($t3)
    	addi $t3, $t3, 4

next_element:
    	addi $t0, $t0, 4
    	bnez $t0, check_unique

    # Print results
    li $v0, 4
    la $a0, unique
    syscall
    la $t2, unique_values
    j print_values

print_unique:
    li $v0, 4
    la $a0, duplicate
    syscall
    la $t2, duplicated_values

print_values:
    lw $t4, 0($t2)
    beqz $t4, exit
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, comma
    syscall
    addi $t2, $t2, 4
    j print_values

exit:
    li $v0, 10
    syscall

printPeriod:
	li $v0, 4 		# print string
	la $a0, period 		# load "."	
	syscall
	j exit
printP2:
	li $v0, 4		# print string
	la $a0, prompt2		# load prompt2
	syscall
	j inputloop
printP3:
	li $v0, 4		# print string
	la $a0, prompt3		# load prompt3
	syscall
	j inputloop
printP4:
	li $v0, 4		# print string
	la $a0, prompt4		# load prompt4
	syscall
	j inputloop
printP5:
	li $v0, 4		# print string
	la $a0, prompt5		# load prompt5
	syscall
	j inputloop
printP6:
	li $v0, 4		# print string
	la $a0, prompt6		# load prompt6
	syscall
	j inputloop
printP7:
	li $v0, 4		# print string
	la $a0, prompt7		# load  prompt7
	syscall
	j inputloop
printP8:
	li $v0, 4		# print string
	la $a0, prompt8		# load prompt 8
	syscall
	j inputloop
printP9:
	li $v0, 4		# print string
	la $a0, prompt9		# load prompt 9
	syscall
	j inputloop
printP10:
	li $v0, 4		# print string
	la $a0, prompt10		# load prompt 10
	syscall
	j inputloop
