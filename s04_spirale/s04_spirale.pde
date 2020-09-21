int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

void setup () {
  size (320, 240);
  currentTime = millis();
  previousTime = millis();
  
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  savingFrames(20000, deltaTime);  
}

float theta = 0;
float r = 5;
float x, y;

/***
  The calculations should go here
*/
void update(int delta) {
  theta += PI/120.0;
  r += 0.1;
  
  x = r * cos(theta);
  y = r * sin(theta);
}

/***
  The rendering should go here
*/
void display () {

  ellipse(width / 2 + x, height /2 + y, 10, 10);

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
