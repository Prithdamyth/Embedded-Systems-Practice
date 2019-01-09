	.syntax unified
	.cpu cortex-m0
	.fpu softvfp
	.thumb

.global main

main:

MOVS r0, #0x0
BEQ label

	orrs r0, r0
label: BKPT
