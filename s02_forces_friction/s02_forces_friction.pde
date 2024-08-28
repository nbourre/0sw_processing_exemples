int nbMovers = 1;

Mover[] movers;


void setup () {
  size (800, 600);
  movers = new Mover[nbMovers];
  
  
  
  for (int i = 0; i < movers.length; i++) {
    //movers[i] = new Mover(random(0.1, 5), 0, 0);
    movers[i] = new Mover(1, width / 2, height / 2);
    movers[i].location.x = movers[i].size.x;
    movers[i].location.y = height - movers[i].size.y;
  }
  
  movers[0].setMass(2);
  movers[0].location.x = movers[0].size.x;
  movers[0].location.y = height - movers[0].size.y;
  
  
   
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
    friction.mult(0.03);
    
    if (mousePressed) {
      PVector wind = new PVector (.1, 0);
      movers[i].applyForce(wind);
    }

    //movers[i].applyForce(helium);
    movers[i].applyForce(friction);
    movers[i].update();
    movers[i].checkEdges();
  }
  
}




void render () {
  background (255);

  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
  
  saveFrame("d:/temp/proc_frames/####.tga");
}


void draw () {
  update();
  render();
    
}
