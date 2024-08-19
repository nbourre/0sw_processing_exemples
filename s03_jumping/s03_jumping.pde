int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

Player player;
int floor;
void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  floor = height - 50;
    
  player = new Player();
  player.setWidth(50);
  player.setHeight(100);
  player.setXY(width / 2 - player.getWidth(), height - player.getHeight());
  player.floor = floor;
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  manageInputs();
  update(deltaTime);
  display();
  
  savingFrames(5, deltaTime);  
}

/***
  The calculations should go here
*/
void update(int delta) {
  if (!player.onFloor())
      player.acceleration.y = 0.5;
      
  player.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  
  stroke(200);
  line (0, floor, width, floor);
  
  player.display();
}

PVector forward = new PVector(1, 0);
PVector jumpForce = new PVector(0, -10);
PVector gravity = new PVector(0, 0.2);

void manageInputs() {
  if (keyPressed) {
    if (key == 'd') {
      player.applyForce(forward);
    }
    if (key == 'a') {
      player.applyForce(PVector.mult(forward, -1.0));
    }
  } else {
    if (player.onFloor()) {

      PVector friction = player.velocity.copy();
      
      friction.normalize();
      friction.mult(-1);
      friction.mult(0.2);
      
      player.applyForce(friction);
    }
  }
  
}

void keyPressed() {
  if (key == ' ') {
    if (player.onFloor()) {
      player.applyForce(jumpForce);
    }
  }
}

//Saving frames for video
//Put saveVideo to true;
int savingAcc = 0;
int nbFrames = 0;

void savingFrames(int forMS, int deltaTime) {
  
  if (!saveVideo) return;
  
  savingAcc += deltaTime;
  
  if (savingAcc < forMS) {
    saveFrame("frames/####.tiff");
	nbFrames++;
  } else {
	println("Saving frames done! " + nbFrames + " saved");
    saveVideo = false;
  }
}
