//-------------------------------------------------------------------------------
// Shinshu Seiki Model-102 printer emulator and exerciser software for PIC18F2320
// Version 1.0.0, released on November 15, 2008.
// Written for CCS C compiler (http://www.ccsinfo.com/)
// Author: Tim McNerney
//-------------------------------------------------------------------------------
//
// LEGAL NOTICE, DO NOT REMOVE
// 
// Notice: This software and documentation is provided "AS IS."  There
//         is no warranty, claims of accuracy or fitness for any
//         purpose other than for education.  The authoritative version
//         of this file can be found at http://www.4004.com
//  
// You are free:
//  
// * to copy, distribute, display, and perform this work
// * to make derivative works
//  
// Under the following conditions:
//  
//   Attribution.  You must attribute the work in the manner specified
//                 by the author or licensor.
//  
//   Noncommercial. You may not use this work for commercial purposes.
//  
//   Share Alike.  If you alter, transform, or build upon this work, you
//                 may distribute the resulting work only under a
//                 license identical to this one.
//  
// * For any reuse or distribution, you must make clear to others the
//   license terms of this work.
// * Any of these conditions can be waived if you get permission from
//   the copyright holder.
//  
// Your fair use and other rights are in no way affected by the above.
// 
// This is a human-readable summary of the Legal Code (the full license)
// available at:
//
//   http://creativecommons.org/licenses/by-nc-sa/2.5/legalcode
//-------------------------------------------------------------------------------
// model-102-exerciser.c -- Exerciser for Shinshu-Seiki Model 102 printer sim
//-------------------------------------------------------------------------------

#define TEST_PC05_PIN
//#define ANSI_C_TEST
//#define TRACE

#ifdef ANSI_C_TEST
#include <stdio.h>
#else //~ANSI_C_TEST
#include <18f2320.h>
#endif // ANSI_C_TEST

#define PORTA_PC_BYTE0_MASK 0xff
#define PORTB_PC_BYTE1_MASK 0x38
#define PORTC_PC_BYTE1_MASK 0x0f
#define PORTC_PC_BYTE2_MASK 0x30

#define PORTA_PC_BYTE0_SHIFT // 0
#define PORTB_PC_BYTE1_SHIFT >> 3
#define PORTC_PC_BYTE1_SHIFT << 3
#define PORTC_PC_BYTE2_SHIFT >> 4

#define PC01_PIN     PIN_A0
#define PC02_PIN     PIN_A1
#define PC03_PIN     PIN_A2
#define PC04_PIN     PIN_A3
#define PC05_PIN     PIN_A4
#define PC06_PIN     PIN_A5
#define PC07_PIN     PIN_A6
#define PC08_PIN     PIN_A7
#define PC09_PIN     PIN_B3
#define PC10_PIN     PIN_B4
#define PC11_PIN     PIN_B5
#define PC12_PIN     PIN_C0
#define PC13_PIN     PIN_C1
#define PC14_PIN     PIN_C2
#define PC15_PIN     PIN_C3
#define PC17_PIN     PIN_C4
#define PC18_PIN     PIN_C5

#define MAN_FEED_PIN PIN_B0
#define FEED_PIN     PIN_B1
#define RED_INK_PIN  PIN_B2

#define PSYNC_PIN    PIN_B6
#define SECTOR0_PIN  PIN_B7

#define TX_PIN       PIN_C6
#define RX_PIN       PIN_C7

#ifndef ANSI_C_TEST
#fuses PUT, NOWDT, INTRC_IO, NOLVP  // power-up-timer, no Watchdog timer,
                                    // osc=Internal 8MHz, no LV prog
#use delay(clock=8000000, restart_wdt) // 8MHz
#ifdef TRACE
#use rs232(baud=9600, xmit=TX_PIN, DISABLE_INTS) // why disable ints?
#endif // TRACE
#endif // ANSI_C_TEST

// Parameters

#define PSYNC_PULSE_WIDTH_MS   4  // 2.754ms from sim + 45% margin
#define SECTOR_PERIOD_MS     100  // 10Hz guestimate (verify this)
#define SAMPLE_DELAY_MS       10  // 7ms from simulation + 42% margin
#define SAMPLE_HEAD_START      3  // Make sure we assert everything early enough
#define FEED_SECTORS           3  // swag of n sectors to wait after feed
#define N_REPS                 4  // complete line of printer output

#define STARTING_TEST_SECTOR   9  // other sector==DONT_KNOW for a while

