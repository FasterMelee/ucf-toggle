#########################################################
# UCF Toggle v2
# Author: Ptomerty
# Contributors: tauKhan, UnclePunch, Cilan
#
# Insertion address: 0x80263250
# Clobbers r22, r0.
# Flags are located at 0x804D1FB0, stored 1 byte apart.
# Controllers are stored 2 bytes apart.
# Example: [DB][SD][DB][SD]
#          [  P1  ][  P2  ]
#########################################################

# ---- entry point ----
main:
  li r22, 0x4
  mtctr r22 # set count register to 4
  b _checkLoop # begin toggle loop

# ---- stored constants ----
constants:
  blrl # blrl trick courtesy of achilles / unclepunch
  # stores pointer to array below in link register
  .long 0x0148013D # denied ohhh, gasp sounds
  .long 0x00AA00DF # success trophy, bat

# ---- main loop ----
_checkLoop:
  mfctr r22 # get loop counter for controller offset
  subfic r22, r22, 0x4 # calculate (4 - loop) for current player (0 1 2 3)
  mulli r22, r22, 0x44 # calculate offset of controller data

  addis r22, r22, 0x804C # can't use lis because it'd clear r22, whoops
  addi r22, r22, 0x1FB4 # load one-frame input controller data address
  lwz r22, 0(r22) # load controller data from pointer

  cmpwi r22, 0x1 # was L pressed?
  beql- _handle # if yes, handle
  cmpwi r22, 0x2 # was R pressed?
  beql- _handle # if yes, handle

  bdz- _randstage1 # decrement count register,end loop if all players checked
  b _checkLoop # else check next player

# ---- toggle stored data ----
_handle:
  mflr r0 # save return address of checkLoop to r0
  stwu r0, -4(r1) # push onto stack (+ shift base)

  #r22 either contains 0x1 (L pressed) or 0x2 (R pressed)
  subi r22, r22, 0x1 # subtract 0x1 for L/R offset
  stwu r22, -4(r1) # store L/R press onto stack

  mfctr r0 # get current loop counter
  subfic r0, r0, 0x4 # loop counts downwards, reverse this
  mulli r0, r0, 2 # calculate offset for controller flag data
  
  # r22 still contains L/R press, which is EQUIVALENT to DB/SD offset 
  add r22, r0, r22 # add offset to controller offset 

  lis r0, 0x804D # load top half of flag address
  ori r0, r0, 0x1fb0
  or r22, r0, r22 # ORing with any value <15 is fine.

  lbz r0, 0(r22) # load current db data into r22, clobber L/R press
  xori r0, r0, 0x1 # flip last bit
  rlwinm. r0, r0, 0, 31, 31 # bitmask to last bit
  stb r0, 0(r22) # store new data back into saved address

  # r22 contains flag address
  # r0 contains new flag data
  # stack contains bottom -> (link register of checkLoop) -> (L/R press) -> top
  # if r22 contains 1, play enable sound (was disabled)
  # if r22 contains 0, play disable sound (was enabled)

  lwz r22, 0(r1) # pop L/R press off of stack, clobber flag address
  addi r1, r1, 0x4 # and shift stack back

  # r0 contains 0x0 or 0x1. (top half of constants / disabled or bottom half / enabled)
  # r22 now contains either 0x0 or 0x1 (left or right sound in constants table)

  mulli r0, r0, 0x4 # move to correct position in table: first enabled sound is 0x4 after the disabled ones
  mulli r22, r22, 0x2 # offset for table is 0x2, but offset for db/sd is 0x1
  add r22, r0, r22 # add L/R offset for table if needed

  bl constants # blrl trick jump
  mflr r0 # get start of constants table
  add r22, r0, r22 # shift pointer in table by offset in r22!!!!

# ---- PLAY SOUND ----
  lhz r3, 0(r22) # load correct lower value of sound into r3 from constant table
  li r4, 0xFF
  li r5, 0x80
  li r6, 0xFF
  li r7, 0x07
  lis r21, 0x8038
  ori r21, r21, 0xCFF4
  mtlr r21
  blrl 

# ---- PLAY SOUND END ----
  # clean up

  lwz r0, 0(r1) # pop link register of checkLoop off of stack
  addi r1, r1, 0x4 # shift stack
  mtlr r0
  blr # return to loop


# ---- random stage code ----
_randstage1:
  lis r14, 0x8045
  ori r14, r14, 0xBF17
  cmpwi r7, 0x4
  bne- _randstage2
  li r15, 0x1
  stb r15, 0(r14)
  lis r14, 0x8026
  ori r14, r14, 0x3264
  mtctr r14
  bctr 

_randstage2:
  rlwinm. r16, r7, 0, 19, 19
  beq- _randstage3
  li r15, 0x0
  stb r15, 0(r14)
  b _endwithstart

_randstage3:
  rlwinm. r0, r7, 0, 19, 19
  b _endwithstart

_endwithstart:
  lbz r0, -0x49AE(r13)