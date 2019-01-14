.cpu cortex-m0
.thumb
.syntax unified
.fpu softvfp

.equ RCC, 0x40021000
.equ AHBENR, 0x14

.equ GPIOA, 0x48000000
.equ GPIOB, 0x48000400
.equ GPIOC, 0x48000800

.equ IOPAEN, 0x20000
.equ IOPBEN, 0x40000
.equ IOPCEN, 0x80000

.equ MODER, 0x00
.equ PUPDR, 0x0c
.equ IDR, 0x10
.equ ODR, 0x14

.equ PULLUPSETVAL, 0x01555555
.equ PULLDOWNSETVAL, 0x02AAAAAA


//===========================================================
// Enable Ports A and C in the RCC AHBENR
// No parameters.
// No expected return value.
.global enable_ports
enable_ports:
	//mov pc,lr	// Replace with proper push/pop if needed.
	push {lr}
	//enables port c
	ldr r0, =RCC
	ldr r1, [r0, #AHBENR]
	ldr r2, =IOPCEN
	orrs r1, r2
	str r1, [r0, #AHBENR]

	//enable for a
	ldr r1, [r0, #AHBENR]
	ldr r2, =IOPAEN
	orrs r1,r2
	str r1, [r0, #AHBENR]
	pop {pc}

//===========================================================
// Set bits 0-12 of Port C to be outputs.
// No parameters.
// No expected return value.
.global portc_output
portc_output:
	//mov pc,lr	// Replace with proper push/pop if needed.
	push {lr}
	ldr r0, =GPIOC
	ldr r1, [r0, #MODER]
	ldr r2, =0x01555555 //enables port c bits 0 - 12
	orrs r1, r2
	str r1, [r0, #MODER];
	pop {pc}

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
// Set the state of a single output pin to be high.
// Do not affect the other bits of the port.
// Parameter 1 is the GPIOx base address.
// Parameter 2 is the bit number of the pin.
// No expected return value.
.global setpin
setpin:
	//mov pc,lr	// Replace with proper push/pop if needed.
	push {lr}
	ldr r2, [r0, #ODR]
	movs r3, #1
	lsls r3, r3, r1
	orrs r2, r3
	str r3, [r0, #ODR]
	pop {pc}
//===========================================================
// Set the state of a single output pin to be low.
// Do not affect the other bits of the port.
// Parameter 1 is the GPIOx base address.
// Parameter 2 is the bit number of the pin.
// No expected return value.
.global clrpin
clrpin:
	push {lr}
	movs r2, #1
	lsls r2, r2, r1
	mvns r2,r2
	ldr r3, [r0,#ODR]
	ands r3,r2
	str r3, [r0, #ODR]
	pop {pc}
	//mov pc,lr	// Replace with proper push/pop if needed.

//===========================================================
// Get the state of the input data register of
// the specified GPIO.
// Parameter 1 is GPIOx base address.
// Parameter 2 is the bit number of the pin.
// The subroutine should return 0x1 if the pin is high
// or 0x0 if the pin is low.
.global getpin
getpin:
	//mov pc,lr	// Replace with proper push/pop if needed.
	push {lr}
	ldr r2, [r0, #IDR]
	asrs r2, r2, r1
	movs r3, #1
	ANDS r2, r3
	movs r0,r2
	pop {pc}

//===========================================================
// Set Port A to pull all of its inputs high if unconnected.
// There are no parameters.
// No expected return value.
.global porta_pullup
porta_pullup:
	//mov pc,lr	// Replace with proper push/pop if needed.
	push {lr}
	ldr r0, =GPIOA
	ldr r1, =PULLUPSETVAL
	str r1, [r0, #PUPDR]
	pop {pc}
	//ldr r1, [r0,#PUPDR]



//===========================================================
// Set Port A to pull all of its inputs low if unconnected.
// There are no parameters.
// No expected return value.
.global porta_pulldown
porta_pulldown:
	//mov pc,lr	// Replace with proper push/pop if needed.
	push {lr}
	ldr r0, =GPIOA
	ldr r1, =PULLDOWNSETVAL
	str r1, [r0, #PUPDR]
	pop {pc}
