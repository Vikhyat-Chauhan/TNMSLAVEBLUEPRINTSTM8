   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
  52                     ; 13 void clock_setup(void)
  52                     ; 14 {
  54                     	switch	.text
  55  0000               _clock_setup:
  59                     ; 15 	CLK_DeInit();
  61  0000 cd0000        	call	_CLK_DeInit
  63                     ; 16 	CLK_HSECmd(DISABLE);
  65  0003 4f            	clr	a
  66  0004 cd0000        	call	_CLK_HSECmd
  68                     ; 17 	CLK_LSICmd(DISABLE);
  70  0007 4f            	clr	a
  71  0008 cd0000        	call	_CLK_LSICmd
  73                     ; 18 	CLK_HSICmd(ENABLE);
  75  000b a601          	ld	a,#1
  76  000d cd0000        	call	_CLK_HSICmd
  79  0010               L32:
  80                     ; 19 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
  82  0010 ae0102        	ldw	x,#258
  83  0013 cd0000        	call	_CLK_GetFlagStatus
  85  0016 4d            	tnz	a
  86  0017 27f7          	jreq	L32
  87                     ; 20 		CLK_ClockSwitchCmd(ENABLE);
  89  0019 a601          	ld	a,#1
  90  001b cd0000        	call	_CLK_ClockSwitchCmd
  92                     ; 22 		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  94  001e 4f            	clr	a
  95  001f cd0000        	call	_CLK_HSIPrescalerConfig
  97                     ; 23 		CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
  99  0022 a680          	ld	a,#128
 100  0024 cd0000        	call	_CLK_SYSCLKConfig
 102                     ; 24 		CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 102                     ; 25 		CLK_CURRENTCLOCKSTATE_ENABLE);
 104  0027 4b01          	push	#1
 105  0029 4b00          	push	#0
 106  002b ae01e1        	ldw	x,#481
 107  002e cd0000        	call	_CLK_ClockSwitchConfig
 109  0031 85            	popw	x
 110                     ; 26 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 112  0032 5f            	clrw	x
 113  0033 cd0000        	call	_CLK_PeripheralClockConfig
 115                     ; 27 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 117  0036 ae0100        	ldw	x,#256
 118  0039 cd0000        	call	_CLK_PeripheralClockConfig
 120                     ; 28 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 122  003c ae1300        	ldw	x,#4864
 123  003f cd0000        	call	_CLK_PeripheralClockConfig
 125                     ; 29 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 127  0042 ae1200        	ldw	x,#4608
 128  0045 cd0000        	call	_CLK_PeripheralClockConfig
 130                     ; 30 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 132  0048 ae0300        	ldw	x,#768
 133  004b cd0000        	call	_CLK_PeripheralClockConfig
 135                     ; 31 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 137  004e ae0700        	ldw	x,#1792
 138  0051 cd0000        	call	_CLK_PeripheralClockConfig
 140                     ; 32 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 142  0054 ae0500        	ldw	x,#1280
 143  0057 cd0000        	call	_CLK_PeripheralClockConfig
 145                     ; 33 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 147  005a ae0400        	ldw	x,#1024
 148  005d cd0000        	call	_CLK_PeripheralClockConfig
 150                     ; 34 	}
 153  0060 81            	ret
 178                     ; 36 void gpio_setup(void)
 178                     ; 37 {
 179                     	switch	.text
 180  0061               _gpio_setup:
 184                     ; 38 	GPIO_DeInit(Button_Port);
 186  0061 ae500f        	ldw	x,#20495
 187  0064 cd0000        	call	_GPIO_DeInit
 189                     ; 39 	GPIO_DeInit(Relay_Port);
 191  0067 ae500a        	ldw	x,#20490
 192  006a cd0000        	call	_GPIO_DeInit
 194                     ; 40 	GPIO_Init(Button_Port, Button_Pin, GPIO_MODE_IN_PU_NO_IT);
 196  006d 4b40          	push	#64
 197  006f 4b04          	push	#4
 198  0071 ae500f        	ldw	x,#20495
 199  0074 cd0000        	call	_GPIO_Init
 201  0077 85            	popw	x
 202                     ; 41 	GPIO_Init(Relay_Port, Relay_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 204  0078 4be0          	push	#224
 205  007a 4b08          	push	#8
 206  007c ae500a        	ldw	x,#20490
 207  007f cd0000        	call	_GPIO_Init
 209  0082 85            	popw	x
 210                     ; 42 }
 213  0083 81            	ret
 237                     ; 44 void flash_setup(void)
 237                     ; 45 {
 238                     	switch	.text
 239  0084               _flash_setup:
 243                     ; 46 	FLASH_DeInit();
 245  0084 cd0000        	call	_FLASH_DeInit
 247                     ; 47 }
 250  0087 81            	ret
 303                     ; 49 void delay_ms (int ms) //Function Definition 
 303                     ; 50 {
 304                     	switch	.text
 305  0088               _delay_ms:
 307  0088 89            	pushw	x
 308  0089 5204          	subw	sp,#4
 309       00000004      OFST:	set	4
 312                     ; 51 	int i =0 ;
 314                     ; 52 	int j=0;
 316                     ; 53 	for (i=0; i<=ms; i++)
 318  008b 5f            	clrw	x
 319  008c 1f01          	ldw	(OFST-3,sp),x
 322  008e 201a          	jra	L101
 323  0090               L57:
 324                     ; 55 		for (j=0; j<120; j++) // Nop = Fosc/4
 326  0090 5f            	clrw	x
 327  0091 1f03          	ldw	(OFST-1,sp),x
 329  0093               L501:
 330                     ; 56 		_asm("nop"); //Perform no operation //assembly code <span style="white-space:pre"> </span>
 333  0093 9d            nop
 335                     ; 55 		for (j=0; j<120; j++) // Nop = Fosc/4
 337  0094 1e03          	ldw	x,(OFST-1,sp)
 338  0096 1c0001        	addw	x,#1
 339  0099 1f03          	ldw	(OFST-1,sp),x
 343  009b 9c            	rvf
 344  009c 1e03          	ldw	x,(OFST-1,sp)
 345  009e a30078        	cpw	x,#120
 346  00a1 2ff0          	jrslt	L501
 347                     ; 53 	for (i=0; i<=ms; i++)
 349  00a3 1e01          	ldw	x,(OFST-3,sp)
 350  00a5 1c0001        	addw	x,#1
 351  00a8 1f01          	ldw	(OFST-3,sp),x
 353  00aa               L101:
 356  00aa 9c            	rvf
 357  00ab 1e01          	ldw	x,(OFST-3,sp)
 358  00ad 1305          	cpw	x,(OFST+1,sp)
 359  00af 2ddf          	jrsle	L57
 360                     ; 58 }
 363  00b1 5b06          	addw	sp,#6
 364  00b3 81            	ret
 425                     ; 60 void write_flash(bool value){
 426                     	switch	.text
 427  00b4               _write_flash:
 429  00b4 88            	push	a
 430       00000000      OFST:	set	0
 433                     ; 63 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 435  00b5 4f            	clr	a
 436  00b6 cd0000        	call	_FLASH_SetProgrammingTime
 438                     ; 64 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
 440  00b9 a6f7          	ld	a,#247
 441  00bb cd0000        	call	_FLASH_Unlock
 443                     ; 65 	FLASH_EraseByte(0x4000);
 445  00be ae4000        	ldw	x,#16384
 446  00c1 89            	pushw	x
 447  00c2 ae0000        	ldw	x,#0
 448  00c5 89            	pushw	x
 449  00c6 cd0000        	call	_FLASH_EraseByte
 451  00c9 5b04          	addw	sp,#4
 452                     ; 66 	delay_ms(20);
 454  00cb ae0014        	ldw	x,#20
 455  00ce adb8          	call	_delay_ms
 457                     ; 67 	FLASH_ProgramByte(0x4000, value);
 459  00d0 7b01          	ld	a,(OFST+1,sp)
 460  00d2 88            	push	a
 461  00d3 ae4000        	ldw	x,#16384
 462  00d6 89            	pushw	x
 463  00d7 ae0000        	ldw	x,#0
 464  00da 89            	pushw	x
 465  00db cd0000        	call	_FLASH_ProgramByte
 467  00de 5b05          	addw	sp,#5
 468                     ; 68 	delay_ms(20);
 470  00e0 ae0014        	ldw	x,#20
 471  00e3 ada3          	call	_delay_ms
 473                     ; 69 	FLASH_Lock(FLASH_MEMTYPE_DATA);
 475  00e5 a6f7          	ld	a,#247
 476  00e7 cd0000        	call	_FLASH_Lock
 478                     ; 70 }
 481  00ea 84            	pop	a
 482  00eb 81            	ret
 515                     ; 72 void main()
 515                     ; 73 {
 516                     	switch	.text
 517  00ec               _main:
 521                     ; 74 	clock_setup();
 523  00ec cd0000        	call	_clock_setup
 525                     ; 75 	gpio_setup();
 527  00ef cd0061        	call	_gpio_setup
 529                     ; 76 	flash_setup();
 531  00f2 ad90          	call	_flash_setup
 533                     ; 78 	state = (bool) FLASH_ReadByte(0x4000);
 535  00f4 ae4000        	ldw	x,#16384
 536  00f7 89            	pushw	x
 537  00f8 ae0000        	ldw	x,#0
 538  00fb 89            	pushw	x
 539  00fc cd0000        	call	_FLASH_ReadByte
 541  00ff 5b04          	addw	sp,#4
 542  0101 b700          	ld	_state,a
 543                     ; 79 	delay_ms(20);
 545  0103 ae0014        	ldw	x,#20
 546  0106 ad80          	call	_delay_ms
 548                     ; 81 	if(state == TRUE){
 550  0108 b600          	ld	a,_state
 551  010a a101          	cp	a,#1
 552  010c 260b          	jrne	L151
 553                     ; 82 		GPIO_WriteHigh(Relay_Port, Relay_Pin);
 555  010e 4b08          	push	#8
 556  0110 ae500a        	ldw	x,#20490
 557  0113 cd0000        	call	_GPIO_WriteHigh
 559  0116 84            	pop	a
 561  0117 2009          	jra	L351
 562  0119               L151:
 563                     ; 85 		GPIO_WriteLow(Relay_Port, Relay_Pin);
 565  0119 4b08          	push	#8
 566  011b ae500a        	ldw	x,#20490
 567  011e cd0000        	call	_GPIO_WriteLow
 569  0121 84            	pop	a
 570  0122               L351:
 571                     ; 88 	delay_ms(2000);
 573  0122 ae07d0        	ldw	x,#2000
 574  0125 cd0088        	call	_delay_ms
 576  0128               L551:
 577                     ; 93 		if(GPIO_ReadInputPin(Button_Port, Button_Pin) == FALSE){
 579  0128 4b04          	push	#4
 580  012a ae500f        	ldw	x,#20495
 581  012d cd0000        	call	_GPIO_ReadInputPin
 583  0130 5b01          	addw	sp,#1
 584  0132 4d            	tnz	a
 585  0133 26f3          	jrne	L551
 587  0135               L561:
 588                     ; 95 			while(GPIO_ReadInputPin(Button_Port, Button_Pin) == FALSE);
 590  0135 4b04          	push	#4
 591  0137 ae500f        	ldw	x,#20495
 592  013a cd0000        	call	_GPIO_ReadInputPin
 594  013d 5b01          	addw	sp,#1
 595  013f 4d            	tnz	a
 596  0140 27f3          	jreq	L561
 597                     ; 97 			if(state == TRUE){
 599  0142 b600          	ld	a,_state
 600  0144 a101          	cp	a,#1
 601  0146 260d          	jrne	L171
 602                     ; 98 				GPIO_WriteLow(Relay_Port, Relay_Pin);
 604  0148 4b08          	push	#8
 605  014a ae500a        	ldw	x,#20490
 606  014d cd0000        	call	_GPIO_WriteLow
 608  0150 84            	pop	a
 609                     ; 99 				state = FALSE;
 611  0151 3f00          	clr	_state
 613  0153 200d          	jra	L371
 614  0155               L171:
 615                     ; 103 				GPIO_WriteHigh(Relay_Port, Relay_Pin);
 617  0155 4b08          	push	#8
 618  0157 ae500a        	ldw	x,#20490
 619  015a cd0000        	call	_GPIO_WriteHigh
 621  015d 84            	pop	a
 622                     ; 104 				state = TRUE;
 624  015e 35010000      	mov	_state,#1
 625  0162               L371:
 626                     ; 107 			write_flash(state);
 628  0162 b600          	ld	a,_state
 629  0164 cd00b4        	call	_write_flash
 631                     ; 108 			delay_ms(3000);
 633  0167 ae0bb8        	ldw	x,#3000
 634  016a cd0088        	call	_delay_ms
 636  016d 20b9          	jra	L551
 661                     	xdef	_main
 662                     	xdef	_write_flash
 663                     	xdef	_delay_ms
 664                     	xdef	_flash_setup
 665                     	xdef	_gpio_setup
 666                     	switch	.ubsct
 667  0000               _state:
 668  0000 00            	ds.b	1
 669                     	xdef	_state
 670                     	xdef	_clock_setup
 671                     	xref	_GPIO_ReadInputPin
 672                     	xref	_GPIO_WriteLow
 673                     	xref	_GPIO_WriteHigh
 674                     	xref	_GPIO_Init
 675                     	xref	_GPIO_DeInit
 676                     	xref	_FLASH_SetProgrammingTime
 677                     	xref	_FLASH_ReadByte
 678                     	xref	_FLASH_ProgramByte
 679                     	xref	_FLASH_EraseByte
 680                     	xref	_FLASH_DeInit
 681                     	xref	_FLASH_Lock
 682                     	xref	_FLASH_Unlock
 683                     	xref	_CLK_GetFlagStatus
 684                     	xref	_CLK_SYSCLKConfig
 685                     	xref	_CLK_HSIPrescalerConfig
 686                     	xref	_CLK_ClockSwitchConfig
 687                     	xref	_CLK_PeripheralClockConfig
 688                     	xref	_CLK_ClockSwitchCmd
 689                     	xref	_CLK_LSICmd
 690                     	xref	_CLK_HSICmd
 691                     	xref	_CLK_HSECmd
 692                     	xref	_CLK_DeInit
 712                     	end
