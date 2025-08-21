int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

ArrayList<PVector> asteroid;

ArrayList<Asteroid> asteroids;

int maxAsteroids = 20;

int maxVertex = 100;
float incAngle = 360.0 / maxVertex;

float t = 0.0;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  asteroids = new ArrayList<Asteroid>();
  
  for (int i = 0; i < maxAsteroids; i++) {
    var temp = new Asteroid(random(60, width - 60), random(60, height - 60));
    asteroids.add(temp);
  }
  
  //resetAsteroid();

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
  for (var a : asteroids) {
    a.update(delta);
  }
}

void keyPressed() {
  //if (key == 'r') {
  //    resetAsteroid();
  //}
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
  background(255);
  
  for (Asteroid a : asteroids) {
    a.display(); //<>//
  }
  
  
  //pushMatrix();
  //translate( width / 2, height / 2);
  
  //for (int i = 1; i < maxVertex; i++) {
  //  line (asteroid.get(i - 1).x, asteroid.get(i - 1).y,
  //    asteroid.get(i).x, asteroid.get(i).y);
  //}
  
  //line(asteroid.get(maxVertex - 1).x, asteroid.get(maxVertex - 1).y,
  //  asteroid.get(0).x, asteroid.get(0).y);
  
  //popMatrix();
  
  

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
