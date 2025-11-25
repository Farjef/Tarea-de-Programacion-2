; Define el modelo de memoria (SMALL: un segmento de código, un segmento de datos)
.MODEL SMALL
; Define el tamaño de la pila (Stack)
.STACK 100h

; --- INICIO DEL SEGMENTO DE DATOS ---
.DATA
    ; 1. Definición de variables inicializadas
    VALOR1          DW  1500h       ; Variable de tipo Palabra (2 bytes)
    VALOR2          DW  0A00h       ; Variable de tipo Palabra (2 bytes)

    ; 2. Definición de variables de resultado (sin inicializar)
    RESULTADO_SUMA  DW  ?           ; '?' reserva espacio (2 bytes)
    RESULTADO_RESTA DW  ?           ; '?' reserva espacio (2 bytes)

; --- INICIO DEL SEGMENTO DE CÓDIGO ---
.CODE
INICIO:
    ; --- Configuración Inicial (Boilerplate) ---
    MOV AX, @DATA       ; Carga la dirección del segmento .DATA en AX
    MOV DS, AX          ; Mueve esa dirección al registro DS

    ; --- 3. Suma (VALOR1 + VALOR2) ---
    MOV AX, VALOR1          ; 1. Carga el valor de VALOR1 (1500h) en el registro AX
    ADD AX, VALOR2          ; 2. Suma el valor de VALOR2 (0A00h) a AX
                            ;    (AX ahora contiene 1500h + 0A00h = 1F00h)
    MOV RESULTADO_SUMA, AX  ; 3. Almacena el resultado (1F00h) en la variable

    ; --- 4. Resta (VALOR1 - VALOR2) ---
    MOV AX, VALOR1          ; 1. Carga el valor de VALOR1 (1500h) en AX (lo recargamos)
    SUB AX, VALOR2          ; 2. Resta el valor de VALOR2 (0A00h) de AX
                            ;    (AX ahora contiene 1500h - 0A00h = 0B00h)
    MOV RESULTADO_RESTA, AX ; 3. Almacena el resultado (0B00h) en la variable

    ; --- Fin del Programa ---
    ; Usamos la interrupción INT 3 (Breakpoint) para detener el programa
    ; dentro de DEBUG y poder revisar la memoria cómodamente.
    INT 3

END INICIO