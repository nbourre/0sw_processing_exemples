int nbMovers = 100;

Mover[] movers;

void setup () {
  size (800, 600);
  movers = new Mover[nbMovers];
  
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }
  
}

void draw () {
  update();
  
  background (255);

  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
  
    
}

void update() {
  for (int i = 0; i < movers.length; i++) {
    PVector wind = new PVector(0.001, 0);
    
    float m = movers[i].mass;
    
    PVector gravity = new PVector (0, 0.1 * m);

    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].checkEdges();
  }
  
}

