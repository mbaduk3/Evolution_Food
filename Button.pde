abstract class Button {
  int x;
  int y;
  int bWidth;
  int bHeight;
  color innerColor;
  String text;
  String name;
  boolean mouseHover = false;
  
  Button(int x, int y, int w, int h, color c, String t, String n) {
    this.x = x;
    this.y = y;
    this.bWidth = w;
    this.bHeight = h;
    this.innerColor = c;
    this.text = t;
    this.name = n;
  }
  
  void update() {
    mouseHover = false;
    if (mouseX < x + bWidth && 
    mouseX > x && 
    mouseY < y + bHeight && 
    mouseY > y) {
      mouseHover = true;
    }
  }
  
  void draw() {
    fill(innerColor);
    if (mouseHover) {
      fill(color(min(red(innerColor)+50, 255), min(green(innerColor)+50, 255), min(blue(innerColor)+50, 255))); 
    }
    rect(x, y, bWidth, bHeight);
    textAlign(CENTER, CENTER);
    textFont(arial_bold_30);
    fill(255, 255, 255);
    text(text, x, y, bWidth, bHeight);
    update();
  }
}
