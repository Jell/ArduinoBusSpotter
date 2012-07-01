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

Client client("jawaninja.com", 1234);

void setup() {
  WiFly.begin();
  WiFly.end();

  LCDIoInit();
  LCDInit();
  LCDClear(BLUE);
  LCDPutString("Connecting", 1,1, GREEN, BLUE);
  start_connection();
  start_client();
}

int posx = 1;
int posy = 50;
void loop() {
  if (client.available()) {
    char c = client.read();
    if (c == '*') {
      // Ignore noise from closing connection
      while (client.read() != '*') {}
    } else if (c == '\r') {
      posx = 1;
    } else if (c == '\n') {
      posx = 1;
      posy += 16;
    } else {
      WiFly.end();
      if (posy < 132) {
        LCDPutChar(c, posx, posy, BLACK, BLUE);
      }
      posx += 8;
      if (posx >= 126) {
        posx = 1;
        posy += 16;
      }
      WiFly.restore();
    }
  }

  if (!client.connected()) {
    client.stop();
    WiFly.end();
    LCDPutString("Disconnected", 1, 1, RED, BLUE);
    WiFly.restore();
    posx = 1;
    posy = 50;
    delay(10000);
    start_client();
  }
}

void start_connection ()
{
  WiFly.restore();
  while (!WiFly.join(ssid, passphrase)) {
    WiFly.end();
    LCDPutString("Failed     ", 1, 1, RED, BLUE);
    WiFly.restore();
  }
}

void start_client()
{
  WiFly.end();
  LCDPutString("Connecting  ", 1,1, GREEN, BLUE);
  WiFly.restore();
  if (client.connect()) {
    client.println("test");
    WiFly.end();
    LCDPutString("Connected  ", 1, 1, GREEN, BLUE);
  } else {
    WiFly.end();
    LCDPutString("Failed     ", 1, 1, RED, BLUE);
    delay(1000);
  }
  WiFly.restore();
}
