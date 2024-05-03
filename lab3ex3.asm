# Step 1: Open the file to read the text you inserted
li $v0, 13          # syscall code for open file
la $a0, raw_input.txt   # file name
li $a1, 0           # open for reading
li $a2, 0           # mode is ignored
syscall             # open file (file descriptor returned in $v0)
move $s0, $v0       # save the file descriptor

# Step 2: Read from the file
li $v0, 14          # syscall code for read
move $a0, $s0       # file descriptor
la $a1, buffer_read    # address of buffer to read into
li $a2, 512         # buffer length
syscall             # read file

# Step 3: Allocate memory for the string
li $v0, 9           # syscall code for dynamic memory allocation
li $a0, 512         # size of the string (assuming maximum possible length)
syscall             # allocate memory
move $s1, $v0       # save the pointer to allocated memory

# Step 4: Copy the line from the text file to the string in memory
move $t0, $s1       # pointer to the destination string
move $t1, $zero     # index for buffer_read
copy_loop:
    lb $t2, buffer_read($t1)  # load byte from buffer_read
    beq $t2, $zero, copy_done # if byte is null (end of string), done copying
    sb $t2, 0($t0)     # store byte to allocated memory
    addi $t0, $t0, 1   # move to next byte in allocated memory
    addi $t1, $t1, 1   # move to next byte in buffer_read
    j copy_loop        # repeat loop
copy_done:

# Step 5: Print the string to the terminal
li $v0, 4           # syscall code for print string
la $a0, ($s1)       # address of the string
syscall             # print string

# Step 6: Write the printed result to a file
li $v0, 13          # syscall code for open file
la $a0, formatted_result.txt   # file name
li $a1, 1           # open for writing
li $a2, 0           # mode is ignored
syscall             # open file (file descriptor returned in $v0)
move $s0, $v0       # save the file descriptor

# Write the formatted result to the file
li $v0, 15          # syscall code for write to file
move $a0, $s0       # file descriptor
la $a1, ($s1)       # address of the string
li $a2, 512         # length of the string (assuming maximum possible length)
syscall             # write to file

# Close the file
li $v0, 16          # syscall code for close file
move $a0, $s0       # file descriptor
syscall             # close file

# Exit the program
li $v0, 10          # syscall code for exit
syscall             # exit program

# Data section
.data
buffer_read: .space 512
raw_input.txt: .asciiz "Davy Jones,2251234,168 Ly Thuong Kiet St District 10 Ward 14 HCMC,69,None"
formatted_result.txt: .asciiz "formatted_result.txt"

