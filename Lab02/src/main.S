        .syntax unified
        .cpu cortex-m0
        .fpu softvfp
        .thumb

.global main

main:
                nop

/******************************************************************************
* Code Segment 1:
*
* Description:
*    Write a program that loads two 32-bit unsigned non-zero numbers from
*    the memory location "ops", divides the first number by the second, then
*    stores the quotient into the memory location "quot", and the remainder
*    in the memory location "remain".  Note that the space for the operands
*    and results has already been allocated for you below.  Each has a label
*    associated with the memory location.  You can use the labels "ops",
*    "quot", and "remain" when writing your code, and the assembler will
*    convert it to the appropriate memory address.
*
* Limitations:
*    None.
*
* Useful Instructions:
*    LDR, MOV, CMP, B, SUB, ADD, STR
*
******************************************************************************/
                .text
codeSegment1:
                /* Student code goes here */

                //b       codeSegment2
                bkpt    /*placeholder for a breakpoint */

		while1:
				ldr r0, =ops
				ldr r1, [r0] //dividend
				ldr r2, [r0, #4] //divisor
				cmp r1, r2
				ble endwhile1 //check whether dividend is <= divisor

		do1:
				ldr r0, =ops
				ldr r1, [r0] //dividend
				ldr r2, [r0, #4] //divisor
				subs r1, r1, r2
				str r1, [r0]
				ldr r3, [r0, #8] //load Quotient
				adds r3, #1 //increment quotient
				str r3, [r0, #8]
				b while1

		endwhile1:
				ldr r0, =ops
				ldr r1, [r0, #12] //remain
				ldr r2, [r0] //divisor
				str r2, [r0, #12] //remain = divisor

                .align 4
ops:            .word 10/* Insert dividend (numerator) value here */
                .word 2/* Insert divisor (denominator) value here */
                .data
quot:           .space 4
remain:         .space 4

/******************************************************************************
* Code Segment 2:
*
* Description:
*    Write a program that tests whether the unsigned value contained in
*    register R0 is higher than the value stored at memory location "tval".
*    If it is, the program sets the variable "higher" to 0xFF, and if not,
*    the program sets the variable "higher" to 0x00.
*
* Limitations:
*    None.
*
* Useful Instructions:
*    MOV, LDR, CMP, B, LDR, STR
*
******************************************************************************/
                .text
codeSegment2:
                /* Student code goes here */

                b       codeSegment3
                bkpt    /*placeholder for a breakpoint */

				movs r0, #4
				ldr r1, =tval
				ldr r2, [r1]
				if1:
					cmp r1, r2
					bhi then1
				then1:

				else1:

				endif1:

                .align 4
tval:           .word 0x01 /* Insert tval variable value here */
                .data
higher:         .space 4

/******************************************************************************
* Code Segment 3:
*
* Description:
*    Write a program that performs the addition of the three 4-byte numbers
*    located at the memory location "adds" and stores the result in the memory
*    location "sum".  NOTE: operands are stored MSB to LSB.
*
* Limitations:
*    None
*
* Useful Instructions:
*    LDR, STR, ADD
*
******************************************************************************/
                .text
codeSegment3:
                /* Student code goes here */

                b   codeSegment4
                bkpt    /*placeholder for a breakpoint */

                ldr r0, =adds
                ldr r1, [r0] // first number
                ldr r2, [r0, #4] //second number
                ldr r3, [r0, #8]
                adds r2, r3 //r2 = r2 + r3
                adds r1, r1, r2 //r1 = r1 + r2

                ldr r4, [r0, #12] //sum (i think this line is unnecessary)
                str r1, [r0, #12] //EASY

                .align 4
adds:           .word 1 /* Insert adds variable value here */
                .word 2 /* Insert adds variable value here */
                .word 3 /* Insert adds variable value here */
                .data
sum:            .space 4

/******************************************************************************
* Code Segment 4:
*
* Description:
*    Write a program that will transfer a specified number of WORDS of
*    data from one memory location (source) to another memory location
*    (destination).  Assume that the source address is contained in the
*    register R2, the destination address is contained in the register R1,
*    and the register R0 contains the number of WORDS of data to be
*    transferred.  (Note: the Cortex-M0 does not allow misaligned memory
*    accesses.  E.g. it cannot do a LDR from an address whose two least
*    significant bits are non-zero.  Same for STR.  Therefore, you might
*    find it easiest to calculate the number of bytes for R0, and copy
*    one byte at a time instead of one word at a time.
*    (Recall there are 4 bytes in each word of data.)
*
*    NOTE: For this program, a FOR loop should be used.  The basic structure
*    of a FOR loop is:
*
*                   initialize variables
*           loop    check counter
*                   branch out of loop if done (here, to label "done")
*                   perform action
*                   branch back to "loop"
*           done
*
* Limitations:
*    None
*
* Useful Instructions:
*    LDR, STR, SUB, CMP, B
*
******************************************************************************/
                .text
codeSegment4:
                /* Student code goes here */

                b   codeSegment5
                bkpt    /*placeholder for a breakpoint */

/******************************************************************************
* Code Segment 5:
*
* Description:
*    Write a program that determines how many bits of the number passed in
*    the register R0 are 1s.  The count should be written to the R1 register.
*
*    NOTE: For this program, you should use a DO loop.  The basic structure
*    of a DO loop is given below:
*
*                   initialize counter
*           loop    perform action
*                   update and check counter
*                   branch back to "loop" if not done
*
* Limitations:
*
* Useful Instructions:
*   MOV, LSL, B, ADD, CMP
*
******************************************************************************/
                .text
codeSegment5:
                /* Student code goes here */

                bkpt    /*placeholder for a breakpoint */

				movs r0, #1 //puts an 8 bit representation of 1
				movs r1, #0

		/*do1:

		while1:

		enddo1:*/

infiniteLoop:
                b   infiniteLoop
