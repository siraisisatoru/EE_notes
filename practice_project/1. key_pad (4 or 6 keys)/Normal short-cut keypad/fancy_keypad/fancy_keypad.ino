#include "preset.h"

uint8_t pixelByte[LED_COUNT+LED_COUNT+LED_COUNT];
cRGB pixels [LED_COUNT];
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
            localBrightness = brightTheshold;
        }
        DigiKeyboard.update();
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

    if (holdingIndex != 7 && !(sizeof(keyBind) == 0 || oneKeyOnly) && (waitbindingDelay < waitbindingDelayTheshold)) {
        // a key is pressed
        // the binding mask exists and allow multiple keys
        // delay counter < theshold
        // waitbindingDelay += 15;
        waitbindingDelay++;
    }

    if (waitbindingDelay >= waitbindingDelayTheshold) {
        DigiKeyboard.update();
        keyUpdated();
    }

    if (waitCounter > ternDarkTheshold) {
        // ever a long time no key press, active a empty key press to key wake up
        waitCounter = 0;
        // DigiKeyboard.sendKeyStroke(0);
        DigiKeyboard.update();
        localBrightness = darkTheshold;
    } else {
        waitCounter++;
    }
}
