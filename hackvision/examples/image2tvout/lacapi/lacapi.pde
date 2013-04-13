#include <TVout.h>
#include "lacapi.h"

TVout TV;

void setup() {
  TV.begin(NTSC,120,96);
  TV.bitmap(10,0,lacapi);
}

void loop() {
}
