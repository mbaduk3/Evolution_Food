class AutoButton extends Button implements Element {
  int x;
  int y;
  int bWidth;
  int bHeight;
  color innerColor;
  String text;
  String name;
  boolean mouseHover = false;
  
  AutoButton(int x, int y, int w, int h, color c, String t, String n) {
    super(x, y, w, h, c, t, n);
  }
  
  
  void onClick() {
    if (super.mouseHover) {
      if (!auto) {
        print("Auto");
        auto = true;
      } else {
        auto = false;
      }
    }
  }
  
  void onPress(){}
  
  void onDrag(){}
  
  boolean getUpdated() {return false;}
  
  int getVal() {
    return 0;
  }
  
  String getName() {return name;}
  
}
