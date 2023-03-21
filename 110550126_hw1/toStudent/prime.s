.data
msg1:	.asciiz "Enter the number n = "
nextline: .asciiz "\n"
msg2:	.asciiz " is a prime"
msg3:   .asciiz " is not a prime, the nearest prime is"
msg4:   .asciiz " "
.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a0, $v0      		# store input in $a0 
  		move    $s0, $a0
  		addi $sp, $sp, -4		# adiust stack for 1 items
		sw $v0, 0($sp)			# save the n
# jump to procedure prime
		jal prime			#call prime(n)
		lw $t0, 0($sp)			#get n from stack
		addi $sp, $sp, 4		# pop stack for 1 items
		bne $v0,$zero, isprime		# if return value !=0 goto isprime 		
# print msg3 on the console interface
		li      $v0, 1			# call system call: print integer
		move      $a0, $t0		# load n into $a0
		syscall                 	# run the syscall
		li  	$v0, 4			# call system call:print string
		la      $a0, msg3		# load address of string into $a0
		syscall				# run the syscal
		
		addi $s2, $zero, 1		# i = $s2 = 1

# s0 = n; s1 = flag; s2 = i
main_loop:		
		sub $a0, $s0,$s2		#$a0 = n-i
		jal prime			
		beq $v0, $zero, L1		#if n-i is not prime fo to L1
		move $t0, $a0
# print msg4 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg4			# load address of string into $a0
		syscall                 		# run the syscall
# print the result of procedure factorial on the console interface
		move $a0, $t0			
		li $v0, 1					# call system call: print integer
		syscall 					# run the syscall
		addi $s1,$zero,1		#flag = 1
L1:
		add $a0, $s0,$s2		#$a0 = n+i
		jal prime			
		beq $v0, $zero, L2		#if n-i is not prime fo to L1
		move $t0, $a0
# print msg4 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg4		# load address of string into $a0
		syscall                 	# run the syscall
# print the result of procedure factorial on the console interface
		move $a0, $t0			
		li $v0, 1			# call system call: print integer
		syscall 			# run the syscall
		addi $s1,$zero,1		#flag = 1

L2:
		bne $s1,$zero Exit		#if flag $t2 goto Exit
		addi $s2, $s2, 1		# i+=1	
		j main_loop			#next for loop




isprime:
# print the result of procedure factorial on the console interface
		move $a0, $t0			
		li $v0, 1					# call system call: print integer
		syscall 					# run the syscall
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
Exit:
		li $v0, 10					# call system call: exit
  		syscall						# run the syscall
#
#------------------------- procedure prime -----------------------------
# load argument n in $a0, return value in $v0. -d
.text
prime:	
	addi $t0, $zero,1
	bne $a0, $t0, loop_of_prime_init	#IF $a0 !=1 goto loop
	move $v0, $zero			# $v0 = 0
	jr $ra				#return 0
loop_of_prime_init:
	addi $t0, $zero,2		#init $t0 = 2
looping_of_prime:	
	mul $t1,$t0,$t0			# $t1 = i*i
	slt $t2, $a0,$t1		#if n<i*i
	bne $t2,$zero,End_of_prime	#if n>=i*i goto End_of_prime
	div $a0, $t0			#calculate n/i = c...d and c store in LO , d in HI
	mfhi $t2			# $t2 = d
	bne $t2,$zero, loop_of_prime_next#n%i!=0 goto next loop
	move $v0, $zero			# $v0 = 0
	jr $ra				#return 0
loop_of_prime_next:
	addi $t0,$t0,1
	j looping_of_prime
End_of_prime:
	addi $t0,$zero,1		# $t0 = 1
	move $v0, $t0		# $v0 =$t0= 1
	jr $ra			#return 1
	
	
	