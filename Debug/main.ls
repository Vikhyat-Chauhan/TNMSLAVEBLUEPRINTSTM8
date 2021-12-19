   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.5 - 16 Jun 2021
   3                     ; Generator (Limited) V4.5.3 - 16 Jun 2021
  14                     	bsct
  15  0000               _switch_state:
  16  0000 00            	dc.b	0
  75                     ; 13 void delay_ms (int ms) //Function Definition 
  75                     ; 14 {
  77                     	switch	.text
  78  0000               _delay_ms:
  80  0000 89            	pushw	x
  81  0001 5204          	subw	sp,#4
  82       00000004      OFST:	set	4
  85                     ; 15 	int i =0 ;
  87                     ; 16 	int j=0;
  89                     ; 17 	for (i=0; i<=ms; i++)
  91  0003 5f            	clrw	x
  92  0004 1f01          	ldw	(OFST-3,sp),x
  95  0006 201a          	jra	L34
  96  0008               L73:
  97                     ; 19 		for (j=0; j<120; j++) // Nop = Fosc/4
  99  0008 5f            	clrw	x
 100  0009 1f03          	ldw	(OFST-1,sp),x
 102  000b               L74:
 103                     ; 20 		_asm("nop"); //Perform no operation //assembly code <span style="white-space:pre"> </span>
 106  000b 9d            nop
 108                     ; 19 		for (j=0; j<120; j++) // Nop = Fosc/4
 110  000c 1e03          	ldw	x,(OFST-1,sp)
 111  000e 1c0001        	addw	x,#1
 112  0011 1f03          	ldw	(OFST-1,sp),x
 116  0013 9c            	rvf
 117  0014 1e03          	ldw	x,(OFST-1,sp)
 118  0016 a30078        	cpw	x,#120
 119  0019 2ff0          	jrslt	L74
 120                     ; 17 	for (i=0; i<=ms; i++)
 122  001b 1e01          	ldw	x,(OFST-3,sp)
 123  001d 1c0001        	addw	x,#1
 124  0020 1f01          	ldw	(OFST-3,sp),x
 126  0022               L34:
 129  0022 9c            	rvf
 130  0023 1e01          	ldw	x,(OFST-3,sp)
 131  0025 1305          	cpw	x,(OFST+1,sp)
 132  0027 2ddf          	jrsle	L73
 133                     ; 22 }
 136  0029 5b06          	addw	sp,#6
 137  002b 81            	ret
 176                     ; 24 void Write_Flash(unsigned char value){
 177                     	switch	.text
 178  002c               _Write_Flash:
 180  002c 88            	push	a
 181       00000000      OFST:	set	0
 184                     ; 25 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
 186  002d a6f7          	ld	a,#247
 187  002f cd0000        	call	_FLASH_Unlock
 189                     ; 26 	FLASH_EraseByte(0x4000);
 191  0032 ae4000        	ldw	x,#16384
 192  0035 89            	pushw	x
 193  0036 ae0000        	ldw	x,#0
 194  0039 89            	pushw	x
 195  003a cd0000        	call	_FLASH_EraseByte
 197  003d 5b04          	addw	sp,#4
 198                     ; 27 	delay_ms(20);
 200  003f ae0014        	ldw	x,#20
 201  0042 adbc          	call	_delay_ms
 203                     ; 28 	FLASH_ProgramByte(0x4000, value);
 205  0044 7b01          	ld	a,(OFST+1,sp)
 206  0046 88            	push	a
 207  0047 ae4000        	ldw	x,#16384
 208  004a 89            	pushw	x
 209  004b ae0000        	ldw	x,#0
 210  004e 89            	pushw	x
 211  004f cd0000        	call	_FLASH_ProgramByte
 213  0052 5b05          	addw	sp,#5
 214                     ; 29 	delay_ms(20);
 216  0054 ae0014        	ldw	x,#20
 217  0057 ada7          	call	_delay_ms
 219                     ; 30 	FLASH_Lock(FLASH_MEMTYPE_DATA);
 221  0059 a6f7          	ld	a,#247
 222  005b cd0000        	call	_FLASH_Lock
 224                     ; 31 }
 227  005e 84            	pop	a
 228  005f 81            	ret
 272                     ; 33 void main()
 272                     ; 34 {
 273                     	switch	.text
 274  0060               _main:
 276  0060 88            	push	a
 277       00000001      OFST:	set	1
 280                     ; 35 	unsigned char value = 0x21;
 282                     ; 36 	clock_setup();
 284  0061 ad57          	call	_clock_setup
 286                     ; 37 	GPIO_setup();
 288  0063 cd011b        	call	_GPIO_setup
 290                     ; 38 	Flash_setup();
 292  0066 cd013e        	call	_Flash_setup
 294                     ; 40 	delay_ms(2000);
 296  0069 ae07d0        	ldw	x,#2000
 297  006c ad92          	call	_delay_ms
 299                     ; 42 	switch_state = FLASH_ReadByte(0x4000);
 301  006e ae4000        	ldw	x,#16384
 302  0071 89            	pushw	x
 303  0072 ae0000        	ldw	x,#0
 304  0075 89            	pushw	x
 305  0076 cd0000        	call	_FLASH_ReadByte
 307  0079 5b04          	addw	sp,#4
 308  007b b700          	ld	_switch_state,a
 309  007d               L111:
 310                     ; 45 		if(GPIO_ReadInputPin(Button_Port, Button_Pin) == FALSE){
 312  007d 4b04          	push	#4
 313  007f ae500f        	ldw	x,#20495
 314  0082 cd0000        	call	_GPIO_ReadInputPin
 316  0085 5b01          	addw	sp,#1
 317  0087 4d            	tnz	a
 318  0088 26f3          	jrne	L111
 319                     ; 46 			if(switch_state == TRUE){
 321  008a b600          	ld	a,_switch_state
 322  008c a101          	cp	a,#1
 323  008e 2610          	jrne	L711
 324                     ; 47 				GPIO_WriteLow(Relay_Port, Relay_Pin);
 326  0090 4b08          	push	#8
 327  0092 ae500a        	ldw	x,#20490
 328  0095 cd0000        	call	_GPIO_WriteLow
 330  0098 84            	pop	a
 331                     ; 48 				switch_state = FALSE;
 333  0099 3f00          	clr	_switch_state
 334                     ; 49 				Write_Flash(switch_state);
 336  009b 4f            	clr	a
 337  009c ad8e          	call	_Write_Flash
 340  009e 2012          	jra	L121
 341  00a0               L711:
 342                     ; 52 				GPIO_WriteHigh(Relay_Port, Relay_Pin);
 344  00a0 4b08          	push	#8
 345  00a2 ae500a        	ldw	x,#20490
 346  00a5 cd0000        	call	_GPIO_WriteHigh
 348  00a8 84            	pop	a
 349                     ; 53 				switch_state = TRUE;
 351  00a9 35010000      	mov	_switch_state,#1
 352                     ; 54 				Write_Flash(switch_state);
 354  00ad a601          	ld	a,#1
 355  00af cd002c        	call	_Write_Flash
 357  00b2               L121:
 358                     ; 56 			delay_ms(4000);
 360  00b2 ae0fa0        	ldw	x,#4000
 361  00b5 cd0000        	call	_delay_ms
 363  00b8 20c3          	jra	L111
 396                     ; 61 void clock_setup(void)
 396                     ; 62 {
 397                     	switch	.text
 398  00ba               _clock_setup:
 402                     ; 63 	CLK_DeInit();
 404  00ba cd0000        	call	_CLK_DeInit
 406                     ; 64 	CLK_HSECmd(DISABLE);
 408  00bd 4f            	clr	a
 409  00be cd0000        	call	_CLK_HSECmd
 411                     ; 65 	CLK_LSICmd(DISABLE);
 413  00c1 4f            	clr	a
 414  00c2 cd0000        	call	_CLK_LSICmd
 416                     ; 66 	CLK_HSICmd(ENABLE);
 418  00c5 a601          	ld	a,#1
 419  00c7 cd0000        	call	_CLK_HSICmd
 422  00ca               L531:
 423                     ; 67 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 425  00ca ae0102        	ldw	x,#258
 426  00cd cd0000        	call	_CLK_GetFlagStatus
 428  00d0 4d            	tnz	a
 429  00d1 27f7          	jreq	L531
 430                     ; 68 		CLK_ClockSwitchCmd(ENABLE);
 432  00d3 a601          	ld	a,#1
 433  00d5 cd0000        	call	_CLK_ClockSwitchCmd
 435                     ; 70 		CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 437  00d8 4f            	clr	a
 438  00d9 cd0000        	call	_CLK_HSIPrescalerConfig
 440                     ; 71 		CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 442  00dc a680          	ld	a,#128
 443  00de cd0000        	call	_CLK_SYSCLKConfig
 445                     ; 72 		CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, DISABLE,
 445                     ; 73 		CLK_CURRENTCLOCKSTATE_ENABLE);
 447  00e1 4b01          	push	#1
 448  00e3 4b00          	push	#0
 449  00e5 ae01e1        	ldw	x,#481
 450  00e8 cd0000        	call	_CLK_ClockSwitchConfig
 452  00eb 85            	popw	x
 453                     ; 74 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 455  00ec 5f            	clrw	x
 456  00ed cd0000        	call	_CLK_PeripheralClockConfig
 458                     ; 75 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 460  00f0 ae0100        	ldw	x,#256
 461  00f3 cd0000        	call	_CLK_PeripheralClockConfig
 463                     ; 76 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 465  00f6 ae1300        	ldw	x,#4864
 466  00f9 cd0000        	call	_CLK_PeripheralClockConfig
 468                     ; 77 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 470  00fc ae1200        	ldw	x,#4608
 471  00ff cd0000        	call	_CLK_PeripheralClockConfig
 473                     ; 78 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, DISABLE);
 475  0102 ae0300        	ldw	x,#768
 476  0105 cd0000        	call	_CLK_PeripheralClockConfig
 478                     ; 79 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 480  0108 ae0700        	ldw	x,#1792
 481  010b cd0000        	call	_CLK_PeripheralClockConfig
 483                     ; 80 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 485  010e ae0500        	ldw	x,#1280
 486  0111 cd0000        	call	_CLK_PeripheralClockConfig
 488                     ; 81 		CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, DISABLE);
 490  0114 ae0400        	ldw	x,#1024
 491  0117 cd0000        	call	_CLK_PeripheralClockConfig
 493                     ; 82 	}
 496  011a 81            	ret
 521                     ; 84 void GPIO_setup(void)
 521                     ; 85 {
 522                     	switch	.text
 523  011b               _GPIO_setup:
 527                     ; 86 GPIO_DeInit(Button_Port);
 529  011b ae500f        	ldw	x,#20495
 530  011e cd0000        	call	_GPIO_DeInit
 532                     ; 87 GPIO_DeInit(Relay_Port);
 534  0121 ae500a        	ldw	x,#20490
 535  0124 cd0000        	call	_GPIO_DeInit
 537                     ; 88 GPIO_Init(Button_Port, Button_Pin, GPIO_MODE_IN_PU_NO_IT); 
 539  0127 4b40          	push	#64
 540  0129 4b04          	push	#4
 541  012b ae500f        	ldw	x,#20495
 542  012e cd0000        	call	_GPIO_Init
 544  0131 85            	popw	x
 545                     ; 89 GPIO_Init(Relay_Port, Relay_Pin, GPIO_MODE_OUT_PP_LOW_FAST);
 547  0132 4be0          	push	#224
 548  0134 4b08          	push	#8
 549  0136 ae500a        	ldw	x,#20490
 550  0139 cd0000        	call	_GPIO_Init
 552  013c 85            	popw	x
 553                     ; 90 }
 556  013d 81            	ret
 580                     ; 92 void Flash_setup(void)
 580                     ; 93 {
 581                     	switch	.text
 582  013e               _Flash_setup:
 586                     ; 94 FLASH_DeInit();
 588  013e cd0000        	call	_FLASH_DeInit
 590                     ; 95 }
 593  0141 81            	ret
 638                     	xdef	_main
 639                     	xdef	_Write_Flash
 640                     	xdef	_delay_ms
 641                     	xdef	_Flash_setup
 642                     	xdef	_GPIO_setup
 643                     	xdef	_clock_setup
 644                     	xdef	_switch_state
 645                     	xref	_GPIO_ReadInputPin
 646                     	xref	_GPIO_WriteLow
 647                     	xref	_GPIO_WriteHigh
 648                     	xref	_GPIO_Init
 649                     	xref	_GPIO_DeInit
 650                     	xref	_FLASH_ReadByte
 651                     	xref	_FLASH_ProgramByte
 652                     	xref	_FLASH_EraseByte
 653                     	xref	_FLASH_DeInit
 654                     	xref	_FLASH_Lock
 655                     	xref	_FLASH_Unlock
 656                     	xref	_CLK_GetFlagStatus
 657                     	xref	_CLK_SYSCLKConfig
 658                     	xref	_CLK_HSIPrescalerConfig
 659                     	xref	_CLK_ClockSwitchConfig
 660                     	xref	_CLK_PeripheralClockConfig
 661                     	xref	_CLK_ClockSwitchCmd
 662                     	xref	_CLK_LSICmd
 663                     	xref	_CLK_HSICmd
 664                     	xref	_CLK_HSECmd
 665                     	xref	_CLK_DeInit
 684                     	end
