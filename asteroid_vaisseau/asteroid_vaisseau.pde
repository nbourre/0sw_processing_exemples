int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

Vaisseau v;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  v = new Vaisseau();
  v.location.x = width / 2;
  v.location.y = height / 2;
  
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  savingFrames(5, deltaTime);  
}

PVector thrusters = new PVector(0, -0.02);

/***
  The calculations should go here
*/
void update(int delta) {
  if (keyPressed) {
    switch (key) {
      case ' ':
        v.thrust();
        break;
      case CODED:
        if (keyCode == LEFT) v.pivote(-.03);
        if (keyCode == RIGHT) v.pivote(.03);
        break;
    }
  }
  
  v.update(delta);
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  
  v.display();
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



void keyReleased() {
    switch (key) {
      case ' ':
        v.noThrust();
        break;
    }  
}
