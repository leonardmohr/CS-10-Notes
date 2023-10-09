main:
  addi    $a0, $zero, 3   # arg n = 3
  jal     fact
  add     $a0, $v0, $zero
  addi    $v0, $zero, 1   # print int syscall
  syscall
  addi    $v0, $zero, 10  # exit syscall
  
  syscall
  

fact:
  addi    $sp, $sp, -8    # make space for two items on stack
  sw      $ra, 4($sp)     # save return address
  sw      $a0, 0($sp)     # save arg n
  slti    $t0, $a0, 1     # test if n < 1
  beq     $t0, $zero, L1  # if n >= 1, goto L1
  lw      $ra, 4($sp)     # restore $ra
  lw      $a0, 0($sp)     # restore arg n
  addi    $v0, $zero, 1   # return 1
  addi    $sp, $sp, 8     # pop two items from stack
  jr      $ra             # return to caller

L1:
  addi    $a0, $a0, -1    # n += -1
  jal     fact            # calls fact and $ra <-- PC+4
  lw      $a0, 0($sp)     # restore arg n
  lw      $ra, 4($sp)     # restore $ra
  addi    $sp, $sp, 8     # Pops two items from stack
  mul     $v0, $a0, $v0   # return n*fact(n-1)
  jr      $ra             # return to caller