.data 
	promptA: .asciiz "Please insert a: "
	promptB: .asciiz "Please insert b: "
	promptC: .asciiz "Please insert c: "
	outputX1: .asciiz "x1 = "
	outputX2: .asciiz "x2 = "
	onesol: .asciiz "There is one solution, x = "
	noRealSol: .asciiz "There is no real solution"
	four: .float 4.0
	two: .float 2.0
	zero: .float 0.0
	fp4: .float 10000.0
	fp5: .float 100000.0
	and: .asciiz " and "
	formatStr: .asciiz "%.4f\n"
	
.text 
	li $v0, 4 		# print string promptA
	la $a0, promptA 		
	syscall
	
	li $v0, 6 		#$f0 contain float read
	syscall
	mov.s  $f1, $f0  	# Save $f0 value to $f1 #a
	
	li $v0, 4 		# print string promptB
	la $a0, promptB 		
	syscall
	
	
	li $v0, 6 		#$f0 contain float read
	syscall
	mov.s  $f2, $f0  	# Save $f0 value to $f2 #b
	
	
	li $v0, 4 		# print string promptA
	la $a0, promptC 		
	syscall
	
	li $v0, 6 		#$f0 contain float read
	syscall
	mov.s  $f3, $f0   	# Save $f0 value to $f2 #c
checkA:
	l.s $f7, zero
	c.lt.s  $f1, $f7
	bc1t Sol
Sol:
	li $v0, 4 		# print string promptA
	la $a0, onesol 		
	syscall
	
	neg.s $f12, $f3 	#$f12 = -c
	div.s $f12, $f12, $f2
	
	li $v0, 2                  # Mã syscall cho in số dấu phẩy động
	syscall
	j exit
checkDelta:  # b*b - 4ac
	l.s $f6, four
	
	mul.s $f4, $f2, $f2	# b*b
	mul.s $f5, $f1, $f6	# 4a
	mul.s $f5, $f5, $f3	# 4ac
	sub.s $f4, $f4, $f5	# b*b - 4ac
	
	neg.s $f5, $f2 	#$f5 = -b
	#print delta
	#li $v0, 2
	#mov.s $f12, $f4
	#syscall 
	l.s $f7, zero
	c.lt.s  $f4, $f7
	bc1t norealSol
	c.eq.s $f4, $f7
	bc1t oneSol
	
	j twoSol


printx1x2:
	#li $v0, 2	#$f12 = float to print
	
	#syscall 
exit:
	li $v0, 10
	syscall
	
norealSol:
	li $v0, 4 		# print string promptA
	la $a0, noRealSol 		
	syscall

	j exit
	
oneSol:
	li $v0, 4 		# print string promptA
	la $a0, onesol 		
	syscall
	l.s $f6, two
	mul.s $f7, $f1, $f6 	#2a = f7
	
	div.s $f8, $f5, $f7	#f8 = x = -b/2a
	
	jal printRes
	j exit
	
twoSol:
	l.s $f6, two
	mul.s $f7, $f1, $f6 	#2a = f7
	
	sqrt.s $f6, $f4		# sqrt(delta)

	add.s $f8 ,$f5, $f6	#-b+sqrt(delta)
	div.s $f8, $f8, $f7 	#x1 = (-b+sqrt(delta))/2a
	

	#print x1
	li $v0, 4
	la $a0, outputX1		
	syscall 
	 
	jal  printRes
	
	sub.s $f8 ,$f5, $f6	#-b-sqrt(delta)
	div.s $f8, $f8, $f7 	#x1 = (-b-qrt(delta))/2a
	
	li $v0, 4
	la $a0, and		
	syscall 
	
	#print x2
	li $v0, 4
	la $a0, outputX2		
	syscall 
	 
	jal printRes
	j exit
printRes:
	l.s $f9, fp5   # Load fp5
	mul.s $f8, $f8, $f9        # Nhân với 100000
	cvt.w.s $f8, $f8           # Chuyển đổi sang số nguyên

	mfc1 $t0, $f8             # Di chuyển giá trị từ FPU sang thanh ghi CPU

	# Kiểm tra chữ số thứ 5, làm tròn nếu cần
	li $t1, 10
	div $t0, $t1               # Chia cho 10 để xác định chữ số thứ 5
	mfhi $t2                   # $t2 = remainder (chữ số thứ 5)
	abs  $t2, $t2  

	mflo $t0                   # $t0 = phần nguyên sau chia cho 10 (loại bỏ chữ số thứ 5)
	li $t3, 5
	blt $t2, $t3, no_round     # Nếu chữ số thứ 5 < 5, không làm tròn
	bltz  $t0, roundNev
	bgez  $t0, roundPos
roundNev:
	sub $t0, $t0, 1
	j no_round

roundPos:
	add $t0, $t0, 1
	j no_round
no_round:
	mtc1 $t0, $f8              # Chuyển giá trị đã làm tròn trở lại FPU
	cvt.s.w $f8, $f8           # Chuyển về số dấu phẩy động
	l.s $f9, fp4   
	div.s $f8, $f8, $f9        # Chia cho 10000 để thu nhỏ giá trị

	# In giá trị được làm tròn
	li $v0, 2                  # Mã syscall cho in số dấu phẩy động
	mov.s $f12, $f8            # Chuyển giá trị vào $f12
	syscall                    # Gọi syscall
	jr $ra	 # Return to the calling function

	