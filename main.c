#include "STM8S.h"
#define Button_Port GPIOD
#define Relay_Port GPIOC
#define Button_Pin GPIO_PIN_2
#define Relay_Pin GPIO_PIN_3

bool switch_state = FALSE;

void clock_setup(void);
void GPIO_setup(void);
void Flash_setup(void);

void delay_ms (int ms) //Function Definition 
{
	int i =0 ;
	int j=0;
	for (i=0; i<=ms; i++)
	{
		for (j=0; j<120; j++) // Nop = Fosc/4
		_asm("nop"); //Perform no operation //assembly code <span style="white-space:pre"> </span>
	}
}

void Write_Flash(unsigned char value){
	FLASH_Unlock(FLASH_MEMTYPE_DATA);
	FLASH_EraseByte(0x4000);
	delay_ms(20);
	FLASH_ProgramByte(0x4000, value);
	delay_ms(20);
	FLASH_Lock(FLASH_MEMTYPE_DATA);
}

void main()
{
	unsigned char value = 0x21;
	clock_setup();
	GPIO_setup();
	Flash_setup();
	//value = FLASH_ReadByte(0x4000);
	delay_ms(2000);
	//Write_Flash(value);
	switch_state = FLASH_ReadByte(0x4000);
	while(TRUE)
	{
		if(GPIO_ReadInputPin(Button_Port, Button_Pin) == FALSE){
			if(switch_state == TRUE){
				GPIO_WriteLow(Relay_Port, Relay_Pin);
				switch_state = FALSE;
				Write_Flash(switch_state);
			}
			else{
				GPIO_WriteHigh(Relay_Port, Relay_Pin);
				switch_state = TRUE;
				Write_Flash(switch_state);
			}
			delay_ms(4000);
		}
	};
}

void clock_setup(void)
{
	CLK_DeInit();
	CLK_HSECmd(DISABLE);
	CLK_LSICmd(DISABLE);
	CLK_HSICmd(ENABLE);
	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
		CLK_ClockSwitchCmd(ENABLE);

		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
		CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
		CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
		CLK_CURRENTCLOCKSTATE_ENABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
	}

void GPIO_setup(void)
{
GPIO_DeInit(Button_Port);
GPIO_DeInit(Relay_Port);
GPIO_Init(Button_Port, Button_Pin, GPIO_MODE_IN_PU_NO_IT); 
GPIO_Init(Relay_Port, Relay_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
}

void Flash_setup(void)
{
FLASH_DeInit();
}


