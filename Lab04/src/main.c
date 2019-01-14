
#define GPIOA 0x48000000
#define GPIOB 0x48000400
#define GPIOC 0x48000800

// Prototypes for the functions implemented
// in assembly language in io.S from lab 3.
//
void enable_ports(void);
void portc_output(void);
void micro_wait(int);
int setpin(int port, int bit);
int clrpin(int port, int bit);
int getpin(int port, int bit);
void porta_pulldown(void);
void porta_pullup(void);

void init_systick(void);

//==========================================================
// Turn on the 7 segments (plus the decimal point) in sequence.
//
int test7(void) {
    enable_ports();
    portc_output();
    for(;;) {
        int x;
        for(x=0; x<8; x++) {
            setpin(GPIOC, x);
            micro_wait(8000);
        }
        for(x=0; x<8; x++)
            clrpin(GPIOC, x);
        micro_wait(500000);
    }
}

//==========================================================
// An array whose index maps to the LED segments to turn on
// to represent the number on the display.
//
static const char led_map[] = {
    // segments:  GFE DCBA
    0x3f,   // 0: 011 1111
    0x06,   // 1: 000 0110
    0x5b,   // 2: 101 1011
    0x4f,   // 3: 100 1111
    0x66,   // 4: 110 0110
    0x6d,   // 5: 110 1101
    0x7d,   // 6: 111 1101
    0x07,   // 7: 000 0111
    0x7f,   // 8: 111 1111
    0x6f,   // 9: 110 1111
    0x77,   // A: 111 0111
    0x7c,   // b: 111 1100
    0x39,   // c: 011 1001
    0x5e,   // d: 101 1110
    0x79,   // E: 111 1001
    0x71,   // F: 111 0001
};

//==========================================================
// Display a 4-bit hexadecimal digit.
//
void display_digit(int x) {
    x &= 0x0f; // Make sure value is < 16
    int *gpioc_bsrr = (int *)(0x48000800 + 0x18);
    *gpioc_bsrr = 0x007f0000 + led_map[x];
}

//==========================================================
// Turn the dot on or off depending on whether x is odd or even.
//
void display_dot(int x) {
    x &= 1; // Make sure value is 0 or 1.
    int *gpioc_bsrr = (int *)(0x48000800 + 0x18);
    *gpioc_bsrr = 0x00800000 + (x << 7);
}

// prototypes for student-written subroutines.
void do_count(void);
unsigned int fibonacci(unsigned int);
void init_exticr(void);
void init_rtsr(void);
void init_imr(void);
void init_iser(void);


//==========================================================
// Check the student's do_count subroutine implementation.
//
void try_countup(void) {
    enable_ports();
    portc_output();
    do_count();
    // Blink the dot forever.
    int x;
    for(x=1; ; x += 1) {
        display_dot(x);
        micro_wait(100000);
    }
}

//==========================================================
// Try the student's fibonacci() function.
//
void try_fibonacci(void) {
    // If student was unable to write fibonacci, replace the
    // line below with:
    //   micro_wait(2500000);
    //   return;
    unsigned int x = fibonacci(27);
}

//==========================================================
// Run try_fibonacci() and blink the decimal point
// after each call.
//
void forever_fibonacci(void) {
    for(;;) {
        display_dot(0);
        try_fibonacci();
        display_dot(1);
        try_fibonacci();
    }
}

// A count of the SysTick events.
volatile int tick_counter = 0;

// A count of the presses of the user pushbutton.
volatile int button_presses = 0;

// A function to
void show_ticks(void) {
    enable_ports();
    portc_output();
    display_digit(0);
    init_systick();
    forever_fibonacci();
}

//==========================================================
// Test that forever_fibonacci works with student fibonacci.
//
void count_button1(void) {
    enable_ports();
    portc_output();
    display_digit(0);
    *((int *)0x40010408) = 1;
    *((int *)0x40010400) = 1;
    *((int *)0xe000e100) = 32;
    forever_fibonacci();
}

//==========================================================
// Test init_rtsr()
//
void count_button2(void) {
    enable_ports();
    portc_output();
    display_digit(0);
    init_rtsr();
    *((int *)0x40010400) = 1;
    *((int *)0xe000e100) = 32;
    forever_fibonacci();
}

//==========================================================
// Test init_imr()
//
void count_button3(void) {
    enable_ports();
    portc_output();
    display_digit(0);
    init_rtsr();
    init_imr();
    *((int *)0xe000e100) = 32;
    forever_fibonacci();
}

//==========================================================
// Test init_iser() and full implementation of external
// interrupt initialization and service routine.
//
void count_button4(void) {
    enable_ports();
    portc_output();
    display_digit(0);
    init_rtsr();
    init_imr();
    init_iser();
    forever_fibonacci();
}

int main() {
    try_fibonacci();
    //test7();
    //try_countup();
    //show_ticks();
    //count_button1();
    //count_button2();
    //count_button3();
    //count_button4();
    return 0;
}
