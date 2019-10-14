class ProgressBar {
  int x;
  int y;
  int w;
  int h;
  float progressW = 0; // Progress width
  
  ProgressBar(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void update() {
    progressW = w;
    if (running) {
      progressW = (millis() - saveTime) / roundLength * w;
    }
  }
  
  void draw() {
    rectMode(CENTER);
    fill(220,220,220);
    rect(x, y, w, h);
    fill(128,128,128);
    rect(x, y, progressW, h);
    rectMode(CORNER);
    update();
  }
  
}
