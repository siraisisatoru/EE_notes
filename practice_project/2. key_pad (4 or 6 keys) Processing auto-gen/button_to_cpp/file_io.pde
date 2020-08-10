
// void moveFile() {
//     File fromDes;
//     File toDes;
//     String skPath = sketchPath();
//     fromDes = new File (skPath + "/" + outputFileName);
//     //toDes = new File ("/Users/ufobenson/Desktop/positions1.cpp");
//     toDes = new File (targetAddress + "/positions1.cpp");
//     fromDes.renameTo (toDes);
// }

void copyFile() {
    File fromDes;
    File toDes;
    String skPath = sketchPath();
    fromDes = new File (skPath + "/" + outputKMName);
    toDes = new File (skPath + "/" + outputKMName.replace(".cpp", "") + "_1"+".cpp");
    fromDes.renameTo (toDes);
}

void writeArdu(List<String> contentList, boolean KM) {
    println(System.getProperty("os.name"));
    PrintWriter output;
    String localpath = outputKMName;
    if (System.getProperty("os.name").regionMatches(true, 0, "windows", 0, 7)) {
        // windows
        localpath = sketchPath().replaceAll("button_to_cpp\\\\", "") + "\\fancy_keypad\\";
    } else if (System.getProperty("os.name").regionMatches(true, 0, "mac", 0, 3)) {
        // mac
        localpath = sketchPath().replaceAll("button_to_cpp/", "") + "/fancy_keypad/";
    }
    if (KM) {
        localpath += outputKMName;
    } else {
        localpath += outputAMName;
    }


    output = createWriter(localpath);
    for (int i = 0; i <contentList.size(); i++) {
        output.println(contentList.get(i));
    }

    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
}

void openFileToList(Map<String, String> resultDic) {

    BufferedReader reader = createReader(presetFileName);
    String line = null;
    try {
        while ((line = reader.readLine()) != null ) {
            if (line.length()!=0) {
                String[] pieces = split(line, ' ');
                resultDic.put(pieces[1], line);
            }
        }
        reader.close();
    } 
    catch (IOException e) {
        e.printStackTrace();
    }
}

void genAniMap() {

    List<String> testFileContent = new ArrayList<String> (1);
    testFileContent.add("#ifndef LED_EFFECT_H\n#define LED_EFFECT_H\n#include \"keyMap.h\"");

    testFileContent.add("extern void theaterChase();\nextern void rainbowUpdate();");
    // the line begin to be modify to generate animation function array
    // testFileContent.add("extern void (*LEDeffect[])(){rainbowUpdate, theaterChase};");
    // testFileContent.add("extern void (*LEDeffect[])(){theaterChase,	rainbowUpdate};");
    // testFileContent.add("extern void (*LEDeffect[])(){theaterChase};");
    testFileContent.add("extern void (*LEDeffect[])(){rainbowUpdate,theaterChase,theaterChase,theaterChase,theaterChase,theaterChase,theaterChase};");
    // cRGB array with 7 element, the first one will be used as waiting animation
    testFileContent.add("extern void (*bindgingLEDeffect[sizeof(keyBind)])(){rainbowUpdate,theaterChase,theaterChase};");
    testFileContent.add("cRGB LESSCOLOR[7] = {(cRGB){63, 51, 163}, (cRGB){0, 255, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}};");
    testFileContent.add("cRGB MORECOLOR[7] = {(cRGB){89, 167, 47}, (cRGB){255, 255, 255}, (cRGB){255,255,255}, (cRGB){255,255,255}, (cRGB){255,255,255}, (cRGB){255,255,255}, (cRGB){255,255,255}};");
    // the line ends to be modify to generate animation function array

    testFileContent.add("cRGB rebootPattern[6] = {(cRGB){63, 51, 163}, (cRGB){0, 255, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}, (cRGB){255, 0, 0}};");


    testFileContent.add("#endif");
    writeArdu(testFileContent, false);
}

void genKeyMap() {
    List<String> testFileContent = new ArrayList<String> (1);
    testFileContent.add("#ifndef KEYMAP_H\n#define KEYMAP_H\n#include \"additionKey.h\"");
    testFileContent.add("extern void reboot();");
    // testFileContent.add("const bool needHold[6] = {false, false, false, false, false, false};");
    // testFileContent.add("const byte keyMap[6][2] = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}};");
    testFileContent.add("const byte keyMap[6][2] = {{KEY_X, MOD_CONTROL_LEFT}, {KEY_V, MOD_CONTROL_LEFT}, {KEY_DELETE_FORWARD, MOD_SHIFT_LEFT}, {0, MOD_CONTROL_LEFT}, {KEY_C, MOD_CONTROL_LEFT}, {KEY_V, MOD_CONTROL_LEFT}};");
    testFileContent.add("const byte keyBind[] = {B00110011, B00010001, B00001001}; // key map mask");
    testFileContent.add("extern void (*keyBindKMAP[sizeof(keyBind)])(){reboot, NULL};// the compiler will occurs an error when the mapped function too much compare with the given key bind sets");



    testFileContent.add("bool oneKeyOnly = false;");
    testFileContent.add("bool waitRelease = false;");
    testFileContent.add("#endif");

    writeArdu(testFileContent, true);
}