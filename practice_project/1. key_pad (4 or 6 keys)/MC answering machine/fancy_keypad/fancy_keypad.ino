#include "preset.h"

uint8_t pixelByte[LED_COUNT + LED_COUNT + LED_COUNT];
cRGB pixels[LED_COUNT];
cRGB pressed[LED_COUNT];

void setup() {
    pinMode(CLKPin, OUTPUT);
    pinMode(SHPin, OUTPUT);
    pinMode(dataPin, INPUT);
    DigiKeyboard.sendKeyStroke(0);
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
                               // DigiKeyboard.println(newData, BIN);
        if (localBrightness == darkTheshold) {
            DigiKeyboard.sendKeyStroke(0);
            DigiKeyboard.delay(5);
            localBrightness = brightTheshold;
        }
        // DigiKeyboard.update();
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

    if (localBrightness == darkTheshold) {
        // when the keypad turn dark, auto refresh to keep active.
        if (keepOnCounter > keepOnTheshold) {
            DigiKeyboard.sendKeyStroke(0);
            keepOnCounter = 0;
        } else {
            keepOnCounter++;
        }
    }

    if (waitCounter > ternDarkTheshold && localBrightness != darkTheshold) {
        // ever a long time no key press, active a empty key press to key wake up
        localBrightness = darkTheshold;
        waitCounter = 0;
    }
    if (waitCounter > ternDarkTheshold) {
        waitCounter = 0;
        DigiKeyboard.sendKeyStroke(0);
    } else {
        waitCounter++;
    }
}
