#as: -EB -mdialect=normal
#objdump: -dr -M dec
#source: jump-relax-jump.s
#name: Relaxation of conditional branch instructions, big-endian

.*: +file format .*bpf.*

Disassembly of section .text:

0+ <.*>:
       0:	1d 12 80 00 00 00 00 00 	jeq %r1,%r2,-32768
       8:	ad 12 7f ff 00 00 00 00 	jlt %r1,%r2,32767
      10:	bd 12 ff fd 00 00 00 00 	jle %r1,%r2,-3
      18:	1d 12 00 01 00 00 00 00 	jeq %r1,%r2,1
      20:	05 00 00 01 00 00 00 00 	ja 1
      28:	06 00 00 00 00 00 80 00 	jal 32768
      30:	2d 12 7f ff 00 00 00 00 	jgt %r1,%r2,32767
	...

0+40030 <tail>:
   40030:	55 10 00 01 00 00 00 00 	jne %r1,0,1
   40038:	05 00 00 01 00 00 00 00 	ja 1
   40040:	06 00 00 00 ff ff 7f f7 	jal -32777
