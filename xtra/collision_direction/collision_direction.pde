int currentTime;
int previousTime;
int deltaTime;

Rectangle rectObstacle;
Rectangle rectBouncing;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  rectObstacle = new Rectangle(width / 2, height / 2 - 25, 200, 100);
  rectObstacle.fillColor = color(200, 0, 0); 
  
  rectBouncing = new Rectangle();
  rectBouncing.velocity.x = 10;
  rectBouncing.velocity.y = 5;

}
void draw () {
  timeManagement();
  update(deltaTime);
  display();
}

void update(int delta) {
  // Mettre les calculs ici
  rectBouncing.checkCollisions(rectObstacle);
  rectBouncing.update(delta);
    
}

void display () {
  background(0);
  rectObstacle.display();
  rectBouncing.display();
}

void timeManagement (){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
}
