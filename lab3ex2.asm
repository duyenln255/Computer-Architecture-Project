#Write a MIPS program to calculate the following integral:
# integral from u to v of (ax^5 + bx^3 + cx)/(d^2 + e^4)
#where u, v, a, b, c, d, and e are floating-point numbers chosen by the user.
#The user will input the floating-point numbers after the prompts: ”Please
#insert a: ”, ”Please insert b: ”, etc. For example, user inserted u=1, v=2,
#a=3, b=4, c=5, d=6, e=7 then the result should be: -0.0222
#

.data
a: .asciiz "Please insert a: "
b: .asciiz "Please insert b: "
c: .asciiz "Please insert c: "
d: .asciiz "Please insert d: "
e: .asciiz "Please insert e: "
u: .asciiz "Please insert u: "
v: .asciiz "Please insert v: "
result: .asciiz "The result is "
one: .float 1
six: .float 6
four: .float 4
two: .float 2

	fp4: .float 10000.0
	fp5: .float 100000.0
.text	
	li $v0,4		
	la $a0,u
	syscall
	#input u
	li $v0, 6
	syscall
	mov.s $f6,$f0 #u = f6
	
	li $v0,4		
	la $a0,v
	syscall
	#input v
	li $v0, 6
	syscall
	mov.s $f7,$f0 #v=f7
	
	li $v0,4		
	la $a0,a
	syscall
	#input a
	li $v0, 6
	syscall
	mov.s $f1,$f0 #a= f1
	
	li $v0,4		
	la $a0,b
	syscall
	#input b
	li $v0, 6
	syscall
	mov.s $f2,$f0 #b = f2
	
	li $v0,4		
	la $a0,c
	syscall
	#input c
	li $v0, 6
	syscall
	mov.s $f3,$f0 #c = f3
	
	li $v0,4		
	la $a0,d
	syscall
	#input d
	li $v0, 6
	syscall
	mov.s $f4,$f0 #d = f4
	
	li $v0,4		
	la $a0,e
	syscall
	#input e
	li $v0, 6
	syscall
	mov.s $f5,$f0 #e=f5
	
	li $v0,4
	la $a0,result
	syscall

##cal 1/(d^2+e^4) * [a/6 *(u^6 - v^6) + b/4(u^4 - v^4) + c/2*(u^2-v^2)]
#cal d^2
mul.s $f4, $f4, $f4	# f4 = d^2
#cal e^4
mul.s $f5, $f5, $f5	# f5 = e^2
mul.s $f5, $f5, $f5	# f5 = e^4

add.s  $f4, $f4, $f5	# f4 = d^2 +  e^4
l.s $f10, one
div.s $f4, $f10, $f4 	# f4 = 1/(d^2+e^4) 

l.s $f10, two
div.s $f3, $f3, $f10	#c/2
mul.s $f6,$f6,$f6	#f6 = u^2
mul.s $f7,$f7,$f7	#f7 = v^2

sub.s $f8, $f6, $f7	#(u^2-v^2)
mul.s  $f3, $f8, $f3	#c/2*(u^2-v^2)

mul.s $f3, $f4, $f3	#f3 = 1/(d^2+e^4)*[c/2*(u^2-v^2)]
# cal  b/4(u^4 - v^4)
l.s $f10, four
div.s $f9, $f2, $f10	#b/4
mul.s $f5,$f6,$f6	#f5 = u^4
mul.s $f8,$f7,$f7	#f8 = v^4

sub.s $f11, $f5, $f8	#(u^4-v^4)
mul.s  $f11, $f11, $f9	#b/4(u^4 - v^4)

mul.s $f11, $f4, $f11	#f11 = 1/(d^2+e^4)*[b/4(u^4 - v^4)]


#cal 1/(d^2+e^4) * [a/6 *(u^6 - v^6)]

l.s $f10, six
div.s $f9, $f1, $f10	#a/6
mul.s $f5,$f5,$f6	# f5 = u^4 * u^2
mul.s $f8,$f8,$f7	#  f8 = v^4 * v^2
sub.s $f5, $f5, $f8	# f5 =(u^6 - v^6)
mul.s $f5, $f5, $f9 	# f5 = [a/6 *(u^6 - v^6)]
mul.s $f5, $f5, $f4 	# f5 = 1/(d^2+e^4) * [a/6 *(u^6 - v^6)]

add.s $f8, $f5, $f11
add.s $f8, $f8, $f3


l.s $f9, fp5   # Load scaleFactor100k vào $f9
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
no_round:
mtc1 $t0, $f8              # Chuyển giá trị đã làm tròn trở lại FPU
cvt.s.w $f8, $f8           # Chuyển về số dấu phẩy động
l.s $f9, fp4    # Load scaleFactor10k
div.s $f8, $f8, $f9        # Chia cho 10000 để thu nhỏ giá trị

# In giá trị được làm tròn
li $v0, 2                  # Mã syscall cho in số dấu phẩy động
mov.s $f12, $f8            # Chuyển giá trị vào $f12
syscall                    # Gọi syscall

li $v0, 10                 # Kết thúc chương trình
syscall
roundNev:
sub $t0, $t0, 1
j no_round

roundPos:
add $t0, $t0, 1
j no_round





