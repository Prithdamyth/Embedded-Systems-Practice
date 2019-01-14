
#define GPIOA 0x48000000
#define GPIOB 0x48000400
#define GPIOC 0x48000800

// Prototypes for the functions to be implemented
// in assembly language in io.S.
void enable_ports(void);
void portc_output(void);
void micro_wait(int);
int setpin(int port, int bit);
int clrpin(int port, int bit);
int getpin(int port, int bit);
void porta_pulldown(void);
void porta_pullup(void);

//==================================================
// Read PA0.  Output the bit to PC8.  Forever.
void prob1(void) {
    // Rely on student's code to enable the ports.
    enable_ports();
    int *gpioc_moder = (int *)0x48000800;
    *gpioc_moder |= 0x10000;
    int *gpioa_idr = (int *)0x48000010;
    int *gpioc_odr = (int *)0x48000814;
    while(1) {
        *gpioc_odr = (*gpioa_idr & 0x1) << 8;
    }
}

//==================================================
// Toggle PC8 and PC9.
// Wait one second.
// Repeat.
void prob2(void) {
    enable_ports();
    portc_output();
    int *gpioc_odr = (int *)0x48000814;
    *gpioc_odr = 0x300;
    for(;;) {
        micro_wait(1000000);
        *gpioc_odr ^= 0x300;
    }
}

//==================================================
// Set PC8 (blue LED) high and PC9 (green LED) low.
// Wait one second.
// Set PC8 low and PC9 high.
// Wait one second.
// Repeat.
void prob3(void) {
    enable_ports();
    portc_output();
    for(;;) {
        setpin(GPIOC,8);
        clrpin(GPIOC,9);
        micro_wait(1000000);
        setpin(GPIOC,9);
        clrpin(GPIOC,8);
        micro_wait(1000000);
    }
}

//==================================================
// If PA0 (user pushbutton) is high,
// turn on PC8 (blue LED) and PC9 (green LED).
// Otherwise turn of PC8 and PC9.
// Repeat.
void prob4(void) {
    enable_ports();
    portc_output();
    for(;;) {
        if (getpin(GPIOA,0)) {
            setpin(GPIOC,8);
            setpin(GPIOC,9);
        } else {
            clrpin(GPIOC,8);
            clrpin(GPIOC,9);
        }
    }
}

//==================================================
// Test PA1 and PA2.  If both are high,
// set PC10 and PC11 to be high,
// otherwise set PC10 and PC11 to low.
// Repeat.
void prob6(void) {
    enable_ports();
    portc_output();
    // Uncomment one of the two following calls.
    //porta_pullup();
    porta_pulldown();
    for(;;) {
        if (getpin(GPIOA,1) && getpin(GPIOA,2)) {
            setpin(GPIOC, 10);
            setpin(GPIOC, 11);
        } else {
            clrpin(GPIOC, 10);
            clrpin(GPIOC, 11);
        }
    }
}

//==================================================
// Call any of the test functions by
// uncommenting a single one.
int main(void) {
    //prob1();
    //prob2();
    //prob3();
    //prob4();
    prob6();
}
