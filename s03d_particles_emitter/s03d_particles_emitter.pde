int currentTime;
int deltaTime;
int previousTime;

Emitter emitter;

void setup() {
  size(800, 600);
  emitter = new Emitter (new PVector( width / 2, height / 3), 10, 100);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {
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
  
  background(255);
  
  emitter.display();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    emitter.setXY(mouseX, mouseY);
  }
}
