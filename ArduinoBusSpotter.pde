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


byte server[] = { 66, 249, 89, 104 }; // Google

//Client client(server, 80);

Client client("google.com", 80);

void setup() {
  Serial.begin(9600);

  WiFly.begin();

  WiFly.end();

  LCDIoInit();
  LCDInit();
  LCDClear(BLUE);
  LCDPutString("Connecting...", 1,1, GREEN, BLUE);

  WiFly.restore();
  if (!WiFly.join(ssid, passphrase)) {
    WiFly.end();
    LCDDrawRectangle(1,1,100,10, RED);
    while (1) {
      // Hang on failure.
    }
  }

  if (client.connect()) {
    client.println("HEAD /search?q=arduino HTTP/1.0");
    client.println();
    WiFly.end();
    LCDPutString("Connected!", 1,17, GREEN, BLUE);
    WiFly.restore();

  } else {
    WiFly.end();
    LCDPutString("Failed!", 1,21, RED, BLUE);
    WiFly.restore();
  }

}

int posx = 1;
int posy = 33;
void loop() {
  if (client.available()) {
    char c = client.read();
    WiFly.end();
    if (posy < 132)
      LCDPutChar(c, posx, posy, BLACK, BLUE);
    posx += 8;
    if (posx >= 126) {
      posx = 1;
      posy += 16;
    }
    WiFly.restore();
  }

  if (!client.connected()) {
    client.stop();
    for(;;)
      ;
  }
}
