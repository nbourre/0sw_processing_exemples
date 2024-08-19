int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

Circle a;
Circle b;

private DebugLine debugLine;

boolean debug = true;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = millis();
  
  a = new Circle(width / 2, height / 2, 50);
  a.fillColor = color (200, 200, 0);
  
  b = new Circle();
  b.setRadius(30);
  
}




void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  //if (currentTime < 8000) return;
  
  update(deltaTime);
  display();
  
  savingFrames(10000, deltaTime);  
}

/***
  The calculations should go here
*/
void update(int delta) {
  b.location.x = mouseX;
  b.location.y = mouseY;
  
  if (b.isCollidingCircle(a)) {
    b.fillColor = color (200, 0, 0, 127);
  } else {
    b.fillColor = color (0, 200, 0);
  }
  
  updateDebug();
}

/***
  The rendering should go here
*/
void display () {
  background(255);
  
  a.display();
  b.display();
  
  displayDebug();

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

void updateDebug() {
  if (!debug) return;
  
  if (debugLine == null) {
    debugLine = new DebugLine(a.location.x, a.location.y, b.location.x, b.location.y);
  } else {
    debugLine.setStart(a.location.x, a.location.y);
    debugLine.setEnd(b.location.x, b.location.y);
  }
}

void displayDebug() {
  if (!debug) return;
  
  if (debugLine == null) return;
  
  debugLine.display();

}
