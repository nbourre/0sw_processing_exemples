int currentTime;
int previousTime;
int deltaTime;

void setup() {
  size (800, 600);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {

}

void display() {

}
