;Fowad Sohail and Tim Catrino
;Intro to Embedded Final Project
;7 Seg Display Counter

; Output register
P1IN EQU 0x40004C00
P2IN EQU 0x40004C01
; Direction register
P1DIR EQU 0x40004C04
P2DIR EQU 0x40004C05
; Output register
P1OUT EQU 0x40004C02
P2OUT EQU 0x40004C03
; Internal enable register
P1REN EQU 0x40004C06
P2REN EQU 0x40004C07
Amask EQU 0x20 ;           A 
Bmask EQU 0x40 ;       F       B
Cmask EQU 0x80 ;           G
Dmask EQU 0x8  ;       E       C
Emask EQU 0x10 ;           D
Fmask EQU 0x40            
Gmask EQU 0x80
ROLLmask EQU 0x20
DECmask EQU 0x2
INCmask EQU 0x10
        THUMB
        AREA    |.text|, CODE, READONLY, ALIGN=2
        EXPORT  asm_main
asm_main
        ; make P1 an output port
        LDR     R0, =P1DIR        ; load Dir Reg in R1
        LDRB    R1, [R0]
        ORR     R1, DECmask       ; P1.1
        ORR     R1, INCmask       ; P1.4
        ORR     R1, ROLLmask      ; P1.5
        ORR     R1, Bmask         ; P1.6
        ORR     R1, Cmask         ; P1.7
        STRB    R1, [R0]          ; store back to Dir Reg
        
        ; make P2 an output port
        LDR     R0, =P2DIR        ; load Dir Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Dmask         ; P2.3
        ORR     R1, Emask         ; P2.4
        ORR     R1, Amask         ; P2.5
        ORR     R1, Fmask         ; P2.6
        ORR     R1, Gmask         ; P2.7
        STRB    R1, [R0]          ; store back to Dir Reg
        
        B state_zero
        
state_zero  
    ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs 
		
        BL zero    
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_one
        
        TST r1, DECmask
        BEQ.W state_F
        
        B state_zero
        LTORG
state_one
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
		
		BL one
		
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_two
        
        TST r1, DECmask
        BEQ state_zero
		
        TST r1, ROLLmask
        BNE state_zero
        
        B state_one
        LTORG
state_two
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
		
		 BL two
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_three
        
        TST r1, DECmask
        BEQ state_one
		
        TST r1, ROLLmask
        BNE state_one
        
        B state_two
        LTORG
        
state_three
        BL three
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_four
                
        TST r1, DECmask
        BEQ state_two
        
        TST r1, ROLLmask
        BNE state_two
        
        B state_three
        LTORG
state_four
        BL four
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_five
        
        TST r1, DECmask
        BEQ state_three
        
        TST r1, ROLLmask
        BNE state_three
        
        B state_four
        
state_five
        BL five
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_six
        
        TST r1, DECmask
        BEQ state_four
        
        TST r1, ROLLmask
        BNE state_four
        
        B state_five
    
state_six
        BL six
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_seven
        
        TST r1, DECmask
        BEQ state_five
		
        TST r1, ROLLmask
        BNE state_five
        
        B state_six
state_seven
        BL seven
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_eight
        
        TST r1, DECmask
        BEQ state_six
        
        TST r1, ROLLmask
        BNE state_six
        
        B state_seven
state_eight
        BL eight
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_nine
        
        TST r1, DECmask
        BEQ state_seven
        
        TST r1, ROLLmask
        BNE state_nine
        
        B state_eight
state_nine
        BL nine
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_A
        
        TST r1, DECmask
        BEQ state_eight
        
        TST r1, ROLLmask
        BNE state_A
        
        B state_nine
state_A
        BL A
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_B
        
        TST r1, DECmask
        BEQ state_nine
        
        TST r1, ROLLmask
        BNE state_B
        
        B state_A
state_B
        BL B_
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_C
        
        TST r1, DECmask
        BEQ state_A
        
        TST r1, ROLLmask
        BNE state_C
        
        B state_B
state_C
        BL C
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_D
        
        TST r1, DECmask
        BEQ state_B
        
        TST r1, ROLLmask
        BNE state_D
        
        B state_C
state_D
        BL D
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_E
        
        TST r1, DECmask
        BEQ state_C
        
        TST r1, ROLLmask
        BNE state_E
        
        B state_D
state_E
        BL E
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_F
        
        TST r1, DECmask
        BEQ state_D
        
        TST r1, ROLLmask
        BNE state_F
        
        B state_E
        LTORG
state_F
        BL F
        
        ; delay for 0.5 second
        LDR     R0, =200000
        BL      delayMs
        
        LDR r0, =P1IN
        LDRB r1, [r0]
        TST r1, INCmask
        BEQ state_zero
        
        TST r1, DECmask
        BEQ state_E
        
        TST r1, ROLLmask
        BNE state_zero
        
        B state_F
        LTORG

;;;;;;;;;;;;;;;;;  Subroutines  ;;;;;;;;;;;;;;;;;
; BIC turns on segment and ORR turns off segment
; because of negative logic
zero
        ; B and C segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        BIC     R1, Gmask
        STRB    R1, [R0]
        BX      LR
        
one
        ; B and C segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        BIC     R1, Amask
        BIC     R1, Dmask
        BIC     R1, Emask
        BIC     R1, Fmask
        BIC     R1, Gmask
        STRB    R1, [R0]
        BX      LR
two
        ; A B D E G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        BIC     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        BIC     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
three
        ; A B C D G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        BIC     R1, Emask
        BIC     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
four
        ; B C F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        BIC     R1, Amask
        BIC     R1, Dmask
        BIC     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        BX      LR
        
five
        ; A C D F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        BIC     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        BIC     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
six
        ; A C D E F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        BIC     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
seven
        ; A B C segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        BIC     R1, Dmask
        BIC     R1, Emask
        BIC     R1, Fmask
        BIC     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
eight
        ; A B C D E F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
nine
        ; A B C F G  segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        BIC     R1, Dmask
        BIC     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
A
        ; A B C E F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        BIC     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
B_
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        BIC     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        BIC     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
C
        ; A D E F segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        BIC     R1, Bmask
        BIC     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        BIC     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
D
        ; A B C D E F segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        ORR     R1, Bmask
        ORR     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        BIC     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        BIC     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
E
        ; A D E F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        BIC     R1, Bmask
        BIC     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        ORR     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
        
F
        ; A E F G segments
        LDR     R0, =P1OUT      ; load Output Data Reg in R1
        LDRB    R1, [R0]
        BIC     R1, Bmask
        BIC     R1, Cmask
        STRB    R1, [R0]        ; store back to Output Data Reg
        
        LDR     R0, =P2OUT
        ORR     R1, Amask
        BIC     R1, Dmask
        ORR     R1, Emask
        ORR     R1, Fmask
        ORR     R1, Gmask
        STRB    R1, [R0]
        
        BX      LR
; 1/2 second delay
delayMs
       
L1      SUBS    R0, #1          ; inner loop
        BNE     L1
        BX      LR
       
        END