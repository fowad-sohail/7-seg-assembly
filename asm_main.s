;Fowad Sohail and Tim Catrino
;Intro to Embedded Final Project
;7 Seg Display Counter

; Port 1 Pin Direction Register
P1DIR EQU 0x40004C04
; Port 1 Pin Output Register
P1OUT EQU 0x40004C02
P1IN EQU 0x40004C00
P1REN EQU 0x40004C06
	
P2REN EQU 0x40004C07 ; resistor enable
P2DIR EQU 0x40004C05
P2OUT EQU 0x40004C03
P2IN EQU 0x40004C01

P3OUT EQU 0x40004C22
P3DIR EQU 0x40004C24
	
P5OUT EQU 0x40004C42
P5DIR EQU 0x40004C44	
	
	
UPmask EQU 0x2 ; bitmask P1.1
DOWNmask EQU 0x10 ; bitmask P1.4
	

; masks for all segments of the display
segA_mask EQU 0x40 ; bitmask P3.6
segB_mask EQU 0x8 ; bitmask P2.3
segC_mask EQU 0x80 ; bitmask P3.7
segD_mask EQU 0x20 ; bitmask P3.5
segE_mask EQU 0x2 ; bitmask P5.1
segF_mask EQU 0x4; bitmask P5.2
segG_mask EQU 0x1 ; bitmask P5.0


        THUMB
        AREA    |.text|, CODE, READONLY, ALIGN=2
        EXPORT  asm_main

asm_main
        LDR     R0, =P2DIR      
        LDRB    R1, [R0]
        ORR     R1, #8          
        STRB    R1, [R0]        
				
		LDR     R0, =P1DIR      
        LDRB    R1, [R0]
        ORR     R1, #2          
        STRB    R1, [R0]
		
		LDR     R0, =P3DIR      
        LDRB    R1, [R0]
        ORR     R1, #224          
        STRB    R1, [R0]
		
		LDR     R0, =P5DIR      
        LDRB    R1, [R0]
        ORR     R1, #7          
        STRB    R1, [R0]
		
		; initally clear all the ports - P2, P3, P5
		LDR     R0, =P2OUT   
		LDRB    R1, [R0]
		ORR		R1, segB_mask
		STRB	R1, [R0]
		
		LDR     R0, =P3OUT   
		LDRB    R1, [R0]
		ORR		R1, #224
		STRB	R1, [R0]
		
		LDR     R0, =P5OUT   
		LDRB    R1, [R0]
		ORR		R1, #7
		STRB	R1, [R0]

loop
        BL		state0
        
        B       loop	; repeat the loop

; STATES - these control what character is on the 7 segment display
;-------------------------------------------------------------------------------
state0
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 1
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state1
	
	BL displayA
	BL displayB
	BL displayC
	BL displayD
	BL displayE
	BL displayF
	
	B state0
;-------------------------------------------------------------------------------
state1
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 2
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state2
	
	; to count down to 1
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, DOWNmask
	BEQ state0

	BL displayB
	BL displayC
	
	B state1
;-------------------------------------------------------------------------------
state2
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 3
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state3

	BL displayA
	BL displayB
	BL displayD
	BL displayE
	BL displayG
	
	B state2
;-------------------------------------------------------------------------------
state3
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 4
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state4

	BL displayA
	BL displayB
	BL displayC
	BL displayD
	BL displayG
	
	B state3
;-------------------------------------------------------------------------------
state4
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 5
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state5
	
	BL displayB
	BL displayC
	BL displayF
	BL displayG

	B state4
;-------------------------------------------------------------------------------
state5
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 6
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state6

	BL displayA
	BL displayC
	BL displayD
	BL displayF
	BL displayG
	
	B state5
;-------------------------------------------------------------------------------
state6
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 7
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state7
	
	BL displayA
	BL displayC
	BL displayD
	BL displayE
	BL displayF
	BL displayG
	
	B state6
