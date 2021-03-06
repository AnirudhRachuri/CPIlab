cpu "8085.tbl"
hof "int8"

org 9000h

INPUT: EQU 8000H
PORTA: EQU 40H
PORTB: EQU 41H

;initialize the DAC
MVI A,80H
OUT 43H
;;

LDA INPUT
DCR A
JZ SQUARE
DCR A
JZ TRIANGLE
DCR A
JZ SAWTOOTH
DCR A
JZ STAIRCASE
DCR A
JZ SYMMETRICALSTAIRCASE
JMP DEAD

;;SQUARE WAVE FORM;;
SQUARE: NOP
MVI A,00H
MVI B, A

SQLOOP1: NOP
MVI D, A
MVI B, A
OUT PORTA
MVI A, D
OUT PORTB
INR A
CPI 0FFH
JNZ SQLOOP1

MVI B, A
MVI A, 00H

SQLOOP2: NOP
OUT PORTA
MVI D, A
MVI A, B
OUT PORTB
MVI A, D
INR A
CPI 0FFH
JNZ SQLOOP2

MVI B, A

SQLOOP3: NOP
MVI D, A
MVI A, B
OUT PORTA
MVI D, A
OUT PORTB
DCR A
JNZ SQLOOP3

MVI A, 00H
MVI B, A

SQLOOP4: NOP
OUT PORTA
MVI D, A
MVI A, B
OUT PORTB
MVI A, D
INR A
CPI 0FFH
JNZ SQLOOP4

JMP SQLOOP1
;;;;

;;TRIANGULAR WAVE FORM;;
TRIANGLE: NOP
MVI A,00H

TRLOOP1: NOP
OUT PORTA
OUT PORTB
INR A
CPI 0FFH
JNZ TRLOOP1

TRLOOP2: NOP
OUT PORTA
OUT PORTB
DCR A
JNZ TRLOOP2

JMP TRLOOP1
;;;;

;;SAWTOOTH WAVE FORM;;
SAWTOOTH: NOP
MVI A,00H

SALOOP1: NOP
OUT PORTA
OUT PORTB
INR A
CPI 0FFH
JNZ SALOOP1

MVI B, A

SALOOP2: NOP
MVI D, A
MVI A, B
OUT PORTA
MVI A, D
OUT PORTB
DCR A
JNZ SALOOP2

JMP SALOOP1
;;;;

;;STAIRCASE WAVE FORM;;
; using 3 steps staircase function
; steps = 55H, AAH, FFH
STAIRCASE: NOP 
MVI C,00H ;for x
MVI E,55H ;for y
STLOOP1: NOP 
MOV A,C
OUT PORTA
MOV A,E
OUT PORTB
INR C
MOV A,C
CMP E
JZ STSETCE1

STSETCE1: NOP
CPI 0FFH
JZ STRESETC
MOV C,A
STSETCE2: NOP
MOV A,E
CPI 0FFH
JZ STRESETE
STSETCE3: NOP
ADI 055H
MOV E,A
JMP STLOOP1

STRESETC: NOP
MOV A,00H
JMP STSETCE2
STRESETE: NOP
MOV A,00H
JMP STSETCE3
;;;

;;SYMMETRICAL WAVE FORM;;
; using 3 step staircase function
; steps = 55H, AAH, FFH
SYMMETRICALSTAIRCASE: NOP
;;;;

DEAD: NOP
MOV A,00H
OUT PORTA
OUT PORTB
JMP DEAD

