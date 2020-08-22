#ifndef KEYMAP_H
#define KEYMAP_H
#include "additionKey.h"
extern void reboot();
const byte keyMap[6][2] = {{KEY_X, MOD_CONTROL_LEFT}, {KEY_V, MOD_CONTROL_LEFT}, {KEY_DELETE_FORWARD, MOD_SHIFT_LEFT}, {0, MOD_CONTROL_LEFT}, {KEY_C, MOD_CONTROL_LEFT}, {KEY_V, MOD_CONTROL_LEFT}};
const byte keyBind[] = {B00110011, B00010001, B00001001}; // key map mask
extern void (*keyBindKMAP[sizeof(keyBind)])(){reboot, NULL};// the compiler will occurs an error when the mapped function too much compare with the given key bind sets
bool oneKeyOnly = false;
bool waitRelease = false;
#endif
