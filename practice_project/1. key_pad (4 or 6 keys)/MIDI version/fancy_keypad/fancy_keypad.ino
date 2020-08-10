#include "preset.h"

void setup() {
    pinMode(CLKPin, OUTPUT);
    pinMode(SHPin, OUTPUT);
    pinMode(dataPin, INPUT);
    // an additional 5 second
    midi.delay(5500);
}

void loop() {
    if (wait) {
        // waiting LED effect
        (*LEDeffect[0])();
    } else {
        // at least one key is holding
        if (localBrightness == darkTheshold) {
            localBrightness = brightTheshold;
        }
        holdingAni();
    }

    read_165();

    if (newData xor preData) { // key pressed / released
        if (localBrightness == darkTheshold) {
            localBrightness = brightTheshold;
        }

        keyUpdated();

        preData = newData;
        if (preData == 0) {
            // all key released
            theaterChaseDelay = delayTheshold - 1;
            wait = true;
        } else if (wait) {
            wait = false;
        }
        waitCounter = 0;
    }

    if (wait) {
        if (waitCounter > ternDarkTheshold) {
            // ever a long time no key press, active a empty key press to key wake up
            waitCounter = 0;
            localBrightness = darkTheshold;
        } else if (localBrightness != darkTheshold) {
            waitCounter++;
        }

    }
    midi.delay(1);//this delay function is used to keep poll the MIDI interface
}
