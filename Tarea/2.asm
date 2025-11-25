; Define el modelo de memoria
.MODEL SMALL
; Define el tamaño de la pila (Stack)
.STACK 100h

; --- INICIO DEL SEGMENTO DE DATOS ---
.DATA
    ; 1.
    DATO_ORIGINAL   DW  0ABCDh      ; Valor inicial
    ; 2.
    DATO_RECUPERADO DW  ?           ; Variable sin inicializar
    ; 5.
    MI_CADENA       DB  'Lenguaje Ensamblador'

; --- INICIO DEL SEGMENTO DE CÓDIGO ---
.CODE
INICIO:
    ; --- Configuración Inicial (Boilerplate) ---
    MOV AX, @DATA
    MOV DS, AX

    ; --- 3. Apilar DATO_ORIGINAL ---
    ; Se toma el valor (0ABCDh) de la variable DATO_ORIGINAL
    ; y se guarda en la Pila (Stack).
    PUSH [DATO_ORIGINAL]

    ; --- 4. Desapilar en DATO_RECUPERADO ---
    ; Se saca el último valor de la Pila (0ABCDh)
    ; y se guarda en la variable DATO_RECUPERADO.
    POP [DATO_RECUPERADO]

    ; --- 6. Cargar la dirección de MI_CADENA ---
    ; LEA = Load Effective Address
    ; Carga el *offset* (la dirección) de MI_CADENA
    ; en el registro BX. No carga el contenido ('L', 'e', 'n'...).
    LEA BX, MI_CADENA

    ; --- Fin del Programa ---
    ; Ponemos el breakpoint para revisar todo en DEBUG
    INT 3

END INICIO