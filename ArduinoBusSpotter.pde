//************************************************************************
//					Nokia Shield
//************************************************************************
//* Derived from code by James P. Lynch and Mark Sproul.	
//*
//*Edit History
//*		<MLS>	= Mark Sproul, msproul -at- jove.rutgers.edu
//*             <PD>   = Peter Davenport, electrifiedpete -at- gmail.com
//************************************************************************
//*	Apr  2,	2010	<MLS> I received my Color LCD Shield sku: LCD-09363 from sparkfun.
//*	Apr  2,	2010	<MLS> The code was written for WinAVR, I modified it to compile under Arduino.
//*     Aug  7, 2010    <PD> Organized code and removed unneccesary elements.
//*     Aug 23, 2010    <PD> Added LCDSetLine, LCDSetRect, and LCDPutStr.
//*     Oct 31, 2010    <PD> Added circle code from Carl Seutter and added contrast code.
//************************************************************************
//    External Component Libs


// #include "nokia_tester.h"
//    Included files
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include "WProgram.h"
#include "WiFly.h"
#include "LCD_driver.h"

byte cont = 80;  // Good center value for contrast

//************************************************************************
//					Main Code
//************************************************************************
void	setup()
{
  ioinit();           //Initialize I/O
  LCDInit();	    //Initialize the LCD
  LCDClear(GREEN);    // Clear LCD to a solid color
  LCDPutStr("Connecting...", 0, 4, ORANGE, WHITE); // Write instructions on display
  
  WiFly.begin();
  boolean success = WiFly.join("", "");

  if(success){
    
      LCDClear(BLUE);    // Clear LCD to a solid color
      LCDPutStr("Success!", 0, 4, ORANGE, WHITE); // Write instructions on display
  }else{
      LCDClear(GREEN);    // Clear LCD to a solid color
      LCDPutStr("Fail!", 0, 4, ORANGE, WHITE); // Write instructions on display
  }
}

//************************************************************************
//					Loop
//************************************************************************
void	loop()
{
  delay(100);
}