;-------------------------------------------------------------------------------
state7
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 8
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state8
	
	BL displayA
	BL displayB
	BL displayC
	
	B state7
;-------------------------------------------------------------------------------
state8
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to 9
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state9

	BL displayA
	BL displayB
	BL displayC
	BL displayD
	BL displayE
	BL displayF
	BL displayG
	
	B state8
;-------------------------------------------------------------------------------
state9
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to A
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ stateA

	BL displayA
	BL displayB
	BL displayC
	BL displayD
	BL displayF
	BL displayG
	
	B state9
;-------------------------------------------------------------------------------	
stateA
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to B
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ stateB
	
	BL displayA
	BL displayB
	BL displayC
	BL displayE
	BL displayF
	BL displayG
	
	B stateA
;-------------------------------------------------------------------------------
stateB
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to C
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ stateC
	
	BL displayC
	BL displayD
	BL displayE
	BL displayF
	BL displayG
	
	B stateB
;-------------------------------------------------------------------------------
stateC
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to D
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ stateD
	
	BL displayA
	BL displayD
	BL displayE
	BL displayF
	
	B stateC
;-------------------------------------------------------------------------------
stateD
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to E
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ stateE

	BL displayB
	BL displayC
	BL displayD
	BL displayE
	BL displayG
	
	B stateD
;-------------------------------------------------------------------------------	
stateE
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; to count up to F
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ stateF

	BL displayA
	BL displayD
	BL displayE
	BL displayF
	BL displayG
	
	B stateE
;-------------------------------------------------------------------------------
stateF
	LDR     R0, =150000
    BL      delayMs
	
	BL allOFF
	
	; if count up button pressed, roll over to 0
	LDR r0, =P1IN
	LDRB r1, [r0]
	TST r1, UPmask
	BEQ state0

	BL displayA
	BL displayE
	BL displayF
	BL displayG
	
	B stateF
; ------------------------------------------------------------------------------

; SUBROUTINES - these control which segment to light up
; ------------------------------------------------------------------------------
delayMs
       
L1      SUBS    R0, #1          ; inner loop
        BNE     L1
        BX      LR

allOFF ; turn all segments off
		LDR     R0, =P2OUT   
		LDRB    R1, [R0]
		ORR		R1, segB_mask
		STRB	R1, [R0]
		
		LDR     R0, =P3OUT   
		LDRB    R1, [R0]
		ORR		R1, #224
		STRB	R1, [R0]
		
		LDR     R0, =P5OUT   
		LDRB    R1, [R0]
		ORR		R1, #7
		STRB	R1, [R0]
		
		BX LR
		
displayA ; turn on port 3.6
		LDR     R0, =P3OUT
        LDRB    R1, [R0]
        BIC     R1, segA_mask
        STRB    R1, [R0]
		BX      LR

displayB ; turn on port 2.3
		LDR     R0, =P2OUT
        LDRB    R1, [R0]
        BIC     R1, segB_mask
        STRB    R1, [R0]
		BX      LR

displayC ; turn on port 3.7
		LDR     R0, =P3OUT
        LDRB    R1, [R0]
        BIC     R1, segC_mask
        STRB    R1, [R0]
		BX      LR

displayD ; turn on port 3.5
		LDR     R0, =P3OUT
        LDRB    R1, [R0]
        BIC     R1, segD_mask
        STRB    R1, [R0]
		BX      LR
		
displayE ; turn on port 5.1
		LDR     R0, =P5OUT
        LDRB    R1, [R0]
        BIC     R1, segE_mask
        STRB    R1, [R0]
		BX      LR
		
displayF ; turn on port 5.2
		LDR     R0, =P5OUT
        LDRB    R1, [R0]
        BIC     R1, segF_mask
        STRB    R1, [R0]
		BX      LR

displayG ; turn on port 5.0
		LDR     R0, =P5OUT
        LDRB    R1, [R0]
        BIC     R1, segG_mask
        STRB    R1, [R0]
		BX      LR

        END
			
