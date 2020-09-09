int currentTime;
int previousTime;
int deltaTime;

Ball ball;

void setup () {
  size(800, 600);
  currentTime = millis();
  previousTime = currentTime;
  
  ball = new Ball();
  ball.location.x = ball.radius;
  ball.location.y = height / 2; 
  ball.velocity.x = 5;
  ball.velocity.y = -3;
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
  ball.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  ball.display();
}
