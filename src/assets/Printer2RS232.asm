;----------------------------------------------------------------------------------------------------------------------
;
; Shinshu-Seiki Model 102 printer simulation with PIC18F2585 (used for Busicom 141PF Replica)
;
;
;                             -----------------------
;          +5V ----/\/\/\--- -|-RES      U   PGD/RB7|-      index signal output
;                    PH01    -|RA0           PGC/RB6|-      sector signal output
;                    PH02    -|RA1           PGM/RB5|-      PH11
;                    PH03    -|RA2               RB4|-      PH10
;                    PH04    -|RA3               RB3|-      PH09
;                    PH05    -|RA4               RB2|-      red ink input (not used)
;                    PH06    -|RA5          INT1/RB1|-      feed input
;                     GND    -|GND          INT0/RB0|-      manual feed input (not used)
;                    PH08    -|RA7/OSC1          VDD|-      +5V
;                    PH07    -|RA6/OSC2          GND|-      GND
;                    PH12    -|RC0            RX/RC7|-      RX (not used)
;                    PH13    -|RC1            TX/RC6|-      TX
;                    PH14    -|RC2           SDO/RC5|-      PH18
;                    PH15    -|RC3/SCL       SDA/RC4|-      PH17
;                             -----------------------
;
;Function:
;	- sector signal is 10 msec low and 18 msec high at RB6
;	- index signal is 28 msec high and 12*28 msec low (periodicity=13*28=364ms) at RB7
;	- timer0 generates interrupt around at every msec, which is used for sector & index signal
;	- firing hammers puts the character codes into internal buffer at 0x0020-0x0034
;	- feed signal copies the hammer buffer into RS232 transmit buffer at 0x0040-0x0055
;	- RS232 transmission goes on 9600 Baud 8N1 protocol
;
;shape of sector and index signal (with internal phase numbers):
;
;     0     1     2     3     4     5     6     7     8     9    10    11    12     0     1     2
;__  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____  ____
;  __    __    __    __    __    __    __    __    __    __    __    __    __    __    __    __
;
;  ______                                                                        ______
;__      ________________________________________________________________________      ____________
;
;
;Required configuration:
;	- internal 8 MHz RC oscillator is used
;	- watch dog timer is on
;	- analog functions are disabled
;----------------------------------------------------------------------------------------------------------------------

#include	<P18F2585.INC>

	CONFIG  OSC	= IRCIO67
	CONFIG  FCMEN	= OFF
	CONFIG	IESO	= OFF
	CONFIG	PWRT	= OFF
	CONFIG	BOREN	= OFF
	CONFIG	BORV	= 3
	CONFIG	WDT	= ON
	CONFIG	WDTPS	= 32768
	CONFIG	MCLRE	= ON
	CONFIG	LPT1OSC	= OFF
	CONFIG	PBADEN	= OFF
	CONFIG	DEBUG	= OFF
	CONFIG	XINST	= OFF
	CONFIG	BBSIZ	= 1024
	CONFIG	LVP	= OFF
	CONFIG	STVREN	= OFF
	CONFIG	CP0	= OFF
	CONFIG	CP1	= OFF
	CONFIG	CP2	= OFF
	CONFIG	CPB	= OFF
	CONFIG	CPD	= OFF
	CONFIG	WRT0	= OFF
	CONFIG	WRT1	= OFF
	CONFIG	WRT2	= OFF
	CONFIG	WRTB	= OFF
	CONFIG	WRTC	= OFF
	CONFIG	WRTD	= OFF
	CONFIG	EBTR0	= OFF
	CONFIG	EBTR1	= OFF
	CONFIG	EBTR2	= OFF
	CONFIG	EBTRB	= OFF


#define	VERSION	"V0.01"

		radix	dec

#define	REGMODE		0x01
#define	SECTORACTIVE	REGMODE,0
#define	TXBUSY		REGMODE,1
#define	PREVFEED	REGMODE,2

#define	SECTORTIMER	0x02
#define	INDEXTIMER	0x03
#define	SECTORVALUE	0x05	
#define	PORTABUFFER	0x07
#define	PORTBBUFFER	0x08
#define	PORTCBUFFER	0x09

#define	BUF_HAMMER01	0x20
#define	BUF_HAMMER02	0x21
#define	BUF_HAMMER03	0x22
#define	BUF_HAMMER04	0x23
#define	BUF_HAMMER05	0x24
#define	BUF_HAMMER06	0x25
#define	BUF_HAMMER07	0x26
#define	BUF_HAMMER08	0x27
#define	BUF_HAMMER09	0x28
#define	BUF_HAMMER10	0x29
#define	BUF_HAMMER11	0x2A
#define	BUF_HAMMER12	0x2B
#define	BUF_HAMMER13	0x2C
#define	BUF_HAMMER14	0x2D
#define	BUF_HAMMER15	0x2E
#define	BUF_HAMMER16	0x2F
#define	BUF_HAMMER17A	0x30
#define	BUF_HAMMER17B	0x31
#define	BUF_HAMMER18A	0x32
#define	BUF_HAMMER18B	0x33

