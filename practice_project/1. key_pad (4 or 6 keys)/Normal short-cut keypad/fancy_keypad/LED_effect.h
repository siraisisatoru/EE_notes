#ifndef LED_EFFECT_H
#define LED_EFFECT_H
#include "keyMap.h"
extern void theaterChase();
extern void rainbowUpdate();
extern void (*LEDeffect[])(){rainbowUpdate,theaterChase,theaterChase,theaterChase,theaterChase,theaterChase,theaterChase};
extern void (*bindgingLEDeffect[sizeof(keyBind)])(){rainbowUpdate,theaterChase,theaterChase};
cRGB LESSCOLOR[7] = {(cRGB){63, 51, 163}, (cRGB){0, 255, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}};
cRGB MORECOLOR[7] = {(cRGB){89, 167, 47}, (cRGB){255, 255, 255}, (cRGB){255,255,255}, (cRGB){255,255,255}, (cRGB){255,255,255}, (cRGB){255,255,255}, (cRGB){255,255,255}};
cRGB rebootPattern[6] = {(cRGB){63, 51, 163}, (cRGB){0, 255, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}};
#endif
