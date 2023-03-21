.data
msg1:	.asciiz "Enter the number n = "
msg2:	.asciiz " "
msg3:   .asciiz "*"
msg4:	.asciiz "\n"
.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg1		# load address of string into $a0
		syscall                 	# run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
 #$s0 = n;$s1 = temp;
  		move    $s0, $v0      		# store input in $s0 (n)
  		addi	$t0,$s0,1		#$t0 = n+1
  		addi 	$t1,$zero,2		#$t1 = 2
  		div	$t0,$t1			#$t0/$t1
  		mflo	$s1			#temp = (n+1)/2

  		div	$s0,$t1			#n/2
  		mfhi	$t0			# $t0 n%2
 
  		bne	$t0,1,else
 		addi	$s1,$s1,-1		# if $t0 ==1 temp--;
 #	i = $t0, j = $t1		
 else:		move 	$t0,$zero		#$t0 = i = 0 
 outer_1:	slt	$t2,$t0,$s1		#i<temp,t2 = 1
 		beq 	$t2,$zero,outer_2_init	#if i<temp goto for1_init
 inner_for1_init: 	move $t1,$zero		#j = 0	
 inner_for1:	slt  $t2,$t0,$t1	#if i<j set $t2 = 1(j<=1)et $t2 = 0
 		bne	$t2,$zero,inner_for2_init	#if i>j break;
# print msg2 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg2		# load address of string into $a0
		syscall                 	# run the syscall
		addi	$t1,$t1,1		# j+=1
 		j	inner_for1	  		
inner_for2_init:	move $t1,$zero		#j = 0	
inner_for2:		mul $t2,$t0,2			#$t2 = i*i
		sub $t2,$s0,$t2			#$t2 = n-i*i
		slt $t2,$t1,$t2,		#if j< n-i*i: $t2 = 1
		beq $t2,$zero,outer_1_end	#if j>=n-i*i:break;
 # print msg3 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg3		# load address of string into $a0
		syscall                 	# run the syscall
		
 		addi	$t1,$t1,1		#j+=1
 		j	inner_for2		
 		
outer_1_end:
 # print msg4 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg4		# load address of string into $a0
		syscall                 	# run the syscall	
 		addi $t0,$t0,1			#i++;
 		j	outer_1			#next loop
 #$t0 = i $t1 = j
outer_2_init:	
		addi 	$t0,$s0,1		#$t0 = n+1
		srl	$t0,$t0,1		#$t0/=2
		addi 	$t0,$t0,-1		#$t0-=1
outer_2:	slt	$t2,$t0,$zero		#i<0,t2 = 1
 		bne 	$t2,$zero,exit	#if i<temp goto for1_init
 inner_for3_init: 	move $t1,$zero		#j = 0	
 inner_for3:	slt  $t2,$t0,$t1	#if i<j set $t2 = 1(j<=1)et $t2 = 0
 		bne	$t2,$zero,inner_for4_init	#if i>j break;
# print msg2 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg2		# load address of string into $a0
		syscall                 	# run the syscall
		addi	$t1,$t1,1		# j+=1
 		j	inner_for3	  		
inner_for4_init:	move $t1,$zero		#j = 0	
inner_for4:		mul $t2,$t0,2			#$t2 = i*i
		sub $t2,$s0,$t2			#$t2 = n-i*i
		slt $t2,$t1,$t2,		#if j< n-i*i: $t2 = 1
		beq $t2,$zero,outer_2_end	#if j>=n-i*i:break;
 # print msg3 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg3		# load address of string into $a0
		syscall                 	# run the syscall
		
 		addi	$t1,$t1,1		#j+=1
 		j	inner_for4		
 		
outer_2_end:
 # print msg4 on the console interface
		li      $v0, 4			# call system call: print string
		la      $a0, msg4		# load address of string into $a0
		syscall                 	# run the syscall	
 		addi $t0,$t0,-1			#i++;
 		j	outer_2			#next loop
 exit:		li $v0, 10 # v0<- (exit)
     		syscall
