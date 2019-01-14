.cpu cortex-m0
.thumb
.syntax unified
.fpu softvfp

// External interrupt for pins 0 and 1 is IRQ 5.
.equ EXTI0_1_IRQn,5

// SYSCFG constrol registers
.equ SYSCFG, 0x40010000
.equ EXTICR1, 0x8
.equ EXTICR2, 0xc
.equ EXTICR3, 0x10
.equ EXTICR4, 0x14

// External interrupt control registers
.equ EXTI, 0x40010400
.equ IMR, 0
.equ EMR, 0x4
.equ RTSR, 0x8
.equ FTSR, 0xc
.equ SWIER, 0x10
.equ PR, 0x14

// Variables to register things for pin 0
.equ EXTI_RTSR_TR0, 1
.equ EXTI_IMR_MR0, 1
.equ EXTI_PR_PR0, 1

// NVIC control registers...
.equ NVIC, 0xe000e000
.equ ISER, 0x100
.equ ICER, 0x180
.equ ISPR, 0x200
.equ ICPR, 0x280

// SysTick counter variables...
.equ SYST, 0xe000e000
.equ CSR, 0x10
.equ RVR, 0x14
.equ CVR, 0x18

//lab3
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

.equ MICROLABEL, 0x3E8


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
	push {lr}
	nop
	nop
	nop
	nop
	subs r0, #1
	bne micro_wait
	//mov pc, lr
	pop {pc}

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

//=======================================================
// Your translation of
// unsigned int fibonacci(unsigned int n) {
//   if (n < 2)
//      return n;
//   return fibonacci(n-1) + fibonacci(n-2);
// }
//
.global fibonacci
fibonacci:
/*
	push {lr}
	movs r2, #0
	if1:
		movs r1, #2
		cmp r1, r0
		bge recur
	then1:
		pop {pc}
	recur:
		subs r0, #1
		bl fibonacci
		str r0, [r2]
		subs r0, #1
		bl fibonacci
		adds r0, r2
		pop {pc}
*/

	push {r4,r5,lr}
	//movs r5, #0
	if1:
		cmp r0, #2
		bge recur
	then1:
		pop {r4,r5, pc}

	recur:
		movs r4, r0
		subs r0, #1
		bl fibonacci
		movs r5, r0
		movs r0, r4
		subs r0, #2
		bl fibonacci
		adds r0, r0, r5
		pop {r4,r5,pc}

//=======================================================
// do_count: Count up from 0x0 to 0xF twice.
// Call display_digit(x) for each value then micro_wait(500000)
// Takes no parameters
// Returns no value.
//
.global do_count
do_count:
	push {lr}

	for1:
		movs r1, #0 //x
		b check1
	body1:
		adds r1, #1
		b for2
	check1:
		cmp r1, #2
		bge endfor1
		b body1

	endfor1:
		pop {pc}

	for2:
		movs r6, #0 //y
		b check2
	body2:
		adds r6, #0
		bl display_digit
		ldr r3, =MICROLABEL
		movs r0, 10
		bl micro_wait
		adds r6, #1

	check2:
		cmp r6, #16
		bge endfor2
		b body2

	endfor2:
		b check1


//=======================================================
// Your implementation of a SysTick interrupt handler.
// This is an interrupt service routine.
// Increment the value of the global variable tick_counter
// Display that value with a call to display_digit().
//
.type SysTick_Handler, %function
.global SysTick_Handler
SysTick_Handler:
	push {lr}
	// Student code goes here.
    pop {pc}

//=======================================================
// Initialize the SysTick counter.
// You should set the SYST_RVR (reset value register)
// so an exception occurs once per second.
//
// Then set the SYST_CSR (control status register) so
// that it uses the CPU clock as the clock source, enable
// the SysTick exception request, and enable the counter.
//
.global init_systick
init_systick:
    mov pc,lr // Student should remove this.

//=======================================================
// OR the value EXTI_RTSR_TR0 into the EXTI_RTSR
// (rising trigger selection register).
// This will tell the EXTI system to flag an interrupt
// on the rising edge of Pin 0.
//
.global init_rtsr
init_rtsr:
	mov pc,lr	// Student should remove this.

//=======================================================
// OR the value EXTI_IMR_MR0 into EXTI_IMR
// (Interrupt mask register).
// This will unmask the external interrupt for Pin 0.
//
.global init_imr
init_imr:
	mov pc,lr	// Student should remove this.

//=======================================================
// Write (1 << EXTI0_1_IRQn) into the NVIC_ISER
// (Interrupt set enable register).
// (This value is '1' shifted left by EXTI0_1_IRQn bits.)
// This action will enable the external interrupt for pins 0 and 1.
//
.global init_iser
init_iser:
	mov pc, lr	// Student should remove this.

//=======================================================
// The interrupt handler for Pins 0 and 1.
// The handler should increment the global variable named
// 'button_presses' and call display_digit with that value.
// Then it should write EXTI_PR_PR0 to the EXTI_PR register to
// clear the interrupt.
//
// Optionally, you may also call micro_wait() for a
// while to debounce the button press.
//
.type EXTI0_1_IRQHandler, %function
.global EXTI0_1_IRQHandler
EXTI0_1_IRQHandler:
	push {lr}
	// Student code goes here.
	pop {pc}
