INCLUDE Irvine32.inc

	ENTER_KEY = 13

.data
	InvalidMsg BYTE "Only digit is enable. Please enter again", 13, 10, 0
	StartMsg BYTE "Enter your Account", 13, 10, 0
		
		
.code
main PROC
		call Clrscr
		call Start

	StateA:
		MOV ebx, 0
		MOV ecx, 0
		call Getnext
		call IsDigit
		jz StateB

		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateB:				; 이전에 숫자가 입력된 상황
		call Getnext
		call IsDigit
		jz StateB

		cmp al, '-'
		je StateBtoC

		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateC:				; 이전에 '-'가 입력된 상황
		call Getnext
		cmp al, '-'
		je StateError

		call IsDigit
		jz StateCtoB

		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateBtoC:			; B에서 C로 갈 때 ebx 1 증가
		INC ebx
		jmp StateC

	StateCtoB:			; C에서 B로 갈때도 ebx 1 증가
		INC ebx
		jmp StateB

	StateError:			; 오류가 나왔을 경우, 여기서 엔터 나올때까지 무한히 입력만 받음
		INC ecx
		call Getnext
		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateEND1:			; 오류 횟수 확인
		cmp ecx, 0
		je StateEND2
		call DisplayErrorMsg
		jmp StateA

	StateEND2:			; 숫자 <-> '-' 전환 횟수 확인
		cmp ebx, 4
		je Quit
		call DisplayErrorMsg
		jmp StateA
		
	Quit:				; 종료
		call Crlf
		exit

main ENDP

Start PROC
		push edx
		mov edx, OFFSET StartMsg
		call WriteString
		pop edx
		ret
Start ENDP

Getnext PROC
		call ReadChar
		call WriteChar
		ret
Getnext ENDP

DisplayErrorMsg PROC
		push edx
		mov edx, OFFSET InvalidMsg
		call WriteString
		pop edx
		ret
DisplayErrorMsg ENDP

END main