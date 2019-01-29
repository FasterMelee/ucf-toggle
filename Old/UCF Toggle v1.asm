loc_0x0:
  ; dashback flags are stored at 0x804D1FB0
  li r24, 0x4 ; set count register to 4 decrementing
  mtctr r24 ; move to register
  b _checkHeldLoop ; begin loop

_checkHeldLoop:
  mfctr r0 ; get loop counter
  subfic r0, r0, 0x4 ; calculate 4 - loop for current player (0 1 2 3)
  mulli r0, r0, 0x44 ; calculate offset of controller data

  lis r22, 0x804C ; load prev frame controller data
  addi r22, r22, 0x1FB0
  add r22, r0, r22 ; add controller offset
  lwz r22, 0(r22) ; load value from pointer

  lis r24, 0x804C ; load current frame data
  addi r24, r24, 0x1FAC
  add r24, r0, r24 ; add offset
  lwz r24, 0(r24)

  neg r22, r22; negate flips bits + 1
  subi r22, r22, 0x1 ; all bits are now flipped
  rlwinm r22, r22, 0, 30, 31 ; bitmask against 0bXX
  rlwinm r24, r24, 0, 30, 31 
  and r22, r22, r24 ; ~r22 & r24 only trips on (0,1)

  cmpwi r22, 0x1
  beql- _handleL ; must follow with blr
  cmpwi r22, 0x2
  beql- _handleR

  bdz- _randstage1 ; decrement CTR and branch if zero
  b _checkHeldLoop ; loop back

_handleL: 
  mfctr r22 ; get current loop counter
  subfic r22, r22, 0x4 ; loop counts downwards, reverse this
  mulli r22, r22, 8 ; offset

  lis r24, 0x804D ; store address of dashback flags here
  addi r24, r24, 0x1FB0 ; same as above

  add r22, r22, r24 ; set offset address
  lwz r24, 0(r22) ; get data from offset address
  cmpwi r24, 0x0

  mflr r0 ; save link register of loop
  stwu r0, -32(r1) ; push onto stack

  beql- _playsuccessTrophy ; if 0, being enabled
  bnel- _playdeniedOhhh ; else, being disabled

  lwz r0, 0(r1) ; pop (loop) register off stack
  addi r1, r1, 32 ; restore stack
  mtlr r0 ; restore LR

  neg r24, r24 ; negate data
  addi r24, r24, 0x1 ; add 1 to flip last bit
  ; add used instead of subtract to avoid POSSIBLE overflow
  rlwinm r24, r24, 0, 31, 31 ; bitmask to last bit

  stw r24, 0(r22)
  blr

_handleR: 
  mfctr r22 ; get current loop counter
  subfic r22, r22, 0x4 ; loop counts downwards, reverse this
  mulli r22, r22, 8 ; offset
  addi r22, r22, 4 ; offset

  lis r24, 0x804D ; store address of dashback flags here
  addi r24, r24, 0x1FB0 ; same as above

  add r22, r22, r24 ; set offset address
  lwz r24, 0(r22) ; get data from offset address
  cmpwi r24, 0x0

  mflr r0 ; save link register of loop
  stwu r0, -32(r1) ; push onto stack

  beql- _playsuccessBat ; if 0, being enabled
  bnel- _playdeniedGasp ; else, being disabled

  lwz r0, 0(r1) ; pop (loop) register off stack
  addi r1, r1, 32 ; restore stack
  mtlr r0 ; restore LR

  neg r24, r24 ; negate data
  addi r24, r24, 0x1 ; add 1 to flip last bit
  ; add used instead of subtract to avoid POSSIBLE overflow
  rlwinm r24, r24, 0, 31, 31 ; bitmask to last bit

  stw r24, 0(r22)
  blr

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

_playdeniedOhhh:
  li r3, 0x148
  b _playSound
 
_playsuccessTrophy:
  li r3, 0xAA
  b _playSound

_playsuccessBat:
  li r3, 0xDF
  b _playSound
 
_playdeniedGasp:
  li r3, 0x13D
  b _playSound

_playSound:
  mflr r0 ; save link register of handle
  stwu r0, -32(r1) ; push onto stack

  li r4, 0xFF
  li r5, 0x80
  li r6, 0xFF
  li r7, 0x07
  lis r21, 0x8038
  ori r21, r21, 0xCFF4
  mtlr r21
  blrl

  lwz r0, 0(r1) ; pop handle register off stack
  addi r1, r1, 32 ; restore stack
  mtlr r0 ; restore LR
  blr ; return to handler for cleanup

_endwithstart:
  lbz r0, -0x49AE(r13)
