#include "preset.h"

void read_165() {
    digitalWrite(SHPin, HIGH);
    //    newData = shiftIn(dataPin,CLKPin,MSBFIRST);
    for (uint8_t i = 0; i < 8; i++) {
        digitalWrite(CLKPin, LOW);
        digitalRead(dataPin) == 1 ? bitWrite(newData, 7 - i, 1) : bitWrite(newData, 7 - i, 0);
        digitalWrite(CLKPin, HIGH);
    }
    digitalWrite(SHPin, LOW);
}

void reboot(void) {
    noInterrupts();          // disable interrupts which could mess with changing prescaler
    CLKPR = 0b10000000;      // enable prescaler speed change
    CLKPR = 0;               // set prescaler to default (16mhz) mode required by bootloader
    void (*ptrToFunction)(); // allocate a function pointer
    ptrToFunction = 0x0000;  // set function pointer to bootloader reset vector
    (*ptrToFunction)();      // jump to reset, which bounces in to bootloader
}

void keyUpdated() {
    // if (newData == keyBind[0]) { // optional key binding for restarting the keypad
    //     for (uint8_t i = 0; i < LED_COUNT; i++) {
    //         midi.sendNoteOff(keyMap[i][0], keyMap[i][1], keyMap[i][2]);
    //     }
    //     (*keyBindKMAP[0])();
    // }
    for (uint8_t i = 0; i < LED_COUNT; i++) {
        if (bitRead(preData xor newData, i) && bitRead(newData, i)) { // check if there has a key is pressed
            midi.sendNoteOn(keyMap[i][0], keyMap[i][1], keyMap[i][2]);
            holdingIndex = i;
            theaterChaseDelay = delayTheshold - 1;
        } else if (bitRead(preData xor newData, i) && !bitRead(newData, i)) {
            midi.sendNoteOff(keyMap[i][0], keyMap[i][1], keyMap[i][2]);
        }
    }

    if (newData == 0) {
        holdingIndex = 7;
        theaterChaseDelay = delayTheshold - 1;
    }
}

/*
const byte keyBind [][4] = {{0,1,4,5},{5,1}};
keyBind[1][0] = 5
keyBind[1][1] = 1
keyBind[1][2] = 0
keyBind[1][3] = 0

DigiKeyboard.println(keyBindKMAP[1] == NULL); // 1
DigiKeyboard.println(keyBindKMAP[0] == reboot); // 1


*/