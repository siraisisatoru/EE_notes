// imports
import java.io.*;
import java.util.*;
import org.gicentre.handy.*;

void setup() {
    prepareExitHandler();
    //size (550, 825,P2D);
    size (550, 825);
    iniVars();
    handyDraw.setSeed(drawSeed);
    handyDraw.setOverrideStrokeColour(true);
    handyDraw.setRoughness(roughness);
    //frameRate(400);
    exit();
}

void draw() {
    // clear();
    background(cornsilk);
    handyDraw.setSeed(drawSeed);
    topTypes[0].drawBox();
    topTypes[1].drawBox();

    // check stage flag to 
    if (currentStage) {
        drawAllKM();
    } else {
        drawAllAM();
    }

     println(frameRate);
}

void mouseMoved() {
    if (!Arrays.equals(currentHoldingSecCel, outSecCel)) {
        if (currentHoldingSecCel[0]!=12  ) {
            if (!boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].contains(mouseX, mouseY)) {
                boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].setBoundColor(color(0));
                if (currentHoldingSecCel[1] == 0) {
                    boxSet[currentHoldingSecCel[0]][0].setActive(false);
                }
                currentHoldingSecCel[0] = -1;
                currentHoldingSecCel[1] = -1;
            }
        } else {
            if (!topTypes[currentHoldingSecCel[1]].contains(mouseX, mouseY)) {
                topTypes[currentHoldingSecCel[1]].setBoundColor(cornsilk);
                currentHoldingSecCel[0] = -1;
                currentHoldingSecCel[1] = -1;
            }
        }
    } else {
        if (mouseY < charY [0]) {
            // scan the top type
            if ( topTypes[0].contains(mouseX, mouseY)) {
                currentHoldingSecCel[0] = 12;
                currentHoldingSecCel[1] = 0;
                topTypes[0].setBoundColor(acting);
            } else if ( topTypes[1].contains(mouseX, mouseY)) {
                currentHoldingSecCel[0] = 12;
                currentHoldingSecCel[1] = 1;
                topTypes[1].setBoundColor(acting);
            }
        } else {
            for (int i =0; i < 6; i++) {
                if (mouseY < charY [i]) {
                    continue;
                } else {
                    // line (0 , charY [i] +35 , width , charY[i]+35);
                    if (mouseX < 120) {
                        if (boxSet[i][0].contains(mouseX, mouseY)) {
                            currentHoldingSecCel[0] = i;
                            currentHoldingSecCel[1] = 0;
                            boxSet[i][0].setActive(true);
                        }
                    } else {
                        for (int j = 0; j < 11; j++) {
                            if ( boxSet[i][j].contains(mouseX, mouseY)) {
                                currentHoldingSecCel[0] = i;
                                currentHoldingSecCel[1] = j;
                                boxSet[i][j].setBoundColor(acting);
                            }
                        }
                    }
                }
            }
        }
    }
}

void mousePressed() {
    if (!Arrays.equals(currentHoldingSecCel, outSecCel) && mouseButton == LEFT) {
        // mouse is in one of the cell
        if (currentHoldingSecCel[0] != 12) {
            // press in the subset region
            if (currentHoldingSecCel[1] != 0) {
                if (fullSelected[currentHoldingSecCel[0]]) {
                    if (boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].getSelected()) {
                        boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].toggleSelected();
                        boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].popText(selectedKey);
                        fullSelected[currentHoldingSecCel[0]] = false;
                    } else {
                        // there is a element is selected but pressing other key
                        // println (currentHoldingSecCel[1]);
                        if (currentHoldingSecCel[1] < 10) {
                            // except the other option
                            // toggle to select current key

                            // forceOverrideKey(currentHoldingSecCel[0], currentHoldingSecCel[1], selectedIndex[currentHoldingSecCel[0]],checkKeyType());
                            forceOverrideKey(currentHoldingSecCel[0], currentHoldingSecCel[1], selectedIndex[currentHoldingSecCel[0]], true);

                            // println(selectedIndex[currentHoldingSecCel[0]]);
                        }
                    }
                } else {
                    if (!boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].getSelected()) {
                        boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].toggleSelected();
                        boxSet[currentHoldingSecCel[0]][currentHoldingSecCel[1]].stackText(selectedKey);
                        selectedIndex[currentHoldingSecCel[0]] = currentHoldingSecCel[1];
                        // println(selectedIndex[currentHoldingSecCel[0]]);
                        if (selectedKey.get(currentHoldingSecCel[0]).get(1).size()==1) {
                            fullSelected[currentHoldingSecCel[0]] = true;
                        }
                    }
                }

                sortTextArr(selectedKey, currentHoldingSecCel[0]);
                // update the text to the bottom box to display combination
                updateKeyCombin(selectedKey, currentHoldingSecCel[0], currentHoldingSecCel[1], false);
                // println(selectedKey);
            }
        } else {
            // press in the top type region
            topTypes[currentHoldingSecCel[1]].toggleSelected(topTypes[currentHoldingSecCel[1]== 0? 1:0]);
        }
    }
}

void keyPressed() {
    // println(currentStage);
    // when the mouse is on the char box, detect the key pressed and register to the key map.
    if (currentHoldingSecCel[0] != 12 && currentHoldingSecCel[1] == 0) {
        if (!(key == CODED && keyCode == 0)) { // ignore fn key
            println(checkKeyType(key, keyCode, false));
        }
    }
}

void stop() {
    // run when the window gonna be closed


    genAniMap();
    genKeyMap();
    super.stop();
} 

private void prepareExitHandler () {
    Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
        public void run () {
            //System.out.println("SHUTDOWN HOOK");
            try {
                stop();
            } 
            catch (Exception ex) {
                ex.printStackTrace(); // not much else to do at this point
            }
        }
    }
    ));
}  

void iniVars() {
    background(cornsilk);

    // ini y locations for each sections 
    for (int i = 0; i< 6; i++) {
        charY [i] = 80 + 125*i;
    }
    fill (fawn);

    handyDraw = HandyPresets.createWaterAndInk(this);
    fancyHandyDraw = new HandyRenderer(this);
    fancyHandyDraw.setOverrideFillColour(true);
    fancyHandyDraw.setFillGap(1.3);
    fancyHandyDraw.setOverrideStrokeColour(true);

    // ini fonts
    TOPFONT_REG = createFont("font/Kalam-Regular.ttf", 35);
    TOPFONT_BOL = createFont("font/Kalam-Bold.ttf", 35);
    TEXTFONT_NORMAL = createFont("font/Kalam-Regular.ttf", 20);
    TOPFONT_BOLNOR = createFont("font/Kalam-Bold.ttf", 20);

    // ini the array for topTypes
    topTypes[0] = new box("KEY MAP", 12, 0, liver_dogs, cornsilk, false, true, new int[]{10, 10, width/2-20, 40}); 
    topTypes[1] = new box("ANIMATION MAP", 12, 1, liver_dogs, cornsilk, false, false, new int[]{width/2+5, 10, width/2-10, 40});

    // ini the array for the subsetions
    int [] localcharXY = { 40, charY[0], 50, 50};
    for (int i =0; i < 6; i++) {
        localcharXY[1] = charY[i];
        // boxSet[i][0] = new box(Character.toString(char('A' + i)), i, 0, fawn, color(0), false, false, new int []{ localcharXY [0], localcharXY[1], localcharXY[2], localcharXY[3]});        // charator 
        boxSet[i][0] = new box(Character.toString(char('A' + i)), i, 0, fawn, color(0), false, false, new int []{ localcharXY [0], localcharXY[1], localcharXY[2], localcharXY[3]});        // charator 
        boxSet[i][1] = new box(textList[0], i, 1, fawn, color(0), false, false, new int []{ localcharXY [0] + 90, localcharXY[1], 70, 30});
        boxSet[i][1].setKeyListKey(textListKeycode[0]);
        boxSet[i][2] = new box(textList[1], i, 2, fawn, color(0), false, false, new int []{ localcharXY [0] + 180, localcharXY[1], 85, 30});
        boxSet[i][2].setKeyListKey(textListKeycode[1]);
        boxSet[i][3] = new box(textList[2], i, 3, fawn, color(0), false, false, new int []{ localcharXY [0] + 285, localcharXY[1], 60, 30});
        boxSet[i][3].setKeyListKey(textListKeycode[2]);
        boxSet[i][4] = new box(textList[3], i, 4, fawn, color(0), false, false, new int []{ localcharXY [0] + 360, localcharXY[1], 60, 30});
        boxSet[i][4].setKeyListKey(textListKeycode[3]);
        boxSet[i][5] = new box(textList[4], i, 5, fawn, color(0), false, false, new int []{ localcharXY [0] + 435, localcharXY[1], 60, 30});
        boxSet[i][5].setKeyListKey(textListKeycode[4]);
        boxSet[i][6] = new box(textList[5], i, 6, fawn, color(0), false, false, new int []{ localcharXY [0] + 90, localcharXY[1] + 40, 70, 30});
        boxSet[i][6].setKeyListKey(textListKeycode[5]);
        boxSet[i][7] = new box(textList[6], i, 7, fawn, color(0), false, false, new int []{ localcharXY [0] + 180, localcharXY[1] + 40, 85, 30});
        boxSet[i][7].setKeyListKey(textListKeycode[6]);
        boxSet[i][8] = new box(textList[7], i, 8, fawn, color(0), false, false, new int []{ localcharXY [0] + 285, localcharXY[1] + 40, 50, 30});
        boxSet[i][8].setKeyListKey(textListKeycode[7]);
        boxSet[i][9] = new box(textList[8], i, 9, fawn, color(0), false, false, new int []{ localcharXY [0] + 355, localcharXY[1] + 40, 50, 30});
        boxSet[i][9].setKeyListKey(textListKeycode[8]);
        boxSet[i][10] = new box(textList[9], i, 10, fawn, color(0), false, false, new int []{ localcharXY [0] + 420, localcharXY[1] + 40, 50, 30});
        boxSet[i][11] = new box("", i, 11, fawn, color(0), false, false, new int []{ localcharXY [0] + 30, localcharXY[1] + 80, 320, 35});
        boxSet[i][12] = new box("", i, 12, fawn, color(0), false, false, new int []{ localcharXY [0] + 380, localcharXY[1] + 80, 120, 35});
    }

    for (int i = 0; i < 6; i++) {
        selectedKey.add(new ArrayList<List<String>>());
        for (int j = 0; j < 2; j++) {
            selectedKey.get(i).add(new ArrayList<String>());
        }
    }

    // ini lookup dictionary
    openFileToList(KEYMAPUIDDIC);

    for (int i = 0; i < 6; i++) {
        otherKeys[i] = new extendKey ();
    }
}

void drawAllKM () {
    handyDraw.setSeed(drawSeed);
    fancyHandyDraw.setSeed(drawSeed);
    //handyDraw.
    for (int i = 0; i<6; i++) {
        for (int j = 0; j < 13; j++) {
            boxSet[i][j].drawBox();
        }
        textAlign(CENTER, CENTER);
        textFont(TOPFONT_BOL);
        fill (liver_dogs);
        text("+", 403, boxSet[i][10].getY() + 50);
    }
}

void drawAllAM () {
    handyDraw.setSeed(drawSeed);
}

void forceOverrideKey (int localSection, int localIndex, int localSelectedIndex, boolean keyType) {
    // deselect selected index
    if (selectedIndex[localSection]!=-1) {
        //  current section has been ocupided one
        deselectKey(localSection, localSelectedIndex);
    }

    // select the target key box
    if (localIndex == -1) {
        // the external key has been pressed
        // OT selected
        // key name change
    } else if (localSection != 13) {
        // select the target index
        if (!boxSet[localSection][localIndex].getSelected()) {
            boxSet[localSection][localIndex].toggleSelected();
            boxSet[localSection][localIndex].stackText(selectedKey);
            selectedIndex[localSection] = localIndex;
        }
    }
}

void deselectKey(int localSection, int localIndex) {
    if (boxSet[localSection][localIndex].getSelected()) {
        boxSet[localSection][localIndex].toggleSelected();
        boxSet[localSection][localIndex].popText(selectedKey);
    }
    println("deselect");
}

