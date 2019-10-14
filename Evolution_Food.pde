/*
Made by Maxim Baduk
Based on: https://www.youtube.com/watch?v=0ZGbIKd0XrM
*/

import grafica.*; 

Food[] food;
ArrayList<Creature> creature;
Control control = new Control();
PFont arial_bold_30;
PFont arial_bold_60;
PFont arial_light;
float saveTime;
int roundLength; // time-length of a round (millis)
static boolean running = false;
int generation = 0;
float variability = 0.5;
float avgSpeed = 0;
HashMap<String, Element> settings;
boolean auto = false;

int arenaWidth = 600;
int arenaHeight = 600;

// Data for the graph
GPointsArray points;
GPlot plot;

ProgressBar pb = new ProgressBar(arenaWidth / 2, 25, 560, 10);

void setup() {
  noStroke();
  smooth(2);
  size(1200, 600);
  background(255, 255, 255);
  arial_bold_30 = createFont("Arial-BoldMT", 30, true);
  arial_bold_60 = createFont("Arial-BoldMT", 60, true);
  arial_light = createFont("ArialMT", 10);
  
  // Add elements to the right-hand screen
  control.add(new RestartButton(620, 450, 275, 60, color(255, 99, 71, 100), "Restart", "Restart Button"));
  control.add(new AutoButton(905, 450, 275, 60, color(154, 205, 50), "Auto Evolve", "Auto Button"));
  control.add(new EvolveButton(620, 520, 560, 60, color(40, 80, 200, 100), "Evolve!", "Evolve Button"));
  control.add(new Slider(750, 50, 370, 3, "Speed: ", "Speed Slider"));
  control.add(new Slider(750, 100, 370, 8, "Time: ", "Time Slider"));
  control.add(new Slider(750, 150, 370, 8, "Food: ", "Food Slider"));
  
  settings = control.getSettings();
  roundLength = settings.get("Time Slider").getVal();
  
  plot = new GPlot(this, 630, 160);
  plot.setDim(400, 200);
  plot.setBgColor(10025880);
  plot.setBoxBgColor(10025880);
  plot.setTitleText("Average Speed");
  initRound();
}

void mouseClicked() {
  for (Element e : control.elements) {
    e.onClick();
  }
}

void mousePressed() {
  for (Element e : control.elements) {
    e.onPress();
  }
}

void mouseDragged() {
  for (Element e : control.elements) {
    e.onDrag();
  }
}

void initRound() {
  saveTime = millis();
  food = initializeFoods(settings.get("Food Slider").getVal() * 30);
  creature = initializeCreatures(12);
  running = true;
  generation = 1;
  
  points = new GPointsArray(generation);
  points.add(0, avgSpeed());
  plot.setPoints(points);
}

void newRound() {
  killHunger();
  reproduce();
  saveTime = millis();
  running = true;
  generation++;
  food = initializeFoods(settings.get("Food Slider").getVal() * 30);
  points.add(generation - 1, avgSpeed());
  plot.setPoints(points);
}

float avgSpeed() {
  float sum = 0;
  for (Creature c : creature) {
    sum+=c.speed;
  }
  return sum / creature.size();
}


// Kill off the creatures that are below the average fitness for this round...
void elimAvg() {
  int sumFitness = 0;
  for (Creature c : creature) {
    sumFitness+=c.fitness;
  }
  float avgFitness = sumFitness / creature.size();
  for (int i = 0; i < creature.size(); i++) {
    if (creature.get(i).fitness > avgFitness) {
      creature.remove(i);
      i--;
    }
  }
}

// Kill off all creatures that have eaten less than their hunger
void killHunger() {
  for (int i = 0; i < creature.size(); i++) {
    Creature c = creature.get(i);
    if (c.fitness < c.hunger) {
      creature.remove(i);
      i--;
    } else {
      c.fitness = 0;
    }
  }
}

// Make a copy of every creature
void reproduce() {
  int s = creature.size();
  for (int i = 0; i < s; i++) {
    Creature c = creature.get(i);
    int x = 0 == floor(random(2)) ? 0 : arenaWidth - 20;
    int y = floor(random(arenaHeight));
    creature.add(new Creature(x, y, c.speed));
  }
}

Food[] initializeFoods(int n) {
  Food[] food = new Food[n];
  for (int i = 0; i < n; i++) {
    int x = floor(random(arenaWidth));
    int y = floor(random(arenaHeight));
    food[i] = new Food(x, y);
  }
  return food;
}

ArrayList<Creature> initializeCreatures(int n) {
  ArrayList<Creature> creature = new ArrayList<Creature>();
  for (int i = 0; i < n; i++) {
    int x = 0 == floor(random(2)) ? 0 : arenaWidth - 20;
    int y = floor(random(arenaHeight));
    creature.add(new Creature(x, y, variability * random(0, 10)));
  }
  return creature;
}

void update() {
  if (running) {
    for (Creature c : creature) {
      c.update();
      for (int i = 0; i < food.length; i++) {
        // 2D collision detection
        if (food[i].eaten == false && food[i].x < c.x + 20 &&
         food[i].x + 10 > c.x &&
         food[i].y < c.y + 20 &&
         food[i].y + 10 > c.y) {
           food[i].eaten = true;
           c.fitness++;
        }
      }
      if (settings.get("Speed Slider").getUpdated() == true) {
        c.setSpeed(c.baseSpeed * settings.get("Speed Slider").getVal());
      }         
     }
  }
  if (settings.get("Time Slider").getUpdated() == true) {
    roundLength = settings.get("Time Slider").getVal() * 1000;
  }
  if (millis() - saveTime > roundLength && auto == false) {
    running = false;
  } else if (millis() - saveTime > roundLength && auto == true) {
    newRound();
  }
  pb.update();
  settings = control.getSettings();
  control.update();
}


void draw() {
  fill(152,251,152);
  rect(0, 0, arenaWidth, arenaHeight);
  for (Food f : food) {
    f.draw();
  }
  for (Creature c : creature) {
    c.draw();
  }
  
  // Generation counter
  textAlign(CENTER, CENTER);
  textFont(arial_bold_60);
  fill(100, 100, 100);
  rectMode(CORNER);
  text(Integer.toString(generation), 0, 500, 100, 100);
  
  // Auto indicator
  if (auto) {
    text("Auto", 400, 500, 200, 100);
  }
  
  pb.draw();
  control.draw();
  plot.defaultDraw();
  update();
}
