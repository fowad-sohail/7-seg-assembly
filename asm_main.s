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

Ptwopointfour EQU 0x10 ; bitmask P2.4

TSTmask EQU 0x2 ; bitmask P1.1
ACKmask EQU 0x10; bitmask P1.4
FLAmask EQU 0x40 ; bitmask P2.6
OLAmask EQU 0x80 ; bitmask P2.7

	

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
		
		LDR     R0, =P2REN      ; load Dir Reg in R1
		LDRB    R1, [R0]        ;
		ORR     R1, FLAmask     ; set bit
		STRB    R1, [R0]        ; store back to Dir Reg
		
		LDR     R0, =P2OUT      ; load Dir Reg in R1
		LDRB    R1, [R0]        ;
		ORR     R1, FLAmask		; set bit
		STRB    R1, [R0]        ; store back to Dir Reg

loop
        ; start in state b
		BL		state0
        
        B       loop	; repeat the loop

; STATES
;-------------------------------------------------------------------------------
state0
	BL Ptwopointfour
	
	B state0






; ------------------------------------------------------------------------------

; SUBROUTINES
; ------------------------------------------------------------------------------
delayMs
       
L1      SUBS    R0, #1          ; inner loop
        BNE     L1
        BX      LR

greenON
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, #2          ; set bit 0
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR
		
		
Ptwopointfour ; P2.4
		LDR     R0, =P2OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Ptwopointfour
        STRB    R1, [R0]        ; store back to Output Data Reg
		BX      LR
		
zeroON
		
		
        END
			
