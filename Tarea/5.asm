.MODEL SMALL
.STACK 100H
.DATA
    mensaje db 'HOLA MUNDO EN AZUL$' ; Mensaje a mostrar

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 1. Limpiar pantalla y cambiar color (INT 10h, Servicio 06h)
    ; AH = 06h (Scroll up function)
    ; AL = 00h (Pantalla completa)
    ; BH = 1Eh (Atributo de color: Fondo Azul(1) + Texto Amarillo(E))
    ; CX = 0000h (Esquina superior izquierda fila 0, col 0)
    ; DX = 184Fh (Esquina inferior derecha fila 24, col 79)
    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 1Eh     ; 1 (Azul) para fondo, E (Amarillo) para texto
    MOV CX, 0000h
    MOV DX, 184Fh
    INT 10h

    ; 2. Posicionar Cursor en el centro (INT 10h, Servicio 02h)
    ; Una pantalla estándar es 80 columnas x 25 filas
    ; Centro aprox: Fila 12 (0Ch), Columna 35 (23h)
    MOV AH, 02h     ; Servicio posicionar cursor
    MOV BH, 00h     ; Página de video 0
    MOV DH, 12      ; Fila (Row)
    MOV DL, 35      ; Columna (Column)
    INT 10h

    ; 3. Mostrar Mensaje (Usando DOS INT 21h para facilitar impresión)
    MOV AH, 09h
    LEA DX, mensaje
    INT 21h

    ; Pausa para ver el resultado antes de salir
    MOV AH, 01h     ; Esperar una tecla
    INT 21h

    ; Salir
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
