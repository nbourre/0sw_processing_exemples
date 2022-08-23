int currentTime;
int previousTime;
int deltaTime;

Rectangle rSubject;
Rectangle rB;
Rectangle rC;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  rSubject = new Rectangle();
  rSubject.setXY(0, height / 2);
  rSubject.velocity.x = 5;
  
  rB = new Rectangle(width / 2, height / 2);
  rC = new Rectangle(width / 4, height / 4 * 3);
  
  rSubject.addObserver(rB);
  rSubject.addObserver(rC);  
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
  rSubject.update(delta);
  rB.update(delta);
  rC.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  rSubject.display();
  rB.display();
  rC.display();
}
