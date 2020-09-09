int nbMovers = 10;

Mover[] movers;
Fluid fluid;
Fluid fluid2;

void setup () {
  size (800, 600);
  movers = new Mover[nbMovers];
  
  fluid = new Fluid();
  fluid2 = new Fluid();
  
  fluid2.setRectangle( new Rectangle(0, height / 3, width, height / 8));
  fluid2.density = 2;
  
  
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
    movers[i].mass = random (1, 5);
    movers[i].location.x = 30 + i * (width / nbMovers);
    movers[i].location.y = movers[i].size.y;
  }
}

float xOff = 0.0;
float n;

void update() {
  
  for (int i = 0; i < movers.length; i++) {
  
    PVector helium = new PVector (0, -0.01);
    
    float m = movers[i].mass;
    
    PVector gravity = new PVector (0, 0.1 * m);
    
    PVector friction = movers[i].velocity.get();
    
    friction.normalize();
    friction.mult(-1);
    friction.mult(0.02);
    
    if (mousePressed) {
      PVector wind = new PVector (.1, 0);
      movers[i].applyForce(wind);
    }
    
    if (fluid.getRectangle().intersect(movers[i].getRectangle())) {   
      PVector fForce = fluid.draggingForce(movers[i].velocity, movers[i].mass);
      movers[i].applyForce(fForce);
    }
    
    if (fluid2.getRectangle().intersect(movers[i].getRectangle())) {   
      PVector fForce = fluid2.draggingForce(movers[i].velocity, movers[i].mass);
      movers[i].applyForce(fForce);
    }
    
    movers[i].applyForce(gravity);
    movers[i].applyForce(friction);
    movers[i].update();
    movers[i].checkEdges();
  }  
}

void keyPressed() {
  if (key == ' ') {
    for (int i = 0; i < movers.length; i++) {
      movers[i].location.y = movers[i].size.y;
    }
  }
}


void render () {
  background (255);
  
  fluid.display();
  
  fill(100, 200, 100);
  fluid2.display();

  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
}



void draw () {
  update();
  render();
    
}
