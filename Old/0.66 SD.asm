# SD, injects 800998A4

loc_0x0:
  lis r6, 0x804D
  addi r6, r6, 0x1FB0
  lwz r4, 44(r3) ; don't touch r3!!
  lbz r4, 0xC(r4)
  mulli r4, r4, 8
  addi r4, r4, 4
  lwzx r4, r6, r4
  cmpwi r4, 0x1
  beq- .sd1
  b .sd4

.sd1:
  lwz r3, 44(r3)
  lfs f1, 1596(r3)
  lfs f0, 788(r5)
  fcmpo cr0, f1, f0
  ble- .sd4
  lis r4, 0x42A0
  stw r4, -12(r1)
  lis r4, 0x3727
  stw r4, -8(r1)
  lis r4, 0x4330
  stw r4, -28(r1)
  lfs f0, 1568(r3)
  li r0, 0x0

.sd2:
  fabs f0, f0
  lfs f1, -12(r1)
  fmuls f0, f0, f1
  lfs f1, -8(r1)
  fsubs f0, f0, f1
  fctiwz f0, f0
  stfd f0, -20(r1)
  lwz r4, -16(r1)
  addi r4, r4, 0x2
  xoris r4, r4, 32768
  stw r4, -24(r1)
  lfd f0, -28(r1)
  lfd f1, -29808(r2)
  fsubs f0, f0, f1
  lfs f1, -12(r1)
  fdivs f0, f0, f1
  cmpwi r0, 0x0
  bne- .sd3
  li r0, 0x1
  stfs f0, -32(r1)
  lfs f0, 1572(r3)
  b .sd2

.sd3:
  lfs f1, -32(r1)
  fmuls f1, f1, f1
  fmuls f0, f0, f0
  fadds f0, f0, f1
  lfs f1, -30380(r2)
  fcmpo cr0, f0, f1
  cror 2, 1, 2
  bne- .sd4
  lbz r4, 1648(r3)
  cmpwi r4, 0x3
  ble- .sd4
  lfs f0, 44(r5)
  fneg f0, f0
  lfs f1, 1572(r3)
  fcmpo cr0, f0, f1
  bge- .sd4
  lwz r3, 28(r1)
  addi r3, r3, 0x8
  lwz r31, 20(r1)
  addi r1, r1, 0x18
  mtlr r3
  blr 

.sd4:
  mr r3, r30
  lwz r4, 44(r3)

