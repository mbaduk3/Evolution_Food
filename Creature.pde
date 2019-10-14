class Creature {
  float x; 
  float y;
  float tx;
  float ty;
  float speed;
  float baseSpeed;
  int fitness = 0;
  color c = color(255, 255, 255);
  float hunger;
  
  Creature(int x, int y, float s) {
    this.x = x;
    this.y = y;
    this.speed = s;
    tx = random(0, 100000);
    ty = random(0, 100000);
    hunger = speed + 1;
    baseSpeed = speed;
  }
  
  void move() {
    x = map(noise(tx), 0, 1, 0, arenaWidth - 20);
    y = map(noise(ty), 0, 1, 0, arenaHeight - 20);
    tx += speed/300;
    ty += speed/300;
  }
  
  void setSpeed(float s) {
    speed = s;
  }
  
  
  void update() {
    move();
    c = color(abs(255 - 8*fitness), abs(255 - 3*fitness), 255);
  }
  
  void draw() {
    fill(c);
    rect(x, y, 20, 20, 4);
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(arial_light);
    text(Integer.toString(fitness), x, y, 20, 20);
  }
}
