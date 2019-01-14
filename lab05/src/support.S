.cpu cortex-m0
.thumb
.syntax unified
.fpu softvfp

//===========================================================
// Wait n microseconds.
// Parameter 1 is the number of microseconds.
// No expected return value.
.global micro_wait
micro_wait:
	//mov pc,lr	// Replace with proper push/pop if needed.
	//push {lr}
	nop
	nop
	nop
	nop
	subs r0, #1
	bne micro_wait
	mov pc, lr
	//pop {pc}
//===========================================================
