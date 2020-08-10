// colors
static int darkOliveGreen = #606C38;
static int kombuGreen = #283618;
static int cornsilk= #FEFAE0;
static int fawn = #DDA15E;
static int liver_dogs = #BC6C25;
static int bittersweetShimmer = #BC4749;
static int independence = #3D405B;
static int terraCotta = #E07A5F;
static int greenSheen = #81B29A;
static int gold_crayola = #F2CC8F;
static int acting = #FF0000;
static int selected = #FF0000;
int drawSeed = int (random(1000, 9999));
static float roughness = 0.9;

boolean currentStage = true;
boolean selectedbool = false;
int [] currentHoldingSecCel = {-1, -1};
static int[] outSecCel = {-1, -1};
List<List<List<String>>> selectedKey = new ArrayList<List<List<String>>>(6); 
static String [] textList = {"Prt Sc", "Scroll Lk", "Pause", "Insert", "Home", "PG up", "PG down", "Esc", "End", "OT"};
static String [] textListKeycode = {"KEY_PRINT_SCREEN", "KEY_SCROLL_LOCK", "KEY_PAUSE", "KEY_INSERT", "KEY_HOME", "KEY_PAGEUP", "KEY_PAGEDOWN", "KEY_ESCAPE", "KEY_END"};
boolean [] fullSelected = {false, false, false, false, false, false}; 
int [] selectedIndex = {-1, -1, -1, -1, -1, -1};


Map<String, String> KEYMAPUIDDIC = new HashMap <String, String>();

HandyRenderer handyDraw;
HandyRenderer fancyHandyDraw;
PFont TOPFONT_REG, TOPFONT_BOL, TEXTFONT_NORMAL, TOPFONT_BOLNOR;
box [][] boxSet = new box [6][13];
box [] topTypes = new box [2];
extendKey [] otherKeys = new extendKey [6];

String typedKeyName = "";
String typedKeyListKey = "";

int [] charY = {0, 0, 0, 0, 0, 0};
static int checkX = 347;

// define file address
// String targetAddress = sketchPath("");
String outputKMName = "keyMap.h"; 
String outputAMName = "LED_effect.h"; 
String presetFileName = "preset.txt";

Dictionary keyMapDic = new Hashtable(); 

void initializeDic() {
    BufferedReader reader = createReader(presetFileName);
    String line = null;
    try {
        while ((line = reader.readLine()) != null) {
            if (line.isEmpty() || line.trim().equals("") || line.trim().equals("\n")) {
                continue;
            }
            line = line.replace("#define ", "");

            String[] pieces = line.split(" ", 2);
            pieces[1] = pieces[1].replaceAll(" ", "");

            String keyName = pieces[0];
            String keyIndex = pieces[1];
            if (keyIndex.contains("<<")) {
                //keyIndex = toString((1<<int(keyIndex.charAt(6))));
                //println((1<<int(keyIndex.charAt(4))));
                println((Character.getNumericValue(keyIndex.charAt(4))));
            }
            println(keyIndex);

            //println("keyName: " + keyName + " keyIndex: " + keyIndex);
            //keyMap.put(keyName, keyIndex);
        }
        reader.close();
    } 
    catch (IOException e) {
        e.printStackTrace();
    }
    //println(keyMap.keys());
}
