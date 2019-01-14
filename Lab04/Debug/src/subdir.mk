################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/main.c \
../src/syscalls.c \
../src/system_stm32f0xx.c 

S_UPPER_SRCS += \
../src/lab4.S 

OBJS += \
./src/lab4.o \
./src/main.o \
./src/syscalls.o \
./src/system_stm32f0xx.o 

S_UPPER_DEPS += \
./src/lab4.d 

C_DEPS += \
./src/main.d \
./src/syscalls.d \
./src/system_stm32f0xx.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -mfloat-abi=soft -DSTM32 -DSTM32F0 -DSTM32F051R8Tx -DSTM32F0DISCOVERY -DDEBUG -DSTM32F051x8 -DUSE_HAL_DRIVER -I"/home/prith123/workspace/Lab04/HAL_Driver/Inc/Legacy" -I"/home/prith123/workspace/Lab04/Utilities/STM32F0308-Discovery" -I"/home/prith123/workspace/Lab04/inc" -I"/home/prith123/workspace/Lab04/CMSIS/device" -I"/home/prith123/workspace/Lab04/CMSIS/core" -I"/home/prith123/workspace/Lab04/HAL_Driver/Inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -mfloat-abi=soft -DSTM32 -DSTM32F0 -DSTM32F051R8Tx -DSTM32F0DISCOVERY -DDEBUG -DSTM32F051x8 -DUSE_HAL_DRIVER -I"/home/prith123/workspace/Lab04/HAL_Driver/Inc/Legacy" -I"/home/prith123/workspace/Lab04/Utilities/STM32F0308-Discovery" -I"/home/prith123/workspace/Lab04/inc" -I"/home/prith123/workspace/Lab04/CMSIS/device" -I"/home/prith123/workspace/Lab04/CMSIS/core" -I"/home/prith123/workspace/Lab04/HAL_Driver/Inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