#define	TXBUFFER	0x40
#define	TXBUFLEN	0x14

#define	SECTOR		LATB,6
#define	INDEX		LATB,7
#define	FEED		PORTBBUFFER,1

		org     0
		bra	Init
	
;----------------------------------------------------------------------------------------------------------------------
;	Interrupt: generates the sector and index signals
;----------------------------------------------------------------------------------------------------------------------
		org     0x0008
		bra	it_ix1

		org     0x0018

it_ix1:		clrwdt

		btfss	INTCON,TMR0IF		; timer0 overflow? (occurs at every millisec)
		bra	it_ixe
		bcf	INTCON,TMR0IF

		decfsz	SECTORTIMER,f
		bra	it_ixe
	
		btfsc	SECTORACTIVE
		bra	it_ix2
	
		bcf	INDEX			; sector signal becomes active
		bcf	SECTOR
		movlw	10
		movwf	SECTORTIMER
		bsf	SECTORACTIVE
	
		decfsz	INDEXTIMER,f
		bra	it_ixe
	
		bsf	INDEX
		movlw	.13
		movwf	INDEXTIMER
		bra	it_ixe

it_ix2:		bsf	SECTOR			; sector signal becomes inactive
		bcf	SECTORACTIVE
		movlw	.18
		movwf	SECTORTIMER

		movf	INDEXTIMER,w		; convert index timer to sector value
		xorlw	0xFF			; (delayed to index timer)
		addlw	.14
		movwf	SECTORVALUE

it_ixe:		retfie FAST

;----------------------------------------------------------------------------------------------------------------------
;	strings, and string handling functions
;----------------------------------------------------------------------------------------------------------------------

		org 0x0100

text_init:	db	0x0D,0x0D,"Shinshu-Seiki Model 102 Printer Simulation"
		db	" for Busicom 141-PF Replica " VERSION,0x0D,0x0D,0

text_col_1_15:	db	"0123456789..-"
text_col_17A:	db	"<    MM  S   "
text_col_17B:	db	">+-x/+-^=q%CR"
text_col_18A:	db	"     MM   E  "
text_col_18B:	db	"#*123+-TKExCM"

get_sect_char:	addwf	SECTORVALUE,w
		movwf	TBLPTRL
		movlw	1
		movwf	TBLPTRH
		TBLRD	*+
		movf	TABLAT,w
		return

char_out:	clrwdt
		btfss	PIR1,TXIF
		bra	char_out
		movwf	TXREG
		return

str_out:	movwf	TBLPTRL
		movlw	1
		movwf	TBLPTRH
str_1:		TBLRD	*+
		movf	TABLAT,w
		btfsc	STATUS,Z
		return
		rcall	char_out
		bra	str_1

;----------------------------------------------------------------------------------------------------------------------
;	initialization
;----------------------------------------------------------------------------------------------------------------------

Init:		clrf	OSCTUNE

		clrf	INTCON			; Disable Interrupts
		movlw	0x80
		movwf	INTCON2
		clrf	INTCON3
		
		clrf	PIE1			; Disable peripheral interrupt enable
		clrf	PIE2
		clrf	PIE3

		clrf	IPR1			; Clear Interrupt Priority
		clrf	IPR2
		clrf	IPR3
		
		bcf	RCON,IPEN

		clrf	T0CON			; Disable Timers
		clrf	T1CON
		clrf	T2CON
		clrf	T3CON

		clrf	CCP1CON			; disable capture/PWM module
		clrf	SSPCON1			; disable master serial port
		clrf	SSPCON2
		
		clrf	ADCON0			; disable analog inputs
		movlw	0x0F
		movwf	ADCON1

		movlw	0xFF			; Set initial port data
		movwf	LATA
		movwf	LATB
		movwf	LATC
		movwf	OSCCON			; OSC is 8 MHz Internal oscillator

		movlw	B'11111111'		; Setting PORTA as input
		movwf	TRISA
		movlw	B'00111111'		; Setting PORTB RB6, RB7 as output, rest are input
		movwf	TRISB
		movlw	B'10111111'		; Setting PORTC TX as output, rest are input
		movwf	TRISC

;		clrf	TRISA			; for debug only, set everything to output !!!
;		clrf	TRISB
;		clrf	TRISC

		movlw	0			; configure the serial port to 9600 8N1
		movwf	SPBRGH
		movlw	.12
		movwf	SPBRG
		movlw	B'00000000'
		movwf	BAUDCON
		movlw	B'00100000'
		movwf	TXSTA
		movlw	B'10000000'
		movwf	RCSTA

		clrf	FSR0L
		clrf	FSR0H
		clrf	FSR1H
		clrf	FSR2H
		clrf	BSR

