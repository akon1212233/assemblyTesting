[org 0x7c00]

bucle_teclado:
    ; --- PASO 1: LEER UNA TECLA DEL TECLADO ---
    mov ah, 0x00        ; Función 0x00 de la INT 0x16: Esperar y leer tecla
    int 0x16            ; Interrupción de teclado de la BIOS
                        ; (La BIOS se detiene aquí hasta que presiones algo)
                        ; Al presionar, guarda el código ASCII de la letra en AL

    ; --- PASO 2: LÓGICA (¿Presionó la tecla Enter?) ---
    cmp al, 0x0D        ; 0x0D es el código ASCII para la tecla 'Enter'
    je salto_linea      ; Si presionó Enter, salta a la rutina de nueva línea

    ; --- PASO 3: PINTAR LA TECLA PRESIONADA ---
    mov ah, 0x0e        ; Función de video: Pintar carácter
    int 0x10            ; Llama a la BIOS para dibujar la letra que está en AL
    
    jmp bucle_teclado   ; Vuelve a esperar otra tecla

salto_linea:
    ; Truco de máquina de escribir: Para ir abajo necesitas un retorno de carro y nueva línea
    mov ah, 0x0e
    mov al, 0x0d        ; Retorno de carro
    int 0x10
    mov al, 0x0a        ; Nueva línea (bajar un renglón)
    int 0x10
    jmp bucle_teclado   ; Vuelve al bucle

times 510-($-$$) db 0
dw 0xaa55
