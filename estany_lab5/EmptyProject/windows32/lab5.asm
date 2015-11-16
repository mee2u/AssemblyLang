; name: Mena Estany	
; class: Assembly language 3160-002
; date : october 21, 2013
; Read a sequence of positive integers (16 bit) from keyboard
; until -1 is entered and store them in an array. 
; Compute the average of the numbers and change each number 
; within +/-5 of the average to the average
.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096 

.DATA 			
prompt			BYTE		"Enter a number to insert in the array/ -1 to exit",0							; porompt for user to input numbers into the array
diffAvg			WORD		?																				; to incrument the number of changed numbers
asciiInNum		BYTE    	20 DUP (?)																		; to read in every value entered into the program
myArray			WORD		20 DUP (?)																		; to declare a word size Array
average			WORD		?																				; storage to store the average of all grades/ numbers
outMsgLabel		BYTE  		"The Result is", 0																; out message label
print			BYTE		"The Average is: "																; first line of the output
ascciOutSum   	BYTE    	5 DUP (?) , 0dh, 0ah															; output the average 
Output2         BYTE		"counter for +/-5: "															; second line of the outPut
asccifinal		BYTE		5 DUP (?)																		; output the # of changed numbers 	




EXTERN			myProc: PROC

.CODE			
_MainProc	PROC
			lea edx, myArray																				; load effective array

			mov bx, 0																						; getting bx ready for the sum
			mov cx, 0																						; to make sure the count is empty
																					
myLoop:		cmp cx, 20																						; compare if the array hasnt reach the max size and loop throug it if not
			je next																							; jump to end if its all loaded
			
			input prompt, asciiInNum, 20																	; prompt for, read, and store ASCII characters
			atow asciiInNum																					; convert ASCII to 2's comp and store in EAX	
			cmp ax, -1																						; comapre if the number been entered is -1
			je next																							; exit out of the loop if its -1
			mov  [edx], ax																					; store the number into the array
			add  edx  , 2																					; move to the next word dup
			add bx, ax																						; add to get the sum
			inc cx																							; incrument cx the count of the array
			jmp myLoop																						; loop back
			
next:		lea eax, diffAvg																				; pass the 4th paramter	reference								
			push eax																						; push into the stack
			lea eax, average																				; pass the 3rd paramter as reference 
			push eax																						; push into the stack 
			push cx																							; push 2nd the actual sizeof the array as value paramter	
			lea eax, myArray																				; pass the array as reference 
			push eax																						; push into the stack 
			call myProc																						; call the function 
			add esp, 14																						; to change the esp value to the orignal 

final:		wtoa ascciOutSum, average																		; store ascii from average to out put
			wtoa asccifinal, diffAvg																		; store ascii from diffAvg to output
				

			output  	outMsgLabel, print	
       		mov     	eax, 0  																			; exit with return code 0
        		ret
_MainProc 		ENDP						
				END  