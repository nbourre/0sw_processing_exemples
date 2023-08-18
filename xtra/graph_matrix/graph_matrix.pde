import processing.net.*;

Matrix mat;

int displayInterval = 250;
int displayAcc = 0;
int displayLastTime = 0;
int previousTime = 0;
int currentTime = 0;

void setup() {
  size (800, 600);
  background(50);
  fill (200);
  
  mat = new Matrix(10, 10);
}

void draw() {
  currentTime = millis();
  float delta = currentTime - previousTime;
  previousTime = currentTime;
  
  update(delta);
  display();
}

void update(float deltaTime) {
  displayAcc += deltaTime;
  if (displayAcc >= displayInterval) {
    displayAcc = 0;
  }
}

void display() {
  pushMatrix();
    translate (10, 10);
    scale(0.90);
    
    mat.display();
  popMatrix();
}
