int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

Something s;

void setup () {
  size (340, 240);
  currentTime = millis();
  previousTime = millis();
  
  s = new Something();
  s.location.x = width / 2;
  s.location.y = height / 2;
  
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
  if (mousePressed) {
    if (mouseButton == LEFT) {
      s.angularAcceleration = PI/360;
    } else if (mouseButton == RIGHT) {
      s.angularAcceleration = -PI/360;
    }
  }
  
  s.update(delta);  
}


String msg = "";
float txtWidth = 0;

/***
  The rendering should go here
*/
void display () {
  background(0);
  s.display();
  
  msg = "Vitesse angulaire : " + nf(s.angularVelocity, 3, 5);
  txtWidth = textWidth(msg);
  
  text(msg, 10, height - 10);
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
