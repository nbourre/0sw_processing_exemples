int currentTime;
int previousTime;
int deltaTime;

Rectangle r;

void setup() {
  size (800, 600);
  
  r = new Rectangle(width / 2, height / 2, 50, 100);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {
  r.angle = atan2(mouseY - r.location.y, mouseX - r.location.x) - HALF_PI;
  r.update(deltaTime);

}

void display() {
  background(50);
  r.display();

}