st1:		clrf	POSTINC0		; clear memory area 0x00-0x7F
		btfss	FSR0L,7
		bra	st1

		clrf	TBLPTRU
		clrf	PCLATH
		clrf	PCLATU

		movlw	.1
		movwf	INDEXTIMER
		movwf	SECTORTIMER

		movlw	text_init & 0xFF	; init text
		rcall	str_out

		movlw	B'01000010'		; Timer0 is around 1 millisecond timer
		movwf	T0CON

		clrf	PIR1			; Clear Interrupt status
		clrf	PIR2
		clrf	PIR3
		bsf	INTCON,TMR0IE		; Enable Timer 0 Interrupts
		bsf	T0CON,TMR0ON		; Timer0 is started
		bsf	INTCON,GIE		; Enable Interrupts

		movf	PORTB,w
		movwf	PORTBBUFFER

;----------------------------------------------------------------------------------------------------------------------
;	Main Loop:
;----------------------------------------------------------------------------------------------------------------------

MainLoop:	bcf	PREVFEED		; copy previous feed input into a flag
		btfsc	FEED
		bsf	PREVFEED

		movf	PORTA,w			; Fetch ports into internal buffers
		movwf	PORTABUFFER
		movf	PORTB,w
		movwf	PORTBBUFFER
		movf	PORTC,w
		movwf	PORTCBUFFER
		
;----------------------------------------------------------------------------------------------------------------------
;	printer hammer handling
;----------------------------------------------------------------------------------------------------------------------
		movlw	text_col_1_15 & 0xFF	; fetch possible column character code for column 1-15
		rcall	get_sect_char

		btfss	PORTABUFFER,0		; copy the active hammers into the correct buffer positions
		movwf	BUF_HAMMER01
		btfss	PORTABUFFER,1
		movwf	BUF_HAMMER02
		btfss	PORTABUFFER,2
		movwf	BUF_HAMMER03
		btfss	PORTABUFFER,3
		movwf	BUF_HAMMER04
		btfss	PORTABUFFER,4
		movwf	BUF_HAMMER05
		btfss	PORTABUFFER,5
		movwf	BUF_HAMMER06
		btfss	PORTABUFFER,6
		movwf	BUF_HAMMER07
		btfss	PORTABUFFER,7
		movwf	BUF_HAMMER08
		btfss	PORTBBUFFER,3
		movwf	BUF_HAMMER09
		btfss	PORTBBUFFER,4
		movwf	BUF_HAMMER10
		btfss	PORTBBUFFER,5
		movwf	BUF_HAMMER11
		btfss	PORTCBUFFER,0
		movwf	BUF_HAMMER12
		btfss	PORTCBUFFER,1
		movwf	BUF_HAMMER13
		btfss	PORTCBUFFER,2
		movwf	BUF_HAMMER14
		btfss	PORTCBUFFER,3
		movwf	BUF_HAMMER15

		movlw	text_col_17A & 0xFF	; fetch possible column character code for column 17A
		rcall	get_sect_char

		btfss	PORTCBUFFER,4
		movwf	BUF_HAMMER17A

		movlw	text_col_17B & 0xFF	; fetch possible column character code for column 17B
		rcall	get_sect_char

		btfss	PORTCBUFFER,4
		movwf	BUF_HAMMER17B

		movlw	text_col_18A & 0xFF	; fetch possible column character code for column 18A
		rcall	get_sect_char

		btfss	PORTCBUFFER,5
		movwf	BUF_HAMMER18A

		movlw	text_col_18B & 0xFF	; fetch possible column character code for column 18B
		rcall	get_sect_char

		btfss	PORTCBUFFER,5
		movwf	BUF_HAMMER18B

;----------------------------------------------------------------------------------------------------------------------
;	serial port handling
;----------------------------------------------------------------------------------------------------------------------

		btfss	TXBUSY			; Check, if there is data to send through RS232
		bra	check_feed
		
		btfss	PIR1,TXIF		; check, if TX transmit register is empty
		bra	MainLoop

		movf	POSTDEC0,w		; fetch the next character from the TX buffer
		movwf	TXREG

		btfsc	FSR0L,6			; use FSR0 bit 6 as the loop end indicator
		bra	MainLoop
		
		bcf	TXBUSY			; mark that TX buffer became available

;----------------------------------------------------------------------------------------------------------------------
;	processing the feed input
;----------------------------------------------------------------------------------------------------------------------

check_feed:	btfsc	FEED			; check the falling edge of feed input
		bra	MainLoop
		btfss	PREVFEED
		bra	MainLoop
		
		bsf	TXBUSY			; mark that TX buffer will be busy

		clrf	FSR0H			; copy the hammer buffer into TX buffer (into reverse order)
		clrf	FSR1H
		movlw	TXBUFFER		; FSR0 = destination (first byte)
		movwf	FSR0L
		movlw	BUF_HAMMER01+TXBUFLEN-1	; FSR1 = source (last byte)
		movwf	FSR1L
		
		movlw	0x0D			; use carriage return for terminator character
		movwf	INDF0

cploop:		movf	INDF1,w			; copy loop
		btfsc	STATUS,Z
		movlw	0x20			; replace unused characters to space
		clrf	POSTDEC1		; clear the old content
		movwf	PREINC0
		btfsc	FSR1L,5			; use FSR1 bit 5 as the loop end indicator
		bra	cploop

		bra	MainLoop

;----------------------------------------------------------------------------------------------------------------------
		end
