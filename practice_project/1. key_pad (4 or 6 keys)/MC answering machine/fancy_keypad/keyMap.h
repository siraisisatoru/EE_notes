#ifndef KEYMAP_H
#define KEYMAP_H
#include "additionKey.h"
extern void reboot();
const byte keyMap[6][2] = {{KEY_1,0}, {KEY_2,0}, {KEY_ARROW_DOWN, 0}, {KEY_ARROW_UP,0}, {KEY_3,0}, {KEY_4,0}};
const byte seckeyMap[6][2] = {{KEY_ENTER, 0}, {KEY_ENTER, 0}, {0, 0}, {0, 0}, {KEY_ENTER, 0}, {KEY_ENTER, 0}};
const byte keyBind[] = {B00110011, B00010001, B00001001}; // key map mask
extern void (*keyBindKMAP[sizeof(keyBind)])(){reboot, NULL};// the compiler will occurs an error when the mapped function too much compare with the given key bind sets
bool oneKeyOnly = true;
bool multiKeyStri = true;
bool waitRelease = false;
#endif
