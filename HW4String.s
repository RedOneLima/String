MAX_LEN	EQU 100
NULL 	EQU 0

;////////////////////////////////////////////////////////////////////////////////////////////////
;	(Kyle Hewitt CS2400 HW 4 Problem B)	
;
;	This main routine will take 2 String words from memory and Byte per Byte mix them into a
;	string containing alternated bytes from each word.
;////////////////////////////////////////////////////////////////////////////////////////////////
;R0	Contains the address pointing to the first byte of StrOne
;R1	Contains the address pointing to the first byte of StrTwo
;R2	Contains the address pointing to the first byte of MixStr
;R3	Holds the next Byte to be added to MixStr from StrOne
;R4	Holds the next Byte to be added to MixStr from StrTwo
;////////////////////////////////////////////////////////////////////////////////////////////////

	AREA	HW4STRING, CODE
	ENTRY
Main
	LDR R0, =StrOne		;setting the marker to the beginning of the first string
	LDR R1, =StrTwo		;setting the marker to the beginning of the second string
	LDR R2, =MixStr		;setting the marker to the beginning of the result string

Loop
	LDRB R3,[R0], #1	;load byte from StrOne and increase index by 1
	CMP R3, #NULL		;check for terminator
	BEQ Finish_StrTwo	;branch if terminator is found on StrOne
	STRB R3, [R2], #1	;store the StrOne byte to MixedStr and increase index by 1	

	LDRB R4,[R1], #1	;load byte from StrTwo
	CMP R4,#NULL		;check for terminator
	BEQ Finish_StrOne	;branch if terminator is found on StrTwo
	STRB R4, [R2], #1	;store the StrTwo byte to MixedStr and increase index by 1

	B Loop			;Loops to take the next byte from each string	

;/////////////////////////////////////////////////////////////////////////////////////////////////

Finish_StrTwo			;this branch is reached is StrTwo is longer than StrOne
Str2_Loop
	LDRB R4,[R1], #1	;load byte from StrTwo
	CMP R4,#NULL		;check for terminator
	BEQ DONE		;reached if both strings have been itterated
	STRB R4, [R2], #1	;store the StrTwo byte to MixedStr and increase index by 1
	B Str2_Loop		;otherwise keep going

;////////////////////////////////////////////////////////////////////////////////////////////////

Finish_StrOne			;this branch is reached is StrOne is longer than StrTwo
Str1_Loop
	LDRB R3,[R0], #1		;load byte from StrOne
	CMP R3,#NULL		;check for terminator
	BEQ DONE		;reached if both strings have been itterated
	STRB R3, [R2], #1	;store the StrOne byte to MixedStr and increase index by 1
	B Str1_Loop		;otherwise keep going

;////////////////////////////////////////////////////////////////////////////////////////////////

DONE	SWI 0x11		;terminate program

;////////////////////////////////////////////////////////////////////////////////////////////////

	AREA	Data, DATA

StrOne	DCB "ACEGIK", 0
	
StrTwo	DCB "BDFHJ", 0
	
MixStr	% (MAX_LEN +1)

;////////////////////////////////////////////////////////////////////////////////////////////////	

	END
