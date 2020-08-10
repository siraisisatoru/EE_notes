class box {
    private String text;
    private int section;
    private int index;
    private int fillColor;
    private int boundaryColor;
    private boolean active;
    private boolean selected;
    private int [] localXY;
    private String keyListKey;

    box (String text, int section, int index, int fillColor, int boundaryColor, boolean active, boolean selected, int[] localXY) {
        this.text = text;
        this.section = section;
        this.index = index;
        this.fillColor = fillColor;
        this.boundaryColor = boundaryColor;
        this.active = active;
        this.selected = selected;
        this.localXY = localXY;
        if (index == 0 && section != 12) {
            this.localXY[1]+=10;
            if (text.charAt(0) - 'A' > 3) {
                this.fillColor = bittersweetShimmer;
            }
        } else if (section == 12) {
            if (active) {
                this.fillColor = kombuGreen;
            }
        }
    }
    void setText (String text) {
        this.text = text;
    }
    void setSec (int section) {
        this.section = section;
    }
    void setIndex (int index) {
        this.index = index;
    }
    void setFillcolor (int fillColor) {
        this.fillColor = fillColor;
    }
    void setBoundColor (int boundaryColor) {
        this.boundaryColor = boundaryColor;
    }
    void setActive (boolean active) {
        this.active = active;
    }
    void setKeyListKey (String keyListKey) {
        this.keyListKey = keyListKey;
    }
    void toggleSelected(box another) {
        if (!selected) {
            selected = !selected;
            another.setSelected(!selected);
            if (index == 0) {
                currentStage = true;
            } else {
                currentStage = false;
            }
        }
    }
    void toggleSelected () {
        selected = !selected;
    }
    boolean getSelected () {
        return selected;
    }
    void setSelected (boolean selected) {
        this.selected = selected;
    }
    void stackText  (List<List<List<String>>> textArr) {
        // textArr.get(section).get(( index < 5 ? 0 : 1)).add(text);
        textArr.get(section).get(1).add(text);
        println(textArr);
    }
    void popText(List<List<List<String>>> textArr) {
        // textArr.get(section).get(( index < 5 ? 0 : 1)).remove(text);
        textArr.get(section).get(1).remove(text);
        println(textArr);
    }
    void drawBox () {
        if (section < 12 ) {
            // draw base rectangles
            if (selected) {
                fill (darkOliveGreen, 120);
            } else {
                fill (fillColor, 120);
            }
            if (index == 0) {
                if (active) {
                    int localX = 60, localY = 60;
                    float theta = (45-10) * PI / 180;
                    colorMode(HSB);
                    for (int i = 0; i < 8; i++) {
                        localX = localXY[0] + floor (localXY[2] * (i == 0 || i == 6 || i == 7 ? 1: (i == 1 || i == 5 ? 0.5 : 0)));
                        localY = localXY[1] + floor (localXY[3] * (i == 0 || i == 1 || i == 2 ? 0: (i == 3 || i == 7 ? 0.5 : 1)));
                        fancyHandyDraw.setFillColour (color(floor(255 /8.0 *i), 255, 255));
                        fancyHandyDraw.setStrokeColour (color(floor(255 /8.0 *i), 255, 255));
                        fancyHandyDraw.triangle(
                            localX, localY, 
                            localX + 15*cos(HALF_PI/2-theta/2), localY  - 15*sin(HALF_PI/2-theta/2), 
                            localX + 15*cos(HALF_PI/2-(theta - HALF_PI)/2), localY  - 15*sin(HALF_PI/2-(theta - HALF_PI)/2));
                        theta -= HALF_PI;
                    }
                    colorMode(RGB);
                    // x' = xcos theta - ysin theta
                    // y' = ycos theta - xsin theta
                }
                if (text.charAt(0) - 'A' > 3) {
                    fill (fillColor, 90);
                } else {
                    fill (fillColor, 60);
                }
            }
            if (index == 11 || index == 12) {
                fill (independence, 70);
            }
            handyDraw.setStrokeColour(color(boundaryColor));
            handyDraw.rect(localXY [0], localXY [1], localXY [2], localXY [3]);

            // draw texts
            if (index == 0) {
                fill (liver_dogs);
                textAlign(CENTER, CENTER);
                textFont(TOPFONT_BOL);
            } else {
                textAlign(CENTER, CENTER);
                textFont(TOPFONT_BOLNOR);
                fill (darkOliveGreen);
            }
            text(text, localXY[0] + localXY[2]/2, localXY[1] + (index == 0?20:15));
        } else {
            handyDraw.setStrokeColour(color(boundaryColor));            
            if (selected) {
                // active color
                fill(kombuGreen, 50);
                handyDraw.setBackgroundColour(cornsilk);
            } else {
                // deactive color
                fill(cornsilk);
                handyDraw.setBackgroundColour(cornsilk);
            }
            if (index == 0) {
                handyDraw.rect(10, 10, width/2-20, 40);
            } else {
                handyDraw.rect(width/2+5, 10, width/2-10, 40);
            }
            stroke(0);
            fill (liver_dogs);
            textFont(active?TOPFONT_BOL:TOPFONT_REG);
            textAlign(CENTER, CENTER);
            text(text, index == 0 ? width/4.0 : width*3.0/4, 25);
        }
    }
    void drawBoxFancy () {
        if (section < 12 ) {
            fill (fillColor);
            if (index == 0) {
                if (text.charAt(0) - 'A' > 3) {
                    handyDraw.setFillWeight(0.5);
                    handyDraw.setFillGap(5);
                } else {
                    handyDraw.setFillWeight(1);
                    handyDraw.setFillGap(3);
                }
            }

            handyDraw.setStrokeColour(color(boundaryColor));
            handyDraw.rect(localXY [0], localXY [1], localXY [2], localXY [3]);
            handyDraw.setFillWeight(0.6);
            handyDraw.setFillGap(3.8);

            if (index == 0) {
                fill (liver_dogs);
                textAlign(CENTER, CENTER);
                textFont(TOPFONT_BOL);
            } else {
                textAlign(CENTER, CENTER);
                textFont(TOPFONT_BOLNOR);
                fill (darkOliveGreen);
            }
            text(text, localXY[0] + localXY[2]/2, localXY[1] + localXY[3]/2);
        } else {
            // noStroke();            
            handyDraw.setStrokeColour(color(boundaryColor));
            handyDraw.setFillGap(5);
            if (active) {
                // active color
                fill(kombuGreen);
                handyDraw.setBackgroundColour(cornsilk);
            } else {
                // deactive color
                fill(cornsilk);
                handyDraw.setBackgroundColour(cornsilk);
                // handyDraw.rect(width/2+10, 10, width/2-20, 40);
            }
            if (index == 0) {
                handyDraw.rect(10, 10, width/2-20, 40);
            } else {
                handyDraw.rect(width/2+5, 10, width/2-10, 40);
            }
            stroke(0);
            fill (liver_dogs);
            textFont(active?TOPFONT_BOL:TOPFONT_REG);
            textAlign(CENTER, CENTER);
            text(text, index == 0 ? width/4.0 : width*3.0/4, 25);
        }
    }
    boolean contains (int x, int y) {
        return (x > localXY[0] && x < (localXY[0] + localXY[2]) ? (y>localXY[1] && y < (localXY[1] + localXY[3]) ? true : false) : false );
    }
    int [] getBoundRange () {
        return localXY;
    }
    int getY () {
        return localXY[1];
    }
}
