.data
msg1:	.asciiz "Enter first number: "
msg2:	.asciiz "\nEnter second number: "
msg3:   .asciiz "\nThe GCD is: "
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
  		move    $t0, $v0      		# store input in $t0 (temp to store argument to GCD,$a0 will be use
# print msg2 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg2			# load address of string into $a0
		syscall                 	# run the syscall
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		move    $a1, $v0      		# store input in $a1 (set arugument of procedure factorial)
# jump to procedure GCD
		move	$a0, $t0
  		jal GCD
  		move $t0, $v0				# save return value in t0 (because v0 will be used by system call) 
# print msg2 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg3			# load address of string into $a0
		syscall                 	# run the syscall
# print the result of procedure factorial on the console interface
		move $a0, $t0			
		li $v0, 1					# call system call: print integer
		syscall 					# run the syscall
   
		li $v0, 10					# call system call: exit
  		syscall						# run the syscall

#------------------------- procedure GCD -----------------------------
# load argument (a,b) in (a0,a1), return value in v0. 
.text
GCD:		addi $sp, $sp, -4		# adiust stack for 1 item a and b will not be call after bne and jal
		sw $ra, 0($sp)				# save the return addres
		div $a0, $a1			#calculate a/b = c...d and c store in LO , d in HI
		mfhi $t0			# $t0 = d
		bne $t0, $zero, L1			#if a!= b goto L
		addi $sp, $sp, 4			# pop 1 item off stack	
		move $v0, $a1				#return b
		jr $ra				# return to the caller
L1:		move $a0, $a1			# $a0 = b
		move $a1, $t0			# $a1 = a%b
		jal GCD				# call GCD(b,a%b))
		lw $ra,0($sp)			# restore the return address
		addi $sp, $sp, 4		#adjust stack pointer to pop 1 items
		jr $ra				# return to the caller