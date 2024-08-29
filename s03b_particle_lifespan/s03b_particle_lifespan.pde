int currentTime;
int previousTime;
int deltaTime;

Particle p;

void setup() {
  size (800, 600);
  p = new Particle();
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {
  p.update();
}

void display() {
  background(255);
  p.display();
}
