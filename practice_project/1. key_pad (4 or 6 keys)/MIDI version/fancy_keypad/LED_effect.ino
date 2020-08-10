#include "preset.h"

void rainbowUpdate() {
    cRGB localPixel;
    if (rainbowUpdateIndex < 256) {
        for (uint16_t i = 0; i < LED_COUNT; i++) {
            localPixel = Wheel(((i * 256 / LED_COUNT) + rainbowUpdateIndex) & 255);
            pixels[i] = localPixel;
            RGBtoByteArr();
            ws2812_setleds_pin(pixelByte, LED_COUNT, LED_PIN);
        }
        rainbowUpdateIndex++;
    } else {
        rainbowUpdateIndex = 0;
    }
}

cRGB Wheel(byte WheelPos) {
    WheelPos = 255 - WheelPos;
    uint32_t localColor = 0;
    cRGB localPixel = (cRGB){0, 0, 0};
    if (WheelPos < 85) {
        localPixel.r = (255 - WheelPos * 3);
        localPixel.b = WheelPos * 3;
        return localPixel;
    } else if (WheelPos < 170) {
        WheelPos -= 85;
        localPixel.g = (WheelPos * 3);
        localPixel.b = 255 - WheelPos * 3;
        return localPixel;
    } else {
        WheelPos -= 170;
        localPixel.r = (WheelPos * 3);
        localPixel.g = 255 - WheelPos * 3;
        return localPixel;
    }
}

void theaterChase() {
    cRGB lessColor;
    cRGB moreColor;
    if (holdingIndex == 7) {
        lessColor = LESSCOLOR[0];
        moreColor = MORECOLOR[0];
    } else {
        lessColor = LESSCOLOR[holdingIndex + 1];
        moreColor = MORECOLOR[holdingIndex + 1];
    }

    cRGB localPixel = lessColor;
    if (LED_COUNT == 6) {
        if (theaterChaseDelay == delayTheshold - 1) {
            for (uint8_t i = 0; i < LED_COUNT; i++) {
                pixels[i] = moreColor;
            }
            theaterChaseIndex = (theaterChaseIndex + 1) % 3;
            for (uint8_t i = 0; i < LED_COUNT; i = i + 3) {
                pixels[i + theaterChaseIndex] = localPixel;
            }
            RGBtoByteArr();
            ws2812_setleds_pin(pixelByte, LED_COUNT, LED_PIN);
        }
    } else {
        if (theaterChaseDelay == delayTheshold - 1) {
            for (uint8_t i = 0; i < LED_COUNT; i++) {
                pixels[i] = moreColor;
            }
            theaterChaseIndex = (theaterChaseIndex + 1) % LED_COUNT;
            pixels[theaterChaseIndex] = localPixel;
            RGBtoByteArr();
            ws2812_setleds_pin(pixelByte, LED_COUNT, LED_PIN);
        }
    }
    theaterChaseDelay = (theaterChaseDelay + 1) % delayTheshold;
}

void wholePadColourUpdate() {
    for (uint8_t i = 0; i < LED_COUNT; i++) {
        pixels[i] = pressed[i];
        // setpixel(i, &pressed[i]);
    }
    RGBtoByteArr();
    ws2812_setleds_pin(pixelByte, LED_COUNT, LED_PIN);
}

void drawRebootPattern() {
    for (uint8_t i = 0; i < LED_COUNT; i++) {
        pixels[i] = rebootPattern[i];
    }
    RGBtoByteArr();
    ws2812_setleds_pin(pixelByte, LED_COUNT, LED_PIN);
}

void RGBtoByteArr() {
    for (uint8_t i = 0; i < LED_COUNT; i++) {
        pixelByte[i + i + i + 0] = (localBrightness?(pixels[i].r * localBrightness) >> 8 : pixels[i].r );
        pixelByte[i + i + i + 1] = (localBrightness?(pixels[i].g * localBrightness) >> 8 : pixels[i].g );
        pixelByte[i + i + i + 2] = (localBrightness?(pixels[i].b * localBrightness) >> 8 : pixels[i].b );
    }
}

void holdingAni() {
    // theaterChaseDelay = delayTheshold - 1;
    if (holdingIndex >= 0 && holdingIndex <= LED_COUNT) {
        (*LEDeffect[holdingIndex + 1])();
    }
}
