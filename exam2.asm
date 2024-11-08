    .ORIG   x3000

; Name: Lonoehu Wacasey

; EXAM 2 [20 points]: 
; Write a program in the LC-3 assembly language, starting at x3000, that determines whether 
; a null-terminated array of 8-bit unsigned, positive integers is sorted in ascending order. 
; If the array is sorted, store the length of the array into memory location xE306. 
; If it is not sorted, store the first unsorted element into memory location xE306. 

; For instance, if the array is [2, 3, 5, 8] store x0004 into memory location xE306, 
; but if the array is [2, 5, 3, 8] store x0003 into memory location xE306.

; You can assume that no two elements of the array will be equal.

; The array starts at x4000. 
; Each array element has the 8-bit positive integer in bits [7:0] and zeroes in bits [15:8]. 
; An empty array is classified as sorted in which case you will need to store x0000 into memory location xE306.

AND R6, R6, #0
LD R0, PTR
LDR R1, R0, #0
BRZ NOELE
JSR ARRAYCNTR
LD R0, PTR
BR LOOP

ARRAYCNTR
    ADD R6, R6, #1
    ADD R0, R0, #1
    LDR R1, R0, #0
    BRZ CNTRE
    BR ARRAYCNTR
    
CNTRE
    ST R6, NUMELE
    ADD R6, R6, #-1
    RET


LOOP
    LDR R1, R0, #0
    LDR R2, R0, #1
    NOT R2, R2
    ADD R2, R2, #1
    ADD R3, R2, R1
    BRN GDARR
    BR WRONG
    
WRONG
    LD R0, STOREPTR
    STR R2, R0, #0
    BR DONE
    
GDARR
    ADD R0, R0, #1
    ADD R6, R6, #-1
    BRZ ARRAYDN
    BR LOOP
    
ARRAYDN
    LD R6, NUMELE
    LD R0, STOREPTR
    STR R6, R0, #0
    BR DONE



NOELE
    LD R0, STOREPTR
    STR R6, R0, #0
    BR DONE
    
    
DONE
    HALT

PTR .FILL x4000
STOREPTR .FILL xE306
NUMELE  .BLKW x1

    .END
    