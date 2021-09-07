int currentTime;
int previousTime;
int deltaTime;

ComplexRectangle rec;
int nbChildren = 5; 

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = currentTime;

  rec = new ComplexRectangle (0, height / 2, 100, 25);
  rec.velocity.x = 50.0f;
  
  for (int i = 0; i < nbChildren; i++) {
    float side = random (10, 20);
    ComplexRectangle child = new ComplexRectangle (random (5 * side, 10 * side),random (2 * side, 4 * side), side , side);
    child.setAngle(random(1.0) * TWO_PI);
    child.setAngularSpeed(random(1.0) * QUARTER_PI / 2);
    rec.addChild(child);
  }
}





void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  // Delais d'affichage pour capture d'écran
  //if (currentTime < 8000) {
  //  println (currentTime);
  //  return;
  //}

  update(deltaTime);
  display();
}

/***
 The calculations should go here
 */
 float angle = 0;
 
void update(int delta) {
  angle += TWO_PI / 360;
  rec.velocity.y = sin(angle) * 50;
  rec.update(delta);
}

/***
 The rendering should go here
 */
void display () {
  background(0);

  rec.display();
}
