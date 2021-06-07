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

	StateB:				; ������ ���ڰ� �Էµ� ��Ȳ
		call Getnext
		call IsDigit
		jz StateB

		cmp al, '-'
		je StateBtoC

		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateC:				; ������ '-'�� �Էµ� ��Ȳ
		call Getnext
		cmp al, '-'
		je StateError

		call IsDigit
		jz StateCtoB

		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateBtoC:			; B���� C�� �� �� ebx 1 ����
		INC ebx
		jmp StateC

	StateCtoB:			; C���� B�� ������ ebx 1 ����
		INC ebx
		jmp StateB

	StateError:			; ������ ������ ���, ���⼭ ���� ���ö����� ������ �Է¸� ����
		INC ecx
		call Getnext
		cmp al, ENTER_KEY
		je StateEND1
		jmp StateError

	StateEND1:			; ���� Ƚ�� Ȯ��
		cmp ecx, 0
		je StateEND2
		call DisplayErrorMsg
		jmp StateA

	StateEND2:			; ���� <-> '-' ��ȯ Ƚ�� Ȯ��
		cmp ebx, 4
		je Quit
		call DisplayErrorMsg
		jmp StateA
		
	Quit:				; ����
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