# attiny85 KeyPad Configerator
This project is used to generate arduino code to configure the keypad key mapping and animation mapping when the key is pressed.

# !!!!!! before you try out this project, please burn a bootloader to your digispark / attiny85 in order to disable the reset pin to output the led signal !!!!!!

For the details, you may try to google how burn and where is the bootloader you needed. The programmes will not work or having unexpected result if you are not disabling the reseting pin.

# How to handle low frame rate problem
There are some possible issues that may cost low frame rate. Mainly because of high CPU usage by other programmes. There are some points may able to resolve the issue.

- Close some Chrome tags
- Change the webbrowsers
- Use P2D render in the ```setup()``` function

# Arduino library needed
LEDs
- light weight led lib [advised]
- Adafruit_NeoPixel [ TOO LARGE, double size compare with previous one] 

# keyboard lib have to add extra function for key whole [NOT USED]
- The codes can be found from https://hackaday.io/project/9277-oh-cheat/log/30813-extended-digispark-keyboard-library
- User can create a new function for auto press and hold function, it can be done by only detect key press can trigger the event and without waiting the key release.

# REMARK:
- Only the function get called in the code, the function will be take space in program memory!
    - All possible used functions will be included, if all animation functions get call, the memory usage will be very very large

# This is a open project for any use
Everyone can use, modify and or publish for their own perpose.

# TODO list :
- [x] Create canvas with pure color
- [x] Draw boxes on the canvas
- [x] Print coresponding function keys in the region
- [x] Detect the mouse location inside the region or not and change the color coorispondingly
- [x] Fix laggy problem
- [x] Link up the left button and the actived box
    - [x] Background fill color changed according to the left button pressing 
    - [x] scan Char box with firework effect
- [x] Reorginize the file system
- [x] OS version check added (processing)
- [x] Check old arduino codes works
- [x] Basic arduino code
    - [x] Button detection
    - [x] Button LED pattern
    - [x] Button key map
- [x] Generate arduino code
    - [x] Arduino code for key map array
    - [x] Arduino code for LED pattern
- [ ] Link up the button detected from GUI to array
    - [ ] store the data to the XML file
    - [ ] auto-save (generate) function when the window is closed
        - [ ] arduino code
        - [ ] XML data file
    - [ ] Button to save / generate data file / arduino code
- [ ] XML pre-load
    - [ ] load the data saved last closed

# schematic for the device
![schematic for 4 / 6 button keypad](/fancy_keypad/schematic/Schematic.png)
You may need capacitors to stablize the IC since the detection may cause significant current drop or increase.