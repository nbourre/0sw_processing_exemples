int currentTime;
int previousTime;
int deltaTime;

ParticleSystem ps;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = currentTime;

  ps = new ParticleSystem(new PVector(width / 2, height / 2));
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  update(deltaTime);
  display();
}

color fillColor = 0;
int alpha = 2;

/***
 The calculations should go here
 */
void update(int delta) {
  ps.update(delta);
}

/***
 The rendering should go here
 */
void display () {
  background (0);
  //fill (fillColor, alpha);
  //rect (0, 0, width, height);
  
  //fill (0);
  //rect (width / 2 - 128, 100, 256, 300);
  ps.display();
  
}

void mousePressed() {
  if (mouseButton == LEFT) {
    ps = new ParticleSystem(new PVector (mouseX, mouseY));
  }
}
