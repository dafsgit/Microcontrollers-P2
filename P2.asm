
; PIC18F4550 Configuration Bit Settings

; Assembly source line config statements

#include "p18f4550.inc"

; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = INTOSCIO_EC    ; Oscillator Selection bits (Internal oscillator, port function on RA6, EC used by USB (INTIO))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOR = ON              ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = ON              ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = ON              ; Single-Supply ICSP Enable bit (Single-Supply ICSP enabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)

;**************** Definitions*********************************
VEL EQU 0x01				;Reservar un registro temporal para la cuenta
RETARDO EQU 0x02			;Reservar un registro temporal para el retardo
MULTIPLO EQU 0x03			;Reservar un registro temporal para el múltiplo del loop
;*************************************************

    ORG 0x000				;vector de reset
    GOTO main				;goes to main program

init: 
    MOVLW	0x0F			;Puertos A, B y E pueden ser digitales (I/O) o analógicos (sólo I)
    MOVWF	ADCON1			;PORTA es analógico por default y estas dos líneas lo obligan a ser digital
    
    CLRF	TRISB			;PORTB es salida
    BSF		TRISB, 0		;RB0 es entrada
    BSF		TRISB, 1		;RB1 es entrada
    CLRF	TRISD			;PORTD es salida
    CLRF	PORTB			;Limpiar el puerto B
    CLRF	PORTD			;Limpiar el puerto D
    MOVLW	0x03
    MOVWF	VEL			;Velocidad 3 (1 segundo) por defecto.
    RETURN				;leaving initialization subroutine

main:
    CALL init				;Llamar a inicialización de puertos
    
CASE9:    
    MOVLW b'01101111'
    MOVWF PORTD
    CALL TIMER
;CASE8:
    MOVLW b'01111111'
    MOVWF PORTD
    CALL TIMER    
;CASE7:
    MOVLW b'00000111'
    MOVWF PORTD
    CALL TIMER
;CASE6:
    MOVLW b'01111101'
    MOVWF PORTD
    CALL TIMER    
;CASE5:
    MOVLW b'01101101'
    MOVWF PORTD
    CALL TIMER    
;CASE4:
    MOVLW b'01100110'
    MOVWF PORTD
    CALL TIMER    
;CASE3:
    MOVLW b'01001111'
    MOVWF PORTD
    CALL TIMER    
;CASE2:
    MOVLW b'01011011'
    MOVWF PORTD
    CALL TIMER
;CASE1:					;Si el número es 1,
    MOVLW b'00000110'			;Se mueve a WREG una literal que represente el número en el display de 7 segmentos
    MOVWF PORTD				; el orden de la salida y los segmentos debe ser: 'gfedcba', si se manda señal en ALTO, el segmento se enciende, en BAJO permanece apagado.    
    CALL TIMER				;Llama al ciclo que manejará la velocidad
;CASE0:					;Si el número es cero,
    MOVLW b'00111111'			;Se mueve a WREG una literal que represente el número en el display de 7 segmentos
    MOVWF PORTD				;Se mueve esta información a PORTD (puerto de salida al que estará conectado el display)
    CALL TIMER				;Llama al ciclo que manejará la velocidad
    GOTO CASE9				;Lleva al siguiente número, que es 9 porque la cuenta es descendente y vuelve a empezar

DEC_BUTTON:
    DECF    VEL, F
    CLRF    PORTB
    CALL MILIS_100			;tiempo de espera
    RETURN
    
INC_BUTTON:
    INCF    VEL, F
    CLRF    PORTB
    CALL MILIS_100			;tiempo de espera
    RETURN
    
TIMER:
    BTFSC PORTB, 0
    CALL DEC_BUTTON
    BTFSC PORTB, 1
    CALL INC_BUTTON
    
    MOVF VEL, W			;Mover la info del VEL (tendrá el número de velocidad) a WREG
    SUBLW 0x01				;Operación L-WREG (la literal 0x01 menos el resultado de la suma)
    BZ	MILIS_100_LED			;Si el resultado es cero, la suma es igual a la literal, entonces brinca a esa etiqueta
    
    MOVF VEL, W			;Mover la info del VEL (tendrá el número de velocidad) a WREG
    SUBLW 0x02				;Operación L-WREG (la literal 0x02 menos el número de velocidad)
    BZ 	MILIS_500			;Si el resultado es cero, la suma es igual a la literal, entonces brinca a esa etiqueta
    
    MOVF VEL, W			;Mismo caso, hasta llegar a la literal 0x05 (porque son 5 velocidades)...
    SUBLW 0x03
    BZ	SEG_1
    
    MOVF VEL, W
    SUBLW 0x04
    BZ	SEG_5
    
    MOVF VEL, W
    SUBLW 0x05
    BZ	SEG_10
    
    BRA DEFAULT			
    
DEFAULT:
    MOVLW 0x03
    MOVWF VEL
    BRA SEG_1
    

MILIS_500:
    BTG	PORTB, 4
    MOVLW 0x05			; 5*100ms = 500ms
    MOVWF MULTIPLO
LOOP_2:
    CALL MILIS_100
    DECFSZ MULTIPLO
    GOTO LOOP_2
    RETURN

SEG_1:
    BTG	PORTB, 2
    MOVLW 0x10			; 10*100ms = 1s
    MOVWF MULTIPLO
LOOP_3:
    CALL MILIS_100
    DECFSZ MULTIPLO
    GOTO LOOP_3
    RETURN
    
SEG_5:
    BTG	PORTB, 6
    MOVLW 0x32			; 50*100ms = 5s
    MOVWF MULTIPLO
LOOP_4:
    CALL MILIS_100
    DECFSZ MULTIPLO
    GOTO LOOP_4
    RETURN
    
SEG_10:
    BTG	PORTB, 7
    MOVLW 0x64			; 100*100ms = 10s
    MOVWF MULTIPLO
LOOP_5:
    CALL MILIS_100
    DECFSZ MULTIPLO
    GOTO LOOP_5
    RETURN
  
MILIS_100_LED:
    BTG	PORTB, 3
MILIS_100:
    MOVLW 0xFA			; 250*(10+97+1+2)*0.5us
    MOVWF RETARDO
LOOP:
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    ;
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    DECFSZ RETARDO
    GOTO LOOP
    RETURN
    
    END					;El programa finaliza
    
