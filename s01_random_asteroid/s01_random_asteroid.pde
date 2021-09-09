int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

ArrayList<PVector> asteroid;

int maxVertex = 100;
float incAngle = 360.0 / maxVertex;

float t = 0.0;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  
  resetAsteroid();

}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  savingFrames(5, deltaTime);  
}

/***
  The calculations should go here
*/
void update(int delta) {
  
}

void keyPressed() {
  if (key == 'r') {
      resetAsteroid();
  }
}

void resetAsteroid() {
  asteroid = new ArrayList<PVector>();
  float r = 0.0;
  float x;
  float y;
  
  for (int i = 0; i < maxVertex; i++) {
    r = map(noise(t), 0, 1, 30, 50);
    x = r * cos(i * incAngle * PI / 180);
    y = r * sin(i * incAngle  * PI / 180);
    
    t+= 0.08;
    PVector temp = new PVector(x, y);
    
    asteroid.add(temp);
  }
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  
  noFill();
  stroke(255);
  beginShape();
    for (PVector p : asteroid) {
      
      vertex(p.x + width/2, p.y + height/2);
    }
  endShape(CLOSE);
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
