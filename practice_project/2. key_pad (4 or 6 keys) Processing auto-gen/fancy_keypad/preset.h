#ifndef PRESET_H
#define PRESET_H

#include "DigiKeyboard.h"
#include <Arduino.h>
#include "ledLib.h"
#include "LED_effect.h"
#include "keyMap.h"

#define LED_PIN _BV(PB5)
// #define LED_COUNT 4
#define LED_COUNT 6

#define CLKPin 0
#define SHPin 1
#define dataPin 2

const uint16_t ternDarkTheshold = 60000;
const uint8_t brightTheshold = 100;
const uint8_t darkTheshold = 15;

// #define localBrightness 100
uint8_t localBrightness = 100;

byte preData = 0;
byte newData = 0;
bool wait = true;

uint16_t waitCounter = 0;

uint8_t theaterChaseIndex = 0;
uint16_t theaterChaseDelay = 0;
const uint16_t delayTheshold = 1500;

uint16_t rainbowUpdateIndex = 0;
uint16_t rainbowDelay = 0;
const uint16_t rainbowdelayTheshold = 30;

uint8_t holdingIndex = 7;

// const uint8_t waitbindingDelayTheshold = 30;
// const uint8_t waitbindingDelayTheshold = 255;
const uint16_t waitbindingDelayTheshold = 600; // snesitivity
uint16_t waitbindingDelay = 0;
bool waitBind = true;


#endif
