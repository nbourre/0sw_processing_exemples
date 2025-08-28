World world;

long previousTime = 0;
long currentTime = 0;
long deltaTime;

void setup () {
  //fullScreen(2);
  size (680, 384);
  world = new World();
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  
  background(0);
  
  world.update(deltaTime);
  world.display();

  previousTime = currentTime; 
}

void keyPressed() {
  if (key == 'r') {
    world = new World();
  }
    
}
