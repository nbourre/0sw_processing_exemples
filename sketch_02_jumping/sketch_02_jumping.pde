int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

Player player;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
    
  player = new Player();
  player.setWidth(50);
  player.setHeight(100);
  player.setXY(width / 2 - player.getWidth(), height - 200);
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
  player.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  player.display();
}

PVector forward = new PVector(1, 0);

void manageInputs() {
  if (keyPressed) {
    if (key == 'd') {
      player.applyForce(forward);
    }
    if (key == 'a') {
      player.applyForce(PVector.mult(forward, -1.0));
    }
  } else {
    PVector friction = player.velocity.copy();
    
    friction.normalize();
    friction.mult(-1);
    friction.mult(0.02);
    
    player.applyForce(friction);
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
