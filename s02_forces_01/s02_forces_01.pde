int currentTime;
int previousTime;
int deltaTime;

Mover m;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  m = new Mover();
  m.setLocation(width / 2, height / 2);
  m.setVelocity(random(5), random(5));
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  
  update(deltaTime);
  display();
  
  previousTime = currentTime;
}

/***
  The calculations should go here
*/
void update(int delta) {
  m.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  m.display();
}