// Constants

#define DONT_KNOW 99
#define FULL_COVERAGE 0x1fff
#define START_STATE 0
#define NEGATIVE_STATE 1
#define PRINT_STATE 2
#define FEED_STATE 3
#define IDLE_STATE 4

// Macros

#ifdef ANSI_C_TEST
  #define TEST_PUTS(c,str) puts(str)
#else //~ANSI_C_TEST
  #ifdef TRACE
    #define TEST_PUTS(c,str) putc(c)
  #else //~TRACE
    #define TEST_PUTS(c,str)
  #endif // TRACE
#endif // ANSI_C_TEST

// Globals

//unsigned char print_hammers_byte0;
//unsigned char print_hammers_byte1;
//unsigned char print_hammers_byte2;
//char line_buffer[LINE_WIDTH+1];
int sector = DONT_KNOW;
int negative = 0;
int feed_counter = 0;
int state = START_STATE;
long coverage = 0;
int start_num = 0;
char test_line[18];
int reps = 0;

// Prototypes

#ifdef ANSI_C_TEST
int main (void);
#else //~ANSI_C_TEST
void main (void);
#endif // ANSI_C_TEST
void deassert_all_stimulus (void);
void fire_hammer (int hammer);
void generate_test_line (void);
int psync_seen (void);
int sector0_seen (void);
void assert_red_ink (void);
void assert_feed (void);


// Procedures

#ifdef ANSI_C_TEST
int main (void)
#else //~ANSI_C_TEST
void main (void)
#endif // ANSI_C_TEST
{
  int i;

#ifndef ANSI_C_TEST
  output_float(TX_PIN); // do this early

  setup_oscillator(OSC_8MHZ);
  delay_ms(100);

#ifdef TEST_PC05_PIN
#use fixed_io (a_outputs=PC05_PIN)
  output_high(PC05_PIN);
  delay_ms(1);
  output_low(PC05_PIN);
  delay_ms(1);
  output_high(PC05_PIN);
  delay_ms(1);
  output_low(PC05_PIN);
  delay_ms(1);
  output_high(PC05_PIN);
#endif // TEST_PC05_PIN

  // Init port directions
  #use fast_io(a)
  #use fast_io(b)
  #use fast_io(c)
  set_tris_a(0x00); //oooo oooo
  set_tris_b(0xc0); //iioo oooo
  set_tris_c(0xc0); //iioo oooo //C6 and C7 are UART pins
#endif // ANSI_C_TEST
  
#ifdef TRACE
  puts("");
  printf("Model-102 Exerciser\r\n");
  printf(__DATE__ " " __TIME__ "\r\n");
#endif // TRACE
  
  // Init port values
  deassert_all_stimulus();

  state = START_STATE;
  sector = DONT_KNOW;
  negative = 0;
  feed_counter = 0;
  start_num = 0;
  reps = 0;

 main_loop:
  if (!psync_seen()) {
    goto main_loop;
  }

  // once we've seen PSYNC, everything has been sampled, so
  deassert_all_stimulus();

#ifndef ANSI_C_TEST
  delay_ms(SAMPLE_DELAY_MS - SAMPLE_HEAD_START);
#endif // ANSI_C_TEST

  if (sector0_seen()) {
    sector = 0;
#ifdef TRACE
    putc('0');
#endif // TRACE
  }
  else if (sector != DONT_KNOW) {
    sector++;
#ifdef ANSI_C_TEST
    printf("sector: %d\n", sector);
#endif // ANSI_C_TEST
#ifdef TRACE
    printf("%d", sector);
#endif // TRACE
  }
  else {
    TEST_PUTS('?',"sector: ???");
  }

  // FSM

  switch (state) {
  case  START_STATE:
    // nop
    TEST_PUTS('S',"START_STATE");
    state = NEGATIVE_STATE;
    break;
  case  NEGATIVE_STATE:
    TEST_PUTS('N',"NEGATIVE_STATE");
    negative = !negative;
    if (negative) {
      assert_red_ink();
    }
    // prepare for printing
    start_num++;
    if (start_num >= 13) {
      start_num = 0;
    }
    generate_test_line();
    coverage = 0;
    state = PRINT_STATE;
    break;
  case  FEED_STATE:
    TEST_PUTS('F',"FEED_STATE");
    reps++;
    assert_feed();
    feed_counter = FEED_SECTORS;
    state = IDLE_STATE;
    break;
  case  IDLE_STATE:
    TEST_PUTS('I',"IDLE_STATE");
    if (feed_counter) {
      feed_counter--;
      state = IDLE_STATE;
    }
    else {
      state = NEGATIVE_STATE;
    }
    break;
  case  PRINT_STATE:
    TEST_PUTS('P',"PRINT_STATE");
    if (coverage == FULL_COVERAGE) {
      state = FEED_STATE;
    } // else stay in this state
    else {
      for(i = 0; i<18; i++) {
        if (test_line[i] == sector) {
          fire_hammer(i+1); // cols are numbered, origin=1
        }
      }
      TEST_PUTS(' ',"");
      coverage |= (long) 1 << sector;
#ifdef TRACE
    printf("%lx,", coverage);
#endif // TRACE
    }
    break;
  }

  //if (reps < N_REPS) {
    goto main_loop;
    //}
}

