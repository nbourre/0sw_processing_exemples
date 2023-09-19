int currentTime;
int previousTime;
int deltaTime;

SysSolaire sys;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = millis();

  sys = new SysSolaire();
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
}

/***
  The calculations should go here
*/
void update(int delta) {
  sys.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  sys.display();
}
