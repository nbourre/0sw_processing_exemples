int currentTime;
int previousTime;
int deltaTime;

Grid grid;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  grid = new Grid();  
  grid.lineColor = color(0, 0, 0, 127);
  grid.setXY (width/8, height/8);
  grid.setXYTo (width / 2, height/2);
  
  grid.scale = 0.5;
  grid.angleTo = HALF_PI;
  grid.setAnimation(true);
  grid.setAngleTimeToGoal(2.0);
  grid.setXYAnimationTime(2.0);
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
  grid.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(204);
  grid.display();
}
