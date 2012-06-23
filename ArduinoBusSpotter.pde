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
#include "credentials.h"

void	setup()
{
  WiFly.begin();
  delay(2000);
  WiFly.end();

  LCDIoInit();
  LCDInit();
  LCDClear(BLUE);
  LCDPutString("Connecting...", 1, 1, BLACK, BLUE);

  WiFly.restore();
  boolean success = WiFly.join(wifi_login, wifi_password);
  WiFly.end();

  if(success){
    LCDPutString("Success!", 1, 20, GREEN, BLUE);
  }else{
    LCDPutString("Fail!", 0, 20, RED, BLUE);
  }
}

void	loop()
{
  delay(100);
}
