cpu "8085.tbl"
hof "int8"

org 9000h


MVI A,80H
OUT 43H

MVI A,00H

LOOP1: NOP
OUT 40H
OUT 41H
INR A
CPI 0FFH
JNZ LOOP1

LOOP2: NOP
OUT 40H
OUT 41H
DCR A
JNZ LOOP2

JMP LOOP1

