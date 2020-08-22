
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
    // call when any of key is pressed / released
    if (sizeof(keyBind) == 0 || oneKeyOnly) { // press and hold until key released
        if (holdingIndex == 7) {              // no key is holding
            for (uint8_t i = 0; i < LED_COUNT; i++) {
                if (preData == 0 && bitRead(preData xor newData, i) && bitRead(newData, i)) { // check if there has a key is pressed
                    DigiKeyboard.sendKeyPress(keyMap[i][0], keyMap[i][1]);
                    holdingIndex = i;
                    theaterChaseDelay = delayTheshold - 1;
                    break;
                }
            }
        } else {                                                                                // only one key is holding
            if (bitRead(preData xor newData, holdingIndex) && bitRead(preData, holdingIndex)) { // check the holding bit
                                                                                                // do something to update the holding index
                DigiKeyboard.sendKeyPress(0);
                holdingIndex = 7;
                theaterChaseDelay = delayTheshold - 1;
            }
        }
    } else {
        // allowing multiple keys

        //  check any key pressed
        //      if one key pressed
        //          begin timer
        //  when times up
        //      check the register
        //          if single key
        //              send stroke? press and hold?
        //          if binding
        //              active the local functions
        //      wait the key up then begin the new round

        if (holdingIndex == 7) {
            // first key has been pressed
            for (uint8_t i = 0; i < LED_COUNT; i++) {
                if (preData == 0 && bitRead(preData xor newData, i) && bitRead(newData, i)) { // check if there has a key is pressed
                    // DigiKeyboard.sendKeyPress(keyMap[i][0], keyMap[i][1]);
                    holdingIndex = i;
                    theaterChaseDelay = delayTheshold - 1;
                    break;
                }
            }
            // }else if(){

        } else if (waitbindingDelay >= waitbindingDelayTheshold) { // only one key is holding
            if (!waitRelease) {
                if (newData % 2 == 0 || newData == 1) {
                    // the single key pressed
                    DigiKeyboard.sendKeyPress(keyMap[holdingIndex][0], keyMap[holdingIndex][1]);
                } else {
                    // key binding
                    for (uint8_t i = 0; i < sizeof(keyBind); i++) {
                        // check local functions
                        if (keyBind[i] == newData) {
                            if (keyBindKMAP[i] != NULL) {
                                if(keyBindKMAP[i] == reboot){
                                    drawRebootPattern();
                                    // (*LEDeffect[0])();
                                }
                                (*keyBindKMAP[i])();
                            }
                            break;
                        }
                    }
                }

                waitRelease = true;
            } else {
                // check all released
                if (newData == 0) {
                    waitRelease = false;
                    if (preData % 2 == 0 || preData == 1) {
                        DigiKeyboard.sendKeyPress(0);
                    }
                    waitbindingDelay = 0;
                    holdingIndex = 7;
                    theaterChaseDelay = delayTheshold - 1;
                }
            }
        }
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