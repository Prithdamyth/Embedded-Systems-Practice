################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Utilities/STM32F0308-Discovery/stm32f0308_discovery.c 

OBJS += \
./Utilities/STM32F0308-Discovery/stm32f0308_discovery.o 

C_DEPS += \
./Utilities/STM32F0308-Discovery/stm32f0308_discovery.d 


# Each subdirectory must supply rules for building sources it contributes
Utilities/STM32F0308-Discovery/%.o: ../Utilities/STM32F0308-Discovery/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -mfloat-abi=soft -DSTM32 -DSTM32F0 -DSTM32F051R8Tx -DSTM32F0DISCOVERY -DDEBUG -DSTM32F051x8 -DUSE_HAL_DRIVER -I"/home/prith123/workspace/lab05/HAL_Driver/Inc/Legacy" -I"/home/prith123/workspace/lab05/Utilities/STM32F0308-Discovery" -I"/home/prith123/workspace/lab05/inc" -I"/home/prith123/workspace/lab05/CMSIS/device" -I"/home/prith123/workspace/lab05/CMSIS/core" -I"/home/prith123/workspace/lab05/HAL_Driver/Inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


