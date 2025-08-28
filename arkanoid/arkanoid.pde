int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

Destroyer b;
Block blk;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  b = new Destroyer(width / 2, height / 2);
  blk = new Block();
  blk.addCollidable(b);
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
  blk.update(delta);
  b.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  blk.display();
  b.display();
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
