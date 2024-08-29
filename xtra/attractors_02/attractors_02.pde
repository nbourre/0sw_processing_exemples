int nbMovers = 25;

int lineInterval = 5000;
int linePrevious = 0;
int currentTime;
int previousTime = 0;
int deltaTime = 0;
int moverIndex = 0;


Attractor[] movers = new Attractor[nbMovers];

float attractorToCorner;

void setup() {
  //fullScreen(1);
  size (640, 480);
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i] = new Attractor(random(width), random(height), random(0.1, 2));
  }
  
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
  
}

void update(int deltaTime) {
  for (int i = 0; i < nbMovers; i++) {
    for (int j = 0; j < nbMovers; j++) {
      
      if (i != j) {
        var force = movers[j].attractionForce(movers[i]);
        movers[i].applyForce(force);
      }
    }
    
    movers[i].update(deltaTime);
  }
}

void display() {  
  
  background (255);
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i].display();
  }
  
}
