
SYSCTL_RCCAHB1ENR_R EQU 0x40023830
GPIOC_BASE          EQU 0x40020800 
GPIOC_MODER         EQU GPIOC_BASE
GPIOC_ODR           EQU 0x40020805

GPIOCEN             EQU 1 << 2
	
MODER05_OUT         EQU 1 << 10
	
LED_GREEN           EQU 1 << 5

ONESEC              EQU 5333333

				AREA	|.text|,CODE,READONLY,ALIGN=2
				THUMB
				EXPORT __main

__main
		BL		GPIOC_Init
		
GPIOC_Init
		LDR		R0,=SYSCTL_RCCAHB1ENR_R
		LDR		R1,[R0]
		ORR		R1,GPIOCEN
		STR		R1,[R0]
		
		LDR 	R0,=GPIOC_MODER
		LDR 	R1,=MODER05_OUT
		STR 	R1,[R0]
		MOV 	R1,#0
		LDR 	R2,=GPIOC_ODR
		
Blink
		MOVW	R1,#LED_GREEN
		STR	    R1,[R2]
		LDR		R3,=ONESEC
		BL		Delay
		B		Blink
		
Delay
		SUBS	R3,R3,#1
		BNE		Delay
		BX		LR
		ALIGN
		END
		