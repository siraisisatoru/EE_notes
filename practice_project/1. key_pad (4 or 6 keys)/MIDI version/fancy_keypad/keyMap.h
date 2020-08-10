#ifndef KEYMAP_H
#define KEYMAP_H
#include "additionKey.h"
extern void reboot();
const byte keyMap[6][3] = {{37, 64, 1}, {37, 64, 2}, {38, 64, 3}, {38, 64, 4}, {40, 64, 5}, {41, 64, 6}};
const byte keyBind[] = {B00111111, B00110011};         // key map mask
extern void (*keyBindKMAP[sizeof(keyBind)])(){reboot}; // the compiler will occurs an error when the mapped function too much compare with the given key bind sets
#endif