void deassert_all_stimulus (void)
{
#ifdef ANSI_C_TEST
  puts("deassert");
#else //~ANSI_C_TEST
  output_a(0xff); // PC01 through PC08
  output_b(0x3e); // PC09 through PC11, FEED, RED_INK, MAN_FEED (active high)
 #ifdef TRACE
  output_high(PC12_PIN);
  output_high(PC13_PIN);
  output_high(PC14_PIN);
  output_high(PC15_PIN);
  output_high(PC17_PIN);
  output_high(PC18_PIN);
 #else //~TRACE
  output_c(0x3f); // PC12 through PC18, RX_PIN, TX_PIN
 #endif // TRACE
#endif // ANSI_C_TEST
}

void fire_hammer (int hammer)
{
#ifdef ANSI_C_TEST
  printf("h%d ", hammer);
#else //~ANSI_C_TEST
  switch (hammer) {
  case  1:
    output_low(PC01_PIN);
    break;
  case  2:
    output_low(PC02_PIN);
    break;
  case  3:
    output_low(PC03_PIN);
    break;
  case  4:
    output_low(PC04_PIN);
    break;
  case  5:
    output_low(PC05_PIN);
    break;
  case  6:
    output_low(PC06_PIN);
    break;
  case  7:
    output_low(PC07_PIN);
    break;
  case  8:
    output_low(PC08_PIN);
    break;
  case  9:
    output_low(PC09_PIN);
    break;
  case 10:
    output_low(PC10_PIN);
    break;
  case 11:
    output_low(PC11_PIN);
    break;
  case 12:
    output_low(PC12_PIN);
    break;
  case 13:
    output_low(PC13_PIN);
    break;
  case 14:
    output_low(PC14_PIN);
    break;
  case 15:
    output_low(PC15_PIN);
    break;
  case 17:
    output_low(PC17_PIN);
    break;
  case 18:
    output_low(PC18_PIN);
    break;
  default:
  }
#endif // ANSI_C_TEST
}

void generate_test_line (void)
{
  int i;
  for (i=0; i<18; i++) { // n_columns
    test_line[i] = (start_num + i)%13; // mod n_sectors
#ifdef ANSI_C_TEST
    printf("%2d ", test_line[i]);
#endif // ANSI_C_TEST
  }
  TEST_PUTS('G',"");
}

int psync_seen (void)
{
#ifdef ANSI_C_TEST
  puts("pSync");
  return 1; // no sense in waiting
#else //~ANSI_C_TEST
  return (input(PSYNC_PIN)==0); // Negative logic
#endif // ANSI_C_TEST
}

void assert_red_ink (void)
{
#ifdef ANSI_C_TEST
  puts("~~red_ink");
#else //~ANSI_C_TEST
  output_low(RED_INK_PIN);
#endif // ANSI_C_TEST
}

#ifdef ANSI_C_TEST
int test_sector = STARTING_TEST_SECTOR;
#endif // ANSI_C_TEST

int sector0_seen (void)
{
#ifdef ANSI_C_TEST
  test_sector++;
  if (test_sector>=13) {
    test_sector=0;
    puts("SECTOR0:");
    return 1;
  }
  else {
    return 0;
  }
#else //~ANSI_C_TEST
  return (input(SECTOR0_PIN)==0);
#endif // ANSI_C_TEST
}

void assert_feed (void)
{
#ifdef ANSI_C_TEST
  puts("--Feed");
#else //~ANSI_C_TEST
  output_low(FEED_PIN);
#endif // ANSI_C_TEST
}
