class Graph implements Element{
  int x;
  int y;
  int w;
  int h;
  String title;
  ArrayList<Float>[] coords;
  
  Graph(int x, int y, int w, int h, String t, ArrayList[] c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.title = t;
    this.coords = c;
  }
  
  void update(){}
  
  void onClick(){}
  
  void onPress(){}
  
  void onDrag(){}
  
  boolean getUpdated() {return false;}
  
  int getVal() {
    return 0;
  }
  
  String getName() {return title;}
  
  void draw() {
    strokeWeight(1);
    stroke(0);
    line(x, y, x, y + h); // y axis
    line(x, y, x + w, h); // x axis
    
    // Find min, max y values
    float maxY = coords[1].get(0);
    int maxYIndex = 0;
    float minY = coords[1].get(0);
    int minYIndex = 0;
    for(int i = 0; i < coords[1].size(); i++) {
      if (coords[1].get(i) > maxY) {
        maxY = coords[1].get(i);
        maxYIndex = i;
      }
      if (coords[1].get(i) < minY) {
        minY = coords[1].get(i);
        minYIndex = i;
      }
    }
        
    
    
    // Plot
    for (int i = 0; i < coords[0].size(); i++) { 
      point(x + coords[0].get(i), y - coords[1].get(i)); // Plot one point
    }
    noStroke();
  }
  
  
  
}
