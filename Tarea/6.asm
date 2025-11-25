.MODEL SMALL
.STACK 100H
.DATA
    num1    db 3      ; Definimos primer número
    num2    db 4      ; Definimos segundo número
    msgPass db 10,13, 'Resultado correcto (Suma es 7)$'
    msgFail db 10,13, 'Error en calculo$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Limpiamos registros AX y BX para asegurar pureza
    MOV AX, 0
    MOV BX, 0

    ; 1. Operaciones Aritméticas
    MOV AL, num1    ; Mover num1 (3) a AL
    ADD AL, num2    ; Sumar num2 (4) a AL.  AL = 3 + 4 = 7

    ; 2. Uso de la Pila (PUSH y POP)
    ; La pila trabaja con 16 bits, así que movemos AL a AX completo
    MOV AH, 0       ; Limpiamos parte alta
    PUSH AX         ; Guardamos el 7 en la Pila (STACK)
    
    ; Simulamos que usamos el registro AX para otra cosa (ensuciamos el registro)
    MOV AX, 9999    
    
    ; Recuperamos el valor original
    POP BX          ; Sacamos el valor de la pila y lo guardamos en BX
                    ; Ahora BX debe valer 7
                    
    ; 3. Comparación y Flujo
    CMP BL, 7       ; Comparamos si lo recuperado es 7
    JE ES_CORRECTO  ; Si es 7, salta a mensaje de éxito
    JMP ES_ERROR    ; Si no, salta a error

ES_CORRECTO:
    MOV AH, 09h
    LEA DX, msgPass
    INT 21h
    JMP FIN

ES_ERROR:
    MOV AH, 09h
    LEA DX, msgFail
    INT 21h

FIN:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
