int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;



void setup () {
  size (800, 600, P2D);
  currentTime = millis();
  previousTime = millis();
  
  generateCloud();
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  //savingFrames(5, deltaTime);  
}


void generateCloud() {
  float v = 0.0;
  float xOff = 0.0;
  float yOff = 0.0;
  color c = 0;
  
  float inc = 0.01;
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      
      v = noise(xOff, yOff) * 255;
      
      c = (int)v;
      
      stroke(c);
      point(i, j);
      
      xOff += inc;
    }
    yOff += inc;
    xOff = 0.0;
  }
}
/***
  The calculations should go here
*/
void update(int delta) {
  
}

/***
  The rendering should go here
*/
void display () {

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
