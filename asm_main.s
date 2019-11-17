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
        ORR     R1, #255          
        STRB    R1, [R0]        
				
		LDR     R0, =P1DIR      
        LDRB    R1, [R0]
        ORR     R1, #255          
        STRB    R1, [R0]
		
		LDR     R0, =P3DIR      
        LDRB    R1, [R0]
        ORR     R1, #segC_mask          
        STRB    R1, [R0]
		
;		LDR     R0, =P2REN      ; load Dir Reg in R1
;		LDRB    R1, [R0]        ;
;		ORR     R1, FLAmask     ; set bit
;		STRB    R1, [R0]        ; store back to Dir Reg
;		
		LDR     R0, =P2OUT      ; load Dir Reg in R1
		LDRB    R1, [R0]        ;
		ORR     R1, 0x8		; set bit ---- maybe? P2.3
		STRB    R1, [R0]        ; store back to Dir Reg



loop
        ; start in state b
		BL		state1
        
        B       loop	; repeat the loop

; STATES
;-------------------------------------------------------------------------------
state1
	BL displayB
	BL displayC
	
	B state1






; ------------------------------------------------------------------------------

; SUBROUTINES
; ------------------------------------------------------------------------------
delayMs
       
L1      SUBS    R0, #1          ; inner loop
        BNE     L1
        BX      LR

;greenON
;		LDR     R0, =P2OUT      ; load Output Data Reg in R1
;        LDRB    R1, [R0]
;        ORR     R1, #2          ; set bit 0
;        STRB    R1, [R0]        ; store back to Output Data Reg
;		BX      LR
		
		
displayB ; turn on port 2.3
		LDR     R0, =P2OUT
        LDRB    R1, [R0]
        ORR     R1, segB_mask
        STRB    R1, [R0]
		BX      LR

displayC ; turn on port 3.7
		LDR     R0, =P3OUT
        LDRB    R1, [R0]
        ORR     R1, segC_mask
        STRB    R1, [R0]
		BX      LR
		
        END
			
