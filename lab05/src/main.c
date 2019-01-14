/**
  ******************************************************************************
  * @file    main.c
  * @author  Ac6
  * @version V1.0
  * @date    01-December-2013
  * @brief   Default main function.
  ******************************************************************************
**/

#include "stm32f0xx.h"
#include "stm32f0308_discovery.h"
			

void prob1(void);
void prob2(void);
void prob3(void);
void prob4(void);
void display(int);
void increment(void);
void enablePortC(void);
void micro_wait(int);

void enablePortC(void)
{
    RCC->AHBENR |= RCC_AHBENR_GPIOCEN;

}

void prob1(void)
{
    enablePortC();
    GPIOC->MODER = (GPIOC->MODER & ~GPIO_MODER_MODER9_Msk) |
            GPIO_MODER_MODER9_0;
    for(;;) {
        GPIOC->BSRR = GPIO_ODR_9;
        micro_wait(1000000);
        GPIOC->BRR = GPIO_ODR_9;
        micro_wait(1000000);
    }
}

void prob2(void)
{

     // Enable Port C
     enablePortC();
     // Set the mode for PC8 for "alternate function"
     GPIOC->MODER &= ~(3<<18);
     GPIOC->MODER |= 2<<18;
     // Set the alternate function for PC8
     // PC0-7 are on AFR[0], 8-15 are on AFR[1]
     GPIOC->AFR[1] &= ~0xf;
     GPIOC->AFR[1] |= 1;

     // Enable the system clock for timer 3
     RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;

     // Counting direction: 0=up, 1=down
     TIM3->CR1 &= ~TIM_CR1_DIR; // clear it to count up

     // Set pre-scaler output to 1kHz (8MHz/8000)
     TIM3->PSC = 8000 - 1;

     // Auto-reload 1000
     TIM3->ARR = 1000 - 1;

     // Any value between 0 and 1000.
     TIM3->CCR4 = 500; //CHANGED TO CCR4 FROM CCR3

     // Channel 3 of the timer is configured in CCMR2.
     // Set the bits to select toggle mode (011)
     TIM3->CCMR2 &= ~TIM_CCMR2_OC4M_2; // Turn off bit 2.
     TIM3->CCMR2 |= TIM_CCMR2_OC4M_1 | TIM_CCMR2_OC4M_0;

     // Enable output for channel 3 active-high output
     TIM3->CCER |= TIM_CCER_CC4E;

     // Enable timer 3
     TIM3->CR1 |= TIM_CR1_CEN;

     while(1)
     {
         asm("wfi");
     }

}

void prob3(void)
{

     // Enable Port C
     enablePortC();
     // Set the mode for PC8 for "alternate function"
     GPIOC->MODER &= ~(3<<16);
     GPIOC->MODER |= 2<<16;
     // Set the alternate function for PC8
     // PC0-7 are on AFR[0], 8-15 are on AFR[1]
     GPIOC->AFR[1] &= ~0xf;
     GPIOC->AFR[1] |= 1;

     // Enable the system clock for timer 3
     RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;

     // Counting direction: 0=up, 1=down
     TIM3->CR1 &= ~TIM_CR1_DIR; // clear it to count up

     // Set pre-scaler output to 1kHz (8MHz/8000)
     TIM3->PSC = 8000 - 1;

     // Auto-reload 1000
     TIM3->ARR = 1000 - 1;

     // Any value between 0 and 1000.
     TIM3->CCR3 = 500;

     // Channel 3 of the timer is configured in CCMR2.
     // Set the bits to select toggle mode (011)
     TIM3->CCMR2 &= ~TIM_CCMR2_OC3M_2; // Turn off bit 2.
     TIM3->CCMR2 |= TIM_CCMR2_OC3M_1 | TIM_CCMR2_OC3M_0;

     // Enable output for channel 3 active-high output
     TIM3->CCER |= TIM_CCER_CC3E;

     // Enable timer 3
     TIM3->CR1 |= TIM_CR1_CEN;

     prob2();
     while(1)
     {
         asm("wfi");
     }

}

void prob4(void)
{

    // Enable Port C
         enablePortC();
         // Set the mode for PC6 for "alternate function"
         GPIOC->MODER &= ~(3<<12);
         GPIOC->MODER |= 2<<12;
         // Set the alternate function for PC6
         // PC0-7 are on AFR[0], 8-15 are on AFR[1]
         GPIOC->AFR[0] &= ~0xf;
         GPIOC->AFR[0] |= 1;

         // Enable the system clock for timer 3
         RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;

         // Counting direction: 0=up, 1=down
         TIM3->CR1 &= ~TIM_CR1_DIR; // clear it to count up

         // Set pre-scaler output to 1kHz (8MHz/8000)
         TIM3->PSC = 8000 - 1;

         // Auto-reload 1000
         TIM3->ARR = 1000 - 1;

         // Any value between 0 and 1000.
         TIM3->CCR1 = 400;

         // Channel 1 of the timer is configured in CCMR1.
         // Set the bits to select toggle mode (011)
         TIM3->CCMR1 &= ~TIM_CCMR1_OC1M_2; // Turn off bit 2.
         TIM3->CCMR1 |= TIM_CCMR1_OC1M_1 | TIM_CCMR1_OC1M_0;

         // Enable output for channel 1 active-high output
         TIM3->CCER |= TIM_CCER_CC1E;

         // Enable timer 3
         TIM3->CR1 |= TIM_CR1_CEN;

         // Set the mode for PC7 for "alternate function"
                  GPIOC->MODER &= ~(3<<14);
                  GPIOC->MODER |= 2<<14;
                  // Set the alternate function for PC7
                  // PC0-7 are on AFR[0], 8-15 are on AFR[1]
                  GPIOC->AFR[0] &= ~0xf;
                  GPIOC->AFR[0] |= 1;

                  // Enable the system clock for timer 3
                  RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;

                  // Counting direction: 0=up, 1=down
                  TIM3->CR1 &= ~TIM_CR1_DIR; // clear it to count up

                  // Set pre-scaler output to 1kHz (8MHz/8000)
                  TIM3->PSC = 8000 - 1;

                  // Auto-reload 1000
                  TIM3->ARR = 1000 - 1;

                  // Any value between 0 and 1000.
                  TIM3->CCR2 = 500;

                  // Channel 2 of the timer is configured in CCMR1.
                  // Set the bits to select toggle mode (011)
                  TIM3->CCMR1 &= ~TIM_CCMR1_OC2M_2; // Turn off bit 2.
                  TIM3->CCMR1 |= TIM_CCMR1_OC2M_1 | TIM_CCMR1_OC2M_0;

                  // Enable output for channel 2 active-high output
                  TIM3->CCER |= TIM_CCER_CC2E;

                  // Enable timer 3
                  TIM3->CR1 |= TIM_CR1_CEN;



         prob3();
         while(1)
         {
             asm("wfi");
         }

}

