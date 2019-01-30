loc_0x0:
  lis r24, 0x804D ; store address of dashback flags here
  addi r24, r24, 0x1FB0 ; same as above
  b .checkp1L

.checkp1L:
  lis r21, 0x804C ; store previous frame controller digital input address in r21
  addi r21, r21, 0x1FB0 ; same as above
  bl .checkdlpressed
  cmpwi r22, 0x1 ; check if dpad left already held down
  bne- .p1pressednowL ; if not, see if pressed this frame
  b .checkp1R

.p1pressednowL:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  bl .checkdlpressed
  cmpwi r22, 0x1
  beq- .handlep1L
  b .checkp1R

.handlep1L:
  lwz r21, 0(r24)
  cmpwi r21, 0x0
  beq- .turnp1onL ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 0(r24)
  bl .playdeniedOhhh
  b .end

.checkp1R:
  lis r21, 0x804C ; store previous frame controller digital input address in r21
  addi r21, r21, 0x1FB0 ; same as above
  bl .checkdrpressed
  cmpwi r22, 0x2 ; check if dpad right already held down
  bne- .p1pressednowR ; if not, see if pressed this frame
  b .checkp2L

.p1pressednowR:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  bl .checkdrpressed
  cmpwi r22, 0x2
  beq- .handlep1R
  b .checkp2L

.handlep1R:
  lwz r21, 16(r24)
  cmpwi r21, 0x0
  beq- .turnp1onR ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 16(r24)
  bl .playdeniedGasp
  b .end

.checkp2L:
  lis r21, 0x804C
  addi r21, r21, 0x1FB0
  addi r21, r21, 0x44 ; increment by 0x44 for next player
  bl .checkdlpressed
  cmpwi r22, 0x1
  bne- .p2pressednowL
  b .checkp2R

.p2pressednowL:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  addi r21, r21, 0x44
  bl .checkdlpressed
  cmpwi r22, 0x1
  beq- .handlep2L
  b .checkp2R

.handlep2L:
  lwz r21, 4(r24)
  cmpwi r21, 0x0
  beq- .turnp2onL ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 4(r24)
  bl .playdeniedOhhh
  b .end

.checkp2R:
  lis r21, 0x804C
  addi r21, r21, 0x1FB0
  addi r21, r21, 0x44
  bl .checkdrpressed
  cmpwi r22, 0x2
  bne- .p2pressednowR
  b .checkp3L

.p2pressednowR:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  addi r21, r21, 0x44
  bl .checkdrpressed
  cmpwi r22, 0x2
  beq- .handlep2R
  b .checkp3L

.handlep2R:
  lwz r21, 20(r24)
  cmpwi r21, 0x0
  beq- .turnp2onR ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 20(r24)
  bl .playdeniedGasp
  b .end

.checkp3L:
  lis r21, 0x804C
  addi r21, r21, 0x1FB0
  addi r21, r21, 0x44 ; increment by 0x44 for next player
  addi r21, r21, 0x44
  bl .checkdlpressed
  cmpwi r22, 0x1
  bne- .p3pressednowL
  b .checkp3R

.p3pressednowL:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdlpressed
  cmpwi r22, 0x1
  beq- .handlep3L
  b .checkp3R

.handlep3L:
  lwz r21, 8(r24)
  cmpwi r21, 0x0
  beq- .turnp3onL ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 8(r24)
  bl .playdeniedOhhh
  b .end

.checkp3R:
  lis r21, 0x804C
  addi r21, r21, 0x1FB0
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdrpressed
  cmpwi r22, 0x2
  bne- .p3pressednowR
  b .checkp4L

.p3pressednowR:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdrpressed
  cmpwi r22, 0x2
  beq- .handlep3R
  b .checkp4L

.handlep3R:
  lwz r21, 24(r24)
  cmpwi r21, 0x0
  beq- .turnp3onR ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 24(r24)
  bl .playdeniedGasp
  b .end

.checkp4L:
  lis r21, 0x804C
  addi r21, r21, 0x1FB0
  addi r21, r21, 0x44 ; increment by 0x44 for next player
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdlpressed
  cmpwi r22, 0x1
  bne- .p4pressednowL
  b .checkp4R

