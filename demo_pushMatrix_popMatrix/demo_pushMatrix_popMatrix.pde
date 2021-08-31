int currentTime;
int previousTime;
int deltaTime;

Square s;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = currentTime;
  
  s = new Square();
  s.location.x = width / 2;
  s.location.y = height / 2;
  
  s.createChild();
  
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
  s.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background (0);
  
  s.display();
}
