int currentTime;

int spawnInterval = 2500;
int spawnPrevious = 0;

Thing theThing;
PVector gravity = new PVector(0, 10);

void setup() {
  size (800, 600);
  
  theThing = new Thing();
}

void draw() {
  currentTime = millis();
  
  update(currentTime);
  display();
}

void update(int time) {
  if (theThing.isAlive) {
    theThing.applyForce(gravity);
  
    theThing.update(time);
    spawnPrevious = time;
  } else {
    if (currentTime - spawnPrevious > spawnInterval) {
      theThing.respawn();
    }
  }
}

void display() {
  background(0);
  theThing.display();
}
