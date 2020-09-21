int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = true;

Something s;

void setup () {
  size (320, 240);
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

float dx, dy;

/***
  The calculations should go here
*/
void update(int delta) {
  dx = mouseX - s.location.x;
  dy = mouseY - s.location.y;
  
  s.velocity.x = dx / 50;
  s.velocity.y = dy / 50;
  
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
  
  msg = "Angle : " + nf(s.angle, 1, 4);
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
