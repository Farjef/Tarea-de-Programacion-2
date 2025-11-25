

.MODEL SMALL
.STACK 100h         

.DATA
    ; definición de mensajes (cadenas terminadas en '$')
    msg_input   DB 10, 13, 'ingrese un numero (0-9): $'
    msg_equal   DB 10, 13, 'el numero es IGUAL a 5.$'
    msg_less    DB 10, 13, 'el numero es MENOR que 5.$'
    msg_greater DB 10, 13, 'el numero es MAYOR que 5.$'
    fixed_val   DB '5'      ; valor fijo para comparar

.CODE
MAIN PROC           
    MOV AX, @DATA   ; carga la dirección del segmento de datos en AX
    MOV DS, AX      ; mueve la dirección de AX al registro DS

                        ; para solicitar al usuario ingresar un número
    MOV AH, 09h         ; función 09h de INT 21h: IMPRIMIR CADENA
    LEA DX, msg_input   ; carga la dirección efectiva del mensaje en DX
    INT 21h             ; ejecuta la interrupción DOS

    MOV AH, 01h         ; función 01h de INT 21h: LEER CÁRACTER CON ECO
    INT 21h             ; el carácter leído se guarda automáticamente en AL
    
                        ; para comparar el número ingresado
    CMP AL, fixed_val   ; compara el valor en AL (input) con '5'
                        ; actualiza las banderas 

                        
    JE EsIgual          ; Jump if Equal: Salta a 'EsIgual' si AL == '5'
    JL EsMenor          ; Jump if Less: Salta a 'EsMenor' si AL < '5'
    JG EsMayor          ; Jump if Greater: Salta a 'EsMayor' si AL > '5'

    ; BLOQUES DE CÓDIGO PARA CADA CASO

EsMenor:
    MOV AH, 09h         ; prepara servicio de impresión
    LEA DX, msg_less    ; carga mensaje "Menor"
    INT 21h             ; imprime en pantalla
    JMP Salir           ; SALTO INCONDICIONAL: evita ejecutar los casos de abajo

EsMayor:
    MOV AH, 09h         ; prepara servicio de impresión
    LEA DX, msg_greater ; carga mensaje "Mayor"
    INT 21h             ; imprime en pantalla
    JMP Salir           ; SALTO INCONDICIONAL al final

EsIgual:
    MOV AH, 09h         ; prepara servicio de impresión
    LEA DX, msg_equal   ; carga mensaje "Igual"
    INT 21h             ; imprime en pantalla
    ; aquí no es necesario emplear JMP porque 'Salir' está inmediatamente abajo

                        ; FINALIZAR PROGRAMA
Salir:
    MOV AH, 4Ch     ; función 4Ch de INT 21h: terminar proceso y volver a DOS
    INT 21h         ; ejecuta la interrupción

MAIN ENDP           ; FIN DEL PROCEDIMIENTO
END MAIN            ; FIN DEL PROGRAMA

