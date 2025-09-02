int previousMillis;
int deltaMillis;

int nbMovers = 10;

Mover[] movers;

// Forces
GravityForce gravityForce;
WindForce windForce;
FrictionForce frictionForce;
FluidForce fluidForce;

Force[] forces;

void setup() {
  size(800, 600);
  previousMillis = millis();
  deltaMillis = 0;
  
  initScene();
  initForces();
}

void draw() {
  deltaMillis = millis() - previousMillis;
  previousMillis = millis();
  
  update(deltaMillis);
  display();
}

void update(int deltaTime) {
  for (int i = 0; i < movers.length; i++) {
    // Appliquer toutes les forces actives
    for (int j = 0; j < forces.length; j++) {
      if (forces[j].isEnabled()) {
        PVector force = forces[j].calculate(movers[i].location, movers[i].velocity, movers[i].mass, deltaTime);
        movers[i].applyForce(force);
      }
    }
    
    movers[i].update(deltaTime);
    movers[i].checkEdges(width, height);
  }
}

void display() {
  background(255);
  
  // Afficher les forces
  fill(0);
  textSize(16);
  text("Forces actives:", 10, 20);
  
  for (int i = 0; i < forces.length; i++) {
    if (forces[i].isEnabled()) {
      text("- " + forces[i].name, 10, 40 + i * 20);
    }
  }
  
  // Afficher le fluide
  if (fluidForce.isEnabled()) {
    fill(100, 200, 100, 127);
    rect(fluidForce.location.x, fluidForce.location.y, fluidForce.size.x, fluidForce.size.y);
  }
  
  // Afficher les mouvements
  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
}

void initForces() {
  gravityForce = new GravityForce();
  windForce = new WindForce();
  frictionForce = new FrictionForce();
  fluidForce = new FluidForce();
  
  forces = new Force[] {gravityForce, windForce, frictionForce, fluidForce};
}

void initScene() {
  movers = new Mover[nbMovers];
  
  for (int i = 0; i < movers.length; i++) {
    float mass = random(0.5, 3);
    movers[i] = new Mover(mass, random(50, width - 50), random(50, height / 2));
  }
}

void keyPressed() {
  switch (key) {
    case 'g':
      gravityForce.setEnabled(!gravityForce.isEnabled());
      break;
    case 'v':
      windForce.setEnabled(!windForce.isEnabled());
      windForce.changeDirection();
      break;
    case 'f':
      frictionForce.setEnabled(!frictionForce.isEnabled());
      break;
    case 'l':
      fluidForce.setEnabled(!fluidForce.isEnabled());
      break;
    case 'r':
      reset();
      break;
  }
}

void reset() {
  initScene();
  initForces();
}
