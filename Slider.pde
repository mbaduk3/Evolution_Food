class Slider implements Element {
  int x;
  int y;
  int w;
  int h = 15;
  int val;
  float valX;
  float valW = 15;
  float valY;
  float valH = 25;
  float xOffset = 0;
  String name;
  String text;
  int prevVal;
  boolean updated = false;
  boolean pressed = false;
  boolean mouseHover = false;
  
  Slider(int x, int y, int w, int v, String t, String name) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.val = v;
    valX = map(val, 0, 10, x, x+w) - 5;
    this.text = t;
    this.name = name;
    prevVal = 3;
  }
  
  void update() {
    valY = y - (valH / 2) + (h / 2) - 2;
    mouseHover = false;
    if (mouseX < valX + valW && 
    mouseX > valX && 
    mouseY < valY + valH && 
    mouseY > valY) {
      mouseHover = true;
    }
    setVal();
    if (prevVal != val) {
      updated = true;
    } else {
      updated = false;
    }
    prevVal = val;
  }
  
  boolean getUpdated() {return updated;}
  
  int getVal() {
    return val;
  }
  
  String getName() {return name;}
  
  void onClick() {
  }
  
  void onPress() {
    if (mouseHover) {
      pressed = true;
    } else {
      pressed = false;
    }
    xOffset = mouseX - valX;
  }
  
  void onDrag() {
    if (pressed) {
      if (mouseX - xOffset + 5> x && mouseX - xOffset < x + w - 5) {
        valX = mouseX - xOffset;
      }
    }
  }
  
  void setVal() {
    val = round(map(valX, x, x+w, 0, 10));
  }
  
  void draw() {
    fill(128,128,128);
    rect(x, y, w, 10);
    fill(220, 220, 220);
    if (mouseHover) fill(250, 250, 250);
    rect(valX, valY, valW, valH, 4);
    textFont(arial_bold_30);
    fill(128, 128, 128);
    text(Integer.toString(val), x + w + 30, y);
    text(text, x - 10 * text.length(), y);
  }
  
}