boolean checkKeyType() {
    return false;
}

boolean checkKeyType(int localKey, int localKeyCode, boolean fromUI) {
    // true for modifier, false for keycode
    if (!fromUI) {
        if ((localKey == CODED)&& (localKeyCode == 157 || localKeyCode == ALT || localKeyCode == CONTROL || localKeyCode == SHIFT)) {
            if (localKeyCode == 157) { // command
                typedKeyListKey = "MOD_GUI_LEFT";
            } else if (localKeyCode == ALT) {
                typedKeyListKey = "MOD_ALT_LEFT";
            } else if (localKeyCode == CONTROL) {
                typedKeyListKey = "MOD_CONTROL_LEFT";
            } else if (localKeyCode == SHIFT) {
                typedKeyListKey = "MOD_SHIFT_LEFT";
            }
            println(typedKeyListKey);
            return true;
        } else {
            // non function keys
            // ASCII
            if ((localKey >= 'A' && localKey <= 'Z' )||(localKey >= 'a' && localKey <= 'z' )) { // check char keys
                typedKeyListKey = "KEY_" + Character.toUpperCase(char (localKey));
            } else if (localKey >= '!' && localKey <= '/' || localKey >= ':' && localKey <= '@'
                || localKey >= '[' && localKey <= '`' || localKey >= '(' && localKey <= '~' || localKey >= '0' && localKey <= '9') { // symbols and numbers
                println("symbols " + char(localKey));
                switch (char(localKey)) {
                case '!': 
                case '1':
                    typedKeyListKey = "KEY_1";
                    break;
                case '@': 
                case '2':
                    typedKeyListKey = "KEY_2";
                    break;
                case '#': 
                case '3':
                    typedKeyListKey = "KEY_3";
                    break;
                case '$': 
                case '4':
                    typedKeyListKey = "KEY_4";
                    break;
                case '%': 
                case '5':
                    typedKeyListKey = "KEY_5";
                    break;
                case '^': 
                case '6':
                    typedKeyListKey = "KEY_6";
                    break;
                case '&': 
                case '7':
                    typedKeyListKey = "KEY_7";
                    break;
                case '*': 
                case '8':
                    typedKeyListKey = "KEY_8";
                    break;
                case '(': 
                case '9':
                    typedKeyListKey = "KEY_9";
                    break;
                case ')': 
                case '0':
                    typedKeyListKey = "KEY_0";
                    break;
                case '-': 
                case '_':
                    typedKeyListKey = "KEY_MINUS";
                    break;
                case '=': 
                case '+':
                    typedKeyListKey = "KEY_EQUAL";
                    break;
                case '[': 
                case '{':
                    typedKeyListKey = "KEY_OPEN_SQUARE_BRACKET";
                    break;
                case ']': 
                case '}':
                    typedKeyListKey = "KEY_CLOSE_SQUARE_BRAECKT";
                    break; 
                case '\\': 
                case '|':
                    typedKeyListKey = "KEY_BACK_SLASH";
                    break;
                case ':': 
                case ';':
                    typedKeyListKey = "KEY_SEMICONLON";
                    break;
                case '\"': 
                case '\'':
                    typedKeyListKey = "KEY_OPENQUOTATION";
                    break;
                case ',': 
                case '<':
                    typedKeyListKey = "KEY_COMMA";
                    break;
                case '.': 
                case '>':
                    typedKeyListKey = "KEY_FOOTSTOP";
                    break;
                case '/': 
                case '?':
                    typedKeyListKey = "KEY_SLASH";
                    break;
                case '`':
                case '~':
                    typedKeyListKey = "KEY_GRAVE_ACCENT";
                    break;
                default :
                    typedKeyListKey = "";
                    break;
                }
                /*
             #define KEY_PRINT_SCREEN 70
                 #define KEY_SCROLL_LOCK 71
                 #define KEY_PAUSE 71
                 #define KEY_INSERT 73
                 
                 #define KEY_HOME 74
                 #define KEY_PAGEUP 75
                 #define KEY_END 77
                 #define KEY_PAGEDOWN 78
                 */
            } else if (localKey == BACKSPACE || localKey == TAB || localKey == ENTER || localKey == RETURN || localKey == ESC || localKey == DELETE || localKey == ' ') {
                typedKeyListKey = (localKey == BACKSPACE)?"KEY_DELETE_FORWARD":(localKey == TAB?"KEY_TAB":(localKey == ENTER?"KEY_ENTER":(localKey == RETURN?"KEY_ENTER":(localKey == ESC?"KEY_ESCAPE":(localKey == DELETE?"KEY_DELETE":localKey == ' '?"KEY_SPACE":"")))));
                // println("ascii func key");
                // } else if (localKey == UP || localKey == DOWN || localKey == LEFT || localKey == RIGHT){
            } else {
                if (localKey == CODED) {
                    if (localKeyCode == UP || localKeyCode == DOWN || localKeyCode == LEFT || localKeyCode == RIGHT ) {
                        println("directional key");
                        switch (localKeyCode) {
                        case UP:
                            typedKeyListKey = "KEY_ARROW_UP";
                            break;
                        case DOWN:
                            typedKeyListKey = "KEY_ARROW_DOWN";
                            break;
                        case LEFT:
                            typedKeyListKey = "KEY_ARROW_LEFT";
                            break;
                        case RIGHT:
                            typedKeyListKey = "KEY_ARROW_RIGHT";
                            break;
                        default:
                            typedKeyListKey = "";
                            break;
                        }
                    } else if (localKeyCode == 20) {
                        println("cap lock");
                    } else if (localKeyCode >= 112 && localKeyCode <= 123 ) {
                        typedKeyListKey = "KEY_F" + (localKeyCode-111);
                    } else {
                        println("others coded " + localKeyCode);
                    }
                } else {
                    println("others");
                }
            }
            println(typedKeyListKey);
        } 
        return false;
    } else {
        return false; // all keys on the GUI are function keys not modifiers
    }
}

