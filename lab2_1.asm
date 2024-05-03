#2.1 Exercise 1
#Write a MIPS program that sorts an array of 10 integers in ascending order. 
#The elements of the array must be inserted by the user after the prompt:
#”Please insert your first element:”, ”Please insert your second element:”,etc.
#The sorted array should be printed after the string: ”The sorted array is:”
#For example, if the input is 2, 5, 1, 2, 3, 6, 8, 13, 0, 3, the terminal
#should output: The sorted array is: 0, 1, 2, 2, 3, 3, 5, 6, 8, 13.
#The program is required to check for wrong inputs such as: the array
#has more or less than 10 integers, the array contains characters that are not integers
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
output: .asciiz "The sorted array is: "
comma: .asciiz ", "
period: .asciiz "."
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
	bge $t0, $t1, sort_array	#if i = n, j sort_array

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
# Bubble sort algorithm
sort_array:
    li $t3, 0	# Index vòng lặp ngoài
sort_outer_loop:
    li $t4, 9	# Số lần lặp cho vòng lặp ngoài
    blt $t3, $t4, sort_inner_loop
    j print_array

sort_inner_loop:
    li $t5, 0	 # Index vòng lặp trong
    li $t6, 9
    sub $t6, $t6, $t3
sort_inner_loop_start:
    blt $t5, $t6, sort_compare
    addi $t3, $t3, 1
    j sort_outer_loop

sort_compare:
    sll $t7, $t5, 2
    la $t8, arr
    add $t8, $t8, $t7
    lw $t0, 0($t8)
    lw $t1, 4($t8)
    ble $t0, $t1, sort_no_swap
    sw $t0, 4($t8)
    sw $t1, 0($t8)

sort_no_swap:
    addi $t5, $t5, 1
    j sort_inner_loop_start

# Print sorted array
print_array:
    li $v0, 4
    la $a0, output
    syscall

    li $t0, 0
print_loop:
    li $t1, 10
    blt $t0, $t1, print_element
    j printPeriod

print_element:
    sll $t2, $t0, 2
    la $t3, arr
    add $t3, $t3, $t2
    lw $a0, 0($t3)
    li $v0, 1
    syscall

    # Print comma between elements
    addi $t0, $t0, 1
    li $t1, 10
    bge $t0, $t1, print_loop
    li $v0, 4
    la $a0, comma
    syscall
    j print_loop
    beq $t0, $t1, printPeriod
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