.p4pressednowL:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdlpressed
  cmpwi r22, 0x1
  beq- .handlep4L
  b .checkp4R

.handlep4L:
  lwz r21, 12(r24)
  cmpwi r21, 0x0
  beq- .turnp4onL ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 12(r24)
  bl .playdeniedOhhh
  b .end

.checkp4R:
  lis r21, 0x804C
  addi r21, r21, 0x1FB0
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdrpressed
  cmpwi r22, 0x2
  bne- .p4pressednowR
  b .randstage1

.p4pressednowR:
  lis r21, 0x804C
  addi r21, r21, 0x1FAC ; check current frame if pressed
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  addi r21, r21, 0x44
  bl .checkdrpressed
  cmpwi r22, 0x2
  beq- .handlep4R
  b .randstage1

.handlep4R:
  lwz r21, 28(r24)
  cmpwi r21, 0x0
  beq- .turnp4onR ; turn on if flag is set to 0
  li r21, 0      ; else turn off (0=off)
  stw r21, 28(r24)
  bl .playdeniedGasp
  b .end

.randstage1:
  lis r14, 0x8045
  ori r14, r14, 0xBF17
  cmpwi r7, 0x4
  bne- .randstage2
  li r15, 0x1
  stb r15, 0(r14)
  lis r14, 0x8026
  ori r14, r14, 0x3264
  mtctr r14
  bctr 

.randstage2:
  rlwinm. r16, r7, 0, 19, 19
  beq- .randstage3
  li r15, 0x0
  stb r15, 0(r14)
  b .endwithstart

.randstage3:
  rlwinm. r0, r7, 0, 19, 19
  b .endwithstart

.turnp1onL:
  li r21, 1
  stw r21, 0(r24)
  bl .playsuccessCoin
 
.turnp2onL:
  li r21, 1
  stw r21, 4(r24)
  bl .playsuccessCoin
 
.turnp3onL:
  li r21, 1
  stw r21, 8(r24)
  bl .playsuccessCoin
 
.turnp4onL:
  li r21, 1
  stw r21, 12(r24)
  bl .playsuccessCoin

.turnp1onR:
  li r21, 1
  stw r21, 16(r24)
  bl .playsuccessBat
 
.turnp2onR:
  li r21, 1
  stw r21, 20(r24)
  bl .playsuccessBat
 
.turnp3onR:
  li r21, 1
  stw r21, 24(r24)
  bl .playsuccessBat
 
.turnp4onR:
  li r21, 1
  stw r21, 28(r24)
  bl .playsuccessBat

.checkdlpressed:
  ; r21: the digital data address
  ; stores result in r22
  lwz r22, 0(r21) ; load value into r22
  li r21, 0x00000001
  and r22, r22, r21
  blr

.checkdrpressed:
  ; r21: the digital data address
  ; stores result in r22
  lwz r22, 0(r21) ; load value into r22
  li r21, 0x00000002
  and r22, r22, r21
  blr

.playdeniedOhhh:
  li r3, 0x148
  li r4, 0xFF
  li r5, 0x80
  li r6, 0xFF
  li r7, 0x07
  lis r21, 0x8038
  ori r21, r21, 0xCFF4
  mtlr r21
  blrl
  b .end
 
.playsuccessCoin:
  li r3, 0xAA
  li r4, 0xFF
  li r5, 0x80
  li r6, 0xFF
  li r7, 0x7
  lis r21, 0x8038
  ori r21, r21, 0xCFF4
  mtlr r21
  blrl
  b .end

.playsuccessBat:
  li r3, 0xDF
  li r4, 0xFF
  li r5, 0x80
  li r6, 0xFF
  li r7, 0x07
  lis r21, 0x8038
  ori r21, r21, 0xCFF4
  mtlr r21
  blrl
  b .end
 
.playdeniedGasp:
  li r3, 0x13D
  li r4, 0xFF
  li r5, 0x80
  li r6, 0xFF
  li r7, 0x7
  lis r21, 0x8038
  ori r21, r21, 0xCFF4
  mtlr r21
  blrl
  b .end

.endwithstart:
  lbz r0, -0x49AE(r13)
 
.end:
  nop