void sortTextArr(List<List<List<String>>> textArr, int section) {
    if (textArr.get(section).get(0).size()!=0) {
        // println(textArr.get(section).get(0));
        for (int i = 3; i >=0; i--) {
            if (textArr.get(section).get(0).contains(textList[i])) {
                textArr.get(section).get(0).remove(textList[i]);
                textArr.get(section).get(0).add(0, textList[i]);
            }
        }
        // println("sorted :\n" + textArr.get(section).get(0));
    }
    if (textArr.get(section).get(1).size()!=0) {
        for (int i = 8; i >=4; i--) {
            if (textArr.get(section).get(1).contains(textList[i])) {
                textArr.get(section).get(1).remove(textList[i]);
                textArr.get(section).get(1).add(0, textList[i]);
            }
        }
        // println("sorted :\n" + textArr.get(section).get(1));
    }
}

void updateKeyCombin(List<List<List<String>>> textArr, int section, int index, boolean keyType) {
    String targetText = "Error update";

    if (keyType) {
        // if (textArr.get(section).get(1).size()> 0) {
        //     targetText = textArr.get(section).get(1).get(0);
        //     for (int i = 1; i < textArr.get(section).get(1).size(); i++) {
        //         targetText += " + " + textArr.get(section).get(1).get(i);
        //     }
        // } else {
        //     targetText = "";
        // }
        // boxSet[section][11].setText(targetText);
    } else {
        if (section != -1 && index != -1) {
            // normal update due to the function key in th GUI
            if (textArr.get(section).get(1).size()> 0) {
                targetText = textArr.get(section).get(1).get(0);
                for (int i = 1; i < textArr.get(section).get(1).size(); i++) {
                    targetText += " + " + textArr.get(section).get(1).get(i);
                }
            } else {
                targetText = "";
            }
            boxSet[section][12].setText(targetText);
        } else {
            // unnormal update due to key input
        }
    }



    // if (textArr.get(section).get(1).size()!=0) {
    //     targetText = textArr.get(section).get(1).get(0) + (textArr.get(section).get(1).size()>1? " + " + textArr.get(section).get(1).get(1) : "") ;
    // } else {
    //     targetText = "";
    // }
    // boxSet[section][11].setText(targetText);
    // }
}
