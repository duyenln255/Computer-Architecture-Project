.data
arr: .space 60           # 15 elements * 4 bytes each
#prompt: .asciiz "Please insert your element number: "
output: .asciiz "The second smallest value is "
indexMsg: .asciiz ", found in index "
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
prompt11: .asciiz "Please insert your 11th element: "
prompt12: .asciiz "Please insert your 12th element: "
prompt13: .asciiz "Please insert your 13th element: "
prompt14: .asciiz "Please insert your 14th element: "
prompt15: .asciiz "Please insert your 15th element: "
comma: .asciiz ", "
period: .asciiz "."
.text
.globl main

main:
    li $s0, 15          # Total elements count
    li $s1, 0           # Index for elements input
    li $s2, 0x7FFFFFFF  # Min value initialization
    li $s3, 0x7FFFFFFF  # Second min value initialization
    la $s4, arr         # Base address of the array
    # Print prompt
    li $v0, 4
    la $a0, prompt1
    syscall

# Input loop
inputloop:
	bge  $s1, $s0, reset
    	# Read integer
    	li $v0, 5
    	syscall
    
    	# Store the read integer into array
    	sw $v0, 0($s4)
    
   	 # Prepare for next iteration
    	addi $s4, $s4, 4
    	addi $s1, $s1, 1
printP:
	beq $s1, 1, printP2
	beq $s1, 2, printP3
	beq $s1, 3, printP4
	beq $s1, 4, printP5
	beq $s1, 5, printP6
	beq $s1, 6, printP7
	beq $s1, 7, printP8
	beq $s1, 8, printP9
	beq $s1, 9, printP10
	beq $s1, 10, printP11
	beq $s1, 11, printP12
	beq $s1, 12, printP13
	beq $s1, 13, printP14
	beq $s1, 14, printP15
reset:
# Reset index and address for finding second smallest
    li $s1, 0
    la $s4, arr

# Finding the second smallest value
find_second_smallest:
    lw $t0, 0($s4)      # Load current element
    blt $t0, $s2, update_min_and_second # If current < min, update both
    blt $t0, $s3, update_second_min     # If current < second_min and not < min, update second_min
    blt $s1, $s0, next_element          # Loop until end of array

update_min_and_second:
    move $s3, $s2      # Update second_min with old min value
    move $s2, $t0      # Update min with current value
    j next_element

update_second_min:
    move $s3, $t0      # Update second_min with current value

next_element:
    addi $s1, $s1, 1   # Increment index
    addi $s4, $s4, 4   # Move to next element in array
    blt $s1, $s0, find_second_smallest  # Continue loop if not at end

# Print the second smallest value
    li $v0, 4
    la $a0, output
    syscall
    
    li $v0, 1
    move $a0, $s3
    syscall

# Reset for printing indexes
    li $s1, 0
    la $s4, arr

print_indexes:
    lw $t0, 0($s4)
    beq $t0, $s3, print_index
    skip_index:
        addi $s1, $s1, 1
        addi $s4, $s4, 4
        blt $s1, $s0, print_indexes
    j end_program

print_index:
    li $v0, 4
    la $a0, indexMsg
    syscall

    li $v0, 1
    move $a0, $s1
    syscall
    
    j skip_index

end_program:
    	li $v0, 4 		# print string
	la $a0, period 		# load "."	
	syscall
    li $v0, 10
    syscall
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
printP11:
	li $v0, 4		# print string
	la $a0, prompt11		# load prompt 11
	syscall
	j inputloop
printP12:
	li $v0, 4		# print string
	la $a0, prompt12		# load prompt12
	syscall
	j inputloop
printP13:
	li $v0, 4		# print string
	la $a0, prompt13	# load prompt13
	syscall
	j inputloop
printP14:
	li $v0, 4		# print string
	la $a0, prompt14		# load prompt14
	syscall
	j inputloop
printP15:
	li $v0, 4		# print string
	la $a0, prompt15		# load prompt 15
	syscall
	j inputloop