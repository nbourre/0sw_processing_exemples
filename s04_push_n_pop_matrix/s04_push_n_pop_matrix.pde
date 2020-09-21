nt currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = millis();
  
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  
  update(deltaTime);
  display();
  
  savingFrames(10000, deltaTime);
  
}

float angle = 0.0;

/***
  The calculations should go here
*/
void update(int delta) {
  angle += PI/180;
}

int lineLength = 100;
int shortLine = lineLength / 10;

/***
  The rendering should go here
*/
void display () {
  background(0);
  pushMatrix();
    translate(width / 2, height / 2);
    rotate(angle);
    
    stroke(255);
    line (-lineLength, 0, lineLength, 0);
    
    pushMatrix();
      translate (-lineLength, 0);
      rotate(-angle * 2);
      line (0, -shortLine, 0, shortLine);
    popMatrix();
    
    pushMatrix();
      translate (lineLength, 0);
      rotate(-angle * 2);
      line (0, -shortLine, 0, shortLine);
    popMatrix();
    
  popMatrix();
}

int savingAcc = 0;
int nbFrames = 0;

void savingFrames(int forMS, int deltaTime) {
  
  if (!saveVideo) return;
  
  savingAcc += deltaTime;
  
  if (savingAcc < forMS) {
    saveFrame("frames/####.tiff");
    nbFrames++;
  } else {
    println("Saving video done! " + nbFrames + " saved");
    nbFrames = 0;
    saveVideo = false;
  }
}
