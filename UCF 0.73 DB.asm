loc_0x0:
   lis r5, 0x804D
   addi r5, r5, 0x1FB0
   lbz r4, 0xC(r31)
   mulli r4, r4, 2
   lwzx r4, r5, r4
   cmpwi r4, 0x1
   beq- .db1
   b .db7

.db1:
  lhz r4, 1000(r31)
  cmpwi r4, 0x4000
  bne- .db7
  lwz r4, -20812(r13)
  lfs f1, 1568(r31)
  lfs f2, 9028(r31)
  fmuls f1, f1, f2
  lfs f2, 60(r4)
  fcmpo cr0, f1, f2
  cror 2, 1, 2
  bne- .db7
  lbz r5, 1648(r31)
  cmpwi r5, 0x2
  bge- .db7
  lbz r4, 8735(r31)
  rlwinm. r4, r4, 0, 28, 28
  beq+ .db2
  b .db7

.db2:
  lis r4, 0x804C
  ori r4, r4, 0x1F78
  lbz r5, 1(r4)
  stb r5, -8(r1)
  b .db5

.db3:
  subi r5, r5, 0x1
  cmpwi r5, 0x0
  bge- .db4
  addi r5, r5, 0x5

.db4:
  lis r4, 0x8046
  ori r4, r4, 0xB108
  mulli r5, r5, 0x30
  add r4, r4, r5
  lbz r5, 12(r31)
  mulli r5, r5, 0xC
  add r4, r4, r5
  lbz r5, 2(r4)
  extsb r5, r5
  blr 

.db5:
  subi r5, r5, 0x2
  bl .db3
  stw r5, -12(r1)
  lbz r5, -8(r1)
  bl .db3
  lwz r4, -12(r1)
  sub r5, r5, r4
  mullw r5, r5, r5
  cmpwi r5, 0x15F9
  ble- .db7
  li r0, 0x1
  stw r0, 9048(r31)
  stw r0, 9024(r31)
  lbz r4, 7(r31)
  cmpwi r4, 0xA
  bne+ .db7
  lwz r4, 16(r3)
  lwz r4, 44(r4)
  lwz r4, 7884(r4)
  stfs f0, 24(r4)
  lwz r5, 24(r4)
  lis r12, 0x3F80
  cmpw r5, r12
  beq- .db6
  li r5, 0x80
  stb r5, 6(r4)
  b .db7

.db6:
  li r5, 0x7F
  stb r5, 6(r4)

.db7:
  stfs f0, 44(r31)

