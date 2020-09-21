int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = true;

SysSolaire sys;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = millis();

  sys = new SysSolaire();
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  savingFrames(10000, deltaTime);  
}

/***
  The calculations should go here
*/
void update(int delta) {
  sys.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  sys.display();
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
