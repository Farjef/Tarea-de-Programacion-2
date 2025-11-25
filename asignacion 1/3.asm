; Define el modelo de memoria
.MODEL SMALL
; Define el tamaño de la pila (Stack)
.STACK 100h

; --- INICIO DEL SEGMENTO DE DATOS ---
.DATA
    ; 1. Variable de 1 byte (DB) para contar
    CONTADOR    DB  0
    ; 2. Variable de 2 bytes (DW) con el total de vueltas
    ITERACIONES DW  50

; --- INICIO DEL SEGMENTO DE CÓDIGO ---
.CODE
INICIO:
    ; --- Configuración Inicial (Boilerplate) ---
    MOV AX, @DATA
    MOV DS, AX

    ; --- 3. Preparar el Bucle ---
    ; La instrucción LOOP SIEMPRE usa el registro CX como su contador.
    ; Cargamos el valor de ITERACIONES (50 decimal) en CX.
    MOV CX, ITERACIONES     ; CX ahora vale 50 (o 32h)

    ; --- 4. Inicializar AX ---
    ; Inicializamos AX al valor 100 (decimal)
    MOV AX, 100             ; AX ahora vale 100 (o 64h)

    ; Etiqueta de inicio del bucle
    MI_BUCLE:
        ; --- 4.a. Incrementar CONTADOR ---
        ; Esta instrucción opera directamente sobre la memoria
        INC CONTADOR        ; CONTADOR = CONTADOR + 1

        ; --- 4.b. Decrementar AX ---
        DEC AX              ; AX = AX - 1

        ; --- 3. Instrucción LOOP ---
        ; Esta instrucción hace dos cosas a la vez:
        ; 1. Decrementa CX (CX = CX - 1)
        ; 2. Si CX NO es cero, salta automáticamente a la etiqueta MI_BUCLE
        LOOP MI_BUCLE

    ; --- Fin del Programa ---
    ; Cuando CX llega a 0, el bucle termina y el código sigue aquí.
    ; Ponemos el breakpoint para revisar todo en DEBUG
    INT 3

END INICIO