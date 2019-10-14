class Food {
  int x; 
  int y;
  boolean eaten = false;
  
  Food(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void eaten() {
    eaten = true;
  }
  
  void draw() {
    if (eaten == true) {
      fill(200, 10, 10);
    }
    else fill(255, 255, 255);
    ellipse(x, y, 10, 10);
  }
  
}