void prob5(void)
{
    enablePortC();
    //pin 6
    GPIOC->MODER &= ~(3<<12);
    GPIOC->MODER |= 1<<12;
    //pin 7
    GPIOC->MODER &= ~(3<<14);
    GPIOC->MODER |= 1<<14;
    //pin 8
    GPIOC->MODER &= ~(3<<16);
    GPIOC->MODER |= 1<<16;
    //pin 9
    GPIOC->MODER &= ~(3<<18);
    GPIOC->MODER |= 1<<18;

    //enable port A
    RCC->AHBENR |= RCC_AHBENR_GPIOAEN;

    //set pa0 to be alternate function
    GPIOA->MODER |= 2<<0;

    // Set the alternate function for PA0
    // PA0-7 are on AFR[0], 8-15 are on AFR[1]
    GPIOA->AFR[0] &= ~0xf;
    GPIOA->AFR[0] |= 2;

    display(0);

    // Enable the system clock for timer 2
    RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;

    // Counting direction: 0=up, 1=down
    TIM2->CR1 &= ~TIM_CR1_DIR; // clear it to count up

    // Set pre-scaler output to 1kHz (8MHz/8000)
    TIM2->PSC = 1 - 1;

    // Auto-reload
    TIM2->ARR = 0xfffffff;

    TIM2->CCMR1 |= TIM_CCMR1_CC1S_0;

    TIM2->CCER |= TIM_CCER_CC1E;

    TIM2->DIER |= TIM_DIER_CC1IE;

    //enable timer 2
    TIM2->CR1 |= TIM_CR1_CEN;

    NVIC -> ISER[0] = 1 << TIM2_IRQn;

    while(1)
    {
        asm("wfi");
    }

}

void prob6(void)
{
    enablePortC();
        //pin 6
        GPIOC->MODER &= ~(3<<12);
        GPIOC->MODER |= 1<<12;
        //pin 7
        GPIOC->MODER &= ~(3<<14);
        GPIOC->MODER |= 1<<14;
        //pin 8
        GPIOC->MODER &= ~(3<<16);
        GPIOC->MODER |= 1<<16;
        //pin 9
        GPIOC->MODER &= ~(3<<18);
        GPIOC->MODER |= 1<<18;

        //enable port A
        RCC->AHBENR |= RCC_AHBENR_GPIOAEN;

        //set pa1 to be alternate function
        GPIOA->MODER |= 2<<2;

        //Configure PA1 to use internal pull-down resister
        GPIOA->PUPDR |= 2<<2;

        // Set the alternate function for PA1
        // PA0-7 are on AFR[0], 8-15 are on AFR[1]
        GPIOA->AFR[0] &= ~0xf;
        GPIOA->AFR[0] |= 2<<4;

        display(0);

        // Enable the system clock for timer 2
        RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;

        // Counting direction: 0=up, 1=down
        TIM2->CR1 &= ~TIM_CR1_DIR; // clear it to count up

        // Set pre-scaler output to 1kHz (8MHz/8000)
        TIM2->PSC = 1 - 1;

        // Auto-reload
        TIM2->ARR = 0xfffffff;

        TIM2->CCMR1 |= TIM_CCMR1_CC2S_0;

        TIM2->CCER |= TIM_CCER_CC2E;

        TIM2->DIER |= TIM_DIER_CC2IE;

        //enable timer 2
        TIM2->CR1 |= TIM_CR1_CEN;

        NVIC -> ISER[0] = 1 << TIM2_IRQn;

        TIM2->CCMR1 |= TIM_CCMR1_IC2F_3 | TIM_CCMR1_IC2F_2 | TIM_CCMR1_IC2F_1 |TIM_CCMR1_IC2F_0;

        TIM2->CR1 |= 2 << 8;

        while(1)
        {
            asm("wfi");
        }

}

void display (int x)
{
    GPIOC->BSRR = ((0xf<<6)<<16) | ((x & 0xf) <<6);
}
int count = 0;
void increment(void)
{
    count += 1;
    display(count);
}

void TIM2_IRQHandler(void)
{
    increment();
    volatile flag;
    flag = TIM2->CCR1;
    flag = TIM2->CCR2;

}


int main(void)
{
    //prob1();
    //prob2();
    //prob3();
    //prob4();
    //prob5();
    prob6();
}
