int currentTime;
int previousTime;
int deltaTime;

ArrayList<Boid> flock;
int flockSize = 50;

boolean debugMode = false;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  flock = new ArrayList<Boid>();
  
  for (int i = 0; i < flockSize; i++) {
    Boid m = new Boid(new PVector(random(0, width), random(0, height)), new PVector(random (-5, 5), random(-5, 5)));
    m.fillColor = color(random(255), random(255), random(255));
    flock.add(m);
  }
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();  
}

/***
  The calculations should go here
*/
void update(int delta) {
  
  for (Boid m : flock) {
    
    m.update(delta);
  }
}

color saveColor = color(255);
/***
  The rendering should go here
*/
void display () {
  background(0);
  
  for (Boid m : flock) {
    m.display();
  }
}

color oldColor;

void keyPressed() {
  if (key == 'i') {
    debugMode = !debugMode;
    
    // Mets en évidence le dernier boids
    for (Boid m : flock) {
    
      if (debugMode) {
        if (m != flock.get(flock.size() - 1)) {
          m.SetAlpha(100);
        } else {
          oldColor = m.fillColor;
          m.fillColor = color (0, 255, 0);
        }
      } else {
        if (m == flock.get(flock.size() - 1)) {
          m.fillColor = oldColor;
        }
        
        m.SetAlpha(255);       
      }
    }
  }
}
