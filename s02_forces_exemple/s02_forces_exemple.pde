int previousMillis;
int deltaMillis;

int nbMovers = 25;

Mover[] movers;
float minMass = 0.1;
float maxMass = 5;


/** Forces */
boolean windEnabled = false;
PVector wind;
int windDir = 1;

boolean gravityEnabled = false;
PVector gravity;

boolean frictionEnabled = false;
PVector friction;

boolean fluidEnabled = false;
boolean dragFluid = false;


/** Scène */
Message msg;
String text;

Message instructions;

Fluid fluid;

Forces forces;

float worldScale = 0.9;
int worldX = 0;
int worldY = 0;

void setup () {
  size (800, 600);
  previousMillis = millis();
  deltaMillis = 0;
  
  worldY = (int)(height - (height * worldScale));
  
 
  initScene();
  initForces();
}

void draw () {
  deltaMillis = millis() - previousMillis;
  previousMillis = millis();
  
  update(deltaMillis);
  
  display();
    
}

void update(int delta) {
  
  updateText();
  
  for (int i = 0; i < movers.length; i++) {
    
    checkForces(movers[i]);

    movers[i].applyForce(wind);
    movers[i].applyGravity(gravity);
    movers[i].applyForce(friction);
    

    movers[i].update();
    movers[i].checkEdges();    
  }
}

void display() {
  background (255);
  
  msg.display();
  instructions.display();
  
  pushMatrix();
  scale(worldScale);
  translate (worldX, worldY);
  
  noFill ();
  rect (0, 0, width, height);
  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
  
  fluid.display();
  
  popMatrix();
}

void checkForces (Mover m) {
  
  if (windEnabled) {
    wind.set (0.005 * windDir, 0.0);
  }
  else {
    wind.set (0, 0);
  }
  
  if (gravityEnabled) {
      gravity = new PVector (0, 0.1);
  }
  else {
    gravity = new PVector (0, 0);
  }
  
  if (frictionEnabled) {
    if (m.hasContactWithFloor) {
      friction = forces.friction (m.velocity, .005, 1);
    }
  }
  else {
    friction.set (0, 0);
  }
  

  
  if (fluidEnabled) {
    if (fluid.getRectangle().intersect(m.getRectangle())) {   
      PVector fluidForce = fluid.draggingForce(m.velocity, m.mass);
      m.applyForce (fluidForce);
    }
  }
}


void initForces () {
  
  forces = new Forces();
  wind = new PVector(0, 0);
  gravity = new PVector (0, 0);
  friction = new PVector (0, 0);
}

void initScene() {
  int margin = 20;
  float textW = 100;
  
  msg = new Message ("Bonjour");
  textW = msg.getWidth(); 
  
  msg.setLocation (width - (textW + margin), 200);
  text = "";
  
  
  instructions = new Message ("Touches (V)ent - (G)ravité - (L)iquide - (F)riction - (R)eset");
  textW = instructions.getWidth();  
  instructions.setLocation (margin, margin);
  
  movers = new Mover[nbMovers];
  
  for (int i = 0; i < movers.length; i++) {
    float mass = random(minMass, maxMass);
    movers[i] = new Mover(mass, 0, 0);
    movers[i].location.set (random(movers[i].radius, width - movers[i].radius), movers[i].radius);
    
    // Ajouter un coefficient de restitution pour chaque
    // movers.
    movers[i].coeffRestitution = 1 - movers[i].mass / maxMass;
  }
  
  
  fluid = new Fluid();
  float fluidWidth  = random (width / 4, width / 2);
  float fluidHeight  = random (height / 8, height / 4);
  
  fluid.setRectangle (new Rectangle(random (0, width - fluidWidth), random(height / 2, height - fluidHeight), fluidWidth, fluidHeight));
  fluid.density = 2;
  fluid.setColor (color (100, 200, 100, 127));

}

void updateText() {
  text = "";
  
  if (gravityEnabled)
    text += "Gravité!\r\n";
  
  if (windEnabled)
    text += "Vent!\r\n";
    
  if (frictionEnabled)
    text += "Friction!\r\n";
  
  if (fluidEnabled)
    text += "Liquide!\r\n";
    
  msg.setText (text);
}

void reset() {
  initScene();
  initForces();
  
  windEnabled = false;
  gravityEnabled = false;
  frictionEnabled = false;
  fluidEnabled = false;
  dragFluid = false;
}

void keyPressed() {
  switch (key) {
    case 'l':
      fluidEnabled = !fluidEnabled;
      break;
    case 'v':
      windEnabled = !windEnabled;
      windDir = windDir * int(random(0, 1) < 0.5 ? -1: 1);
      break;
    case 'g':
      gravityEnabled = !gravityEnabled;
      break;
    case 'f':
      frictionEnabled = !frictionEnabled;
      break;
    case 'r':
      reset();
      break;
  }  
}

void keyReleased() {
  
}

void mousePressed() {
  // FIXME : Buggy 
  if (fluid.getRectangle().contains(mouseX,mouseY)) {
  //if (fluid.getRectangle().contains(mouseX + worldX, mouseY + worldY)) {
    dragFluid = true;
  }
  else {
    dragFluid = false;
  }
}

void mouseDragged() {
  if (dragFluid) {
    fluid.setLocation (int((mouseX - (int)(fluid.r.w / 2) / worldScale)), int((mouseY - (int)(fluid.r.h / 2)) / worldScale));
  }
}
