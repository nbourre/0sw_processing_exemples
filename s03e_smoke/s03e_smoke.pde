int currentTime;
int deltaTime;
int previousTime;

Emitter emitter;
PImage img;

void setup() {
  size(800, 600, P2D);
  emitter = new Emitter (new PVector( width / 2, height / 3), 10, 100);
  img = loadImage("texture2.png");
  img.resize(32, 32);
  emitter.setTexture(img);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}



void update(int deltaTime) {
  float dx = map (mouseX, 0, width, -0.2, 0.2);
  PVector wind = new PVector (dx, 0);
  emitter.applyForce(wind);
  emitter.update(deltaTime);
}

int previousSave;
float saveRate = 1000.0 / 15;
boolean createGif = false;

void display() {
  
  if (createGif) {
    if (currentTime - previousSave < saveRate)return;
    previousSave = currentTime;
    saveFrame("d:/temp/proc_frames/####.tga");
  }
   
  background(0);
  
  emitter.display();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    emitter.setXY(mouseX, mouseY);
  }
}
