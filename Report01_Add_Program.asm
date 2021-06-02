INCLUDE Irvine32.inc

.data
		num1 DWORD 2020d
		num2 DWORD 1672d
		num3 DWORD 0521d

.code
main PROC
		MOV eax, [num1]
		ADD eax, [num2]
		ADD eax, [num3]
		
		call WriteDec

main ENDP

END main