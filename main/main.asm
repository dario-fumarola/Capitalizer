; Dario Fumarola


;PSEUDOCODE

;While get keyboard input
	; if lf return char
		;exit label
	;if cr return char
		;exit label
	;store char in array
	;point register to next array address
;exit label
	;display array and its strings

;load array address to register
;load first value
	;if lowercase
	    ;capitalize
;display array


;Registers

;R1: negate return char
;R2: base address array
;R3: temp working register
;R4: case-check
;R5: capitalize
;R6: negate return char


.ORIG x3000

LEA R0 PROMPT    ;prompt name
PUTS             ;display prompt
LD  R1,RT        ;initialize return char
LEA R2,NAME      ;get base address of array
LD  R6,CR        ;Initialize cr return key


LOOP1	GETC     ;read and mimic char from RO
	OUT

	ADD R3,R0,R1   ;Quit if char return
	BRz END1

        AND R3,R3,#0    ;Clear temp
        ADD R3,R0,R6    ;Quit if char return 
        BRZ END1


        
	STR R0,R2,#0    ;store char in array
	ADD R2,R2,#1    ;increment address of array cell

	BR LOOP1        ;read following char

END1	 

	LEA R0,THANKS   ;Thank you message
	PUTS

	LEA R0,NAME     ;display lc name
	PUTS

	LEA R0,EXCLAM    ;display new line and uppercase
	PUTS

	LD R4,CASECHECK   ;initialize casecheck
	LD R5,CAPITALIZE  ; initialize capitalize
	LEA R2,NAME       ; get base address from string

CHLOOP  LDR R0,R2,#0      ;Get next character from string
	BRz DONE          ;Quit if null

	ADD R3,R0,R4      ;Add casechecker for uc
	BRn OUTPUT        ;If result was negative, char already negative
	ADD R0,R0,R5      ;Else, add capitalize to the char

OUTPUT  OUT
	ADD R2,R2,#1      ;Increment char address
	BR CHLOOP         ;Loop to next char

DONE    HALT


NAME	.BLKW #30         ;Array for name, 30 blocks

RT	.FILL x-000A      ;LF return negated char
CR      .FILL #-13        ;CR return negated char

PROMPT	.STRINGZ "Please enter your name > "   ;prompt string
THANKS  .STRINGZ "Thank you, "                 ;'thankyou' string
EXCLAM	.STRINGZ  "!\nYour name in upper-case is " ; string for new line and uc message
CASECHECK .FILL  #-97 ;casecheck
CAPITALIZE .FILL #-32 ;capitalize

.END